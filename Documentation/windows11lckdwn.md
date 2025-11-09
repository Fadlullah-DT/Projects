# Ansible lockdown for windows 11

This Documentation is follows my windows 11 hardening using the ansible-lockdown-windows-11-cis role.m

## setting up windows vm

after creating the vm,installing all the drivers and the guest agent using the virtio. make sure that you can ping the vm ip from your local machine.

eg ping 192.168.0.115
    if succeful continue to section 1 of this walk through
    if you recieve no responsse go on proxmox to another vm on the same network and try pinging the windwos 11 vm if no success go on the windows vm and try pinging the other vm on the same network.
    no we know that windwos vm is able to ping other devices but we cant ping the windows vm so the issue could be with the icmp fiewall rule on your windwos vm run this     (Get-NetFirewallPortFilter -Protocol icmpv4 | Get-NetFirewallRule | ft name,enabled,direction,action) this will show all icmpv4 firewall rules look for the rule that includes ICMP4-ERQ-in (this is for inbound icmpv4 echo requests) it is is disabled or false enable it
        this (Get-NetFirewallRule -DisplayGroup "File and Printer Sharing" | Select-Object Name, Enabled, Direction) will get all the file and printer sharing firewall rules
    to enable the ERQ-in firewall rule (Enable-NetFirewallRule -Name FPS-ICMP4-ER-In)
    Verify that you can now ping by pinging the the device ip from your local machine again.

#### Configure winrm on widodows for ansible

setup of Winrm

```powershell
Enable-PSRemoting -Force
# Configures the computer to receive remote PowerShell commands
# Starts WinRM service and sets it to auto-start
# Creates firewall exceptions for remote access (incoming connection on ports 5985(HTTP) and 5986(HTTPS))

Set-WSManQuickConfig -Force
# Configures the WS-Management protocol for WinRM
# Starts WinRM service and enables listeners
# Redundant if Enable-PSRemoting already ran

winrm quickconfig 
# COnfigures WinRM with default settings
# (winrm quickconfig -transport:https) creates a HTTPS listener

# Creating a custom winrm listener using https transport
# creating a new self signed certificate on the windows vm

$Hostname = [System.Net.Dns]::GetHostByName($env:computerName).HostName
$Cert = New-SelfSignedCertificate -Subject "CN=$Hostname" -TextExtension '2.5.29.37={text}1.3.6.1.5.5.7.3.1' -CertStoreLocation Cert:\LocalMachine\My
$Thumbprint = $Cert.Thumbprint

# viewing the slef signed certificate that was created

(Get-ChildItem Cert:\LocalMachine\My | Where-Object {$_.Subject -like "*CN=$Hostname*"}).Thumbprint

# creating the custom winrm listener using the self signed certificate

winrm create winrm/config/Listener?Address=*+Transport=HTTPS '@{Hostname="$Hostname";CertificateThumbprint="$Thumbprint"}'

# replace $Hostname with the actual hostname and $Thumbprint with the certificate's thumbprint.

```

check if the winrm firewall rule is enable/exist if not create the firewall rule that will allow winrm traffic on port 5986

```powershell
Get-NetFirewallRule -DisplayName "*WinRM*" | ft DisplayName, Enabled

# nothing showed up after running this do the winrm firewallrule does not exist 

New-NetFirewallRule -Name "AllowWinRM_HTTPS" -DisplayName "Allow WinRM HTTPS" ` -Enabled True -Direction Inbound -Protocol TCP -LocalPort 5986 -Action Allow

# this creates the firewall rule for winrm allowing traffice on port 5986
```

```powershell

# enable credssp on windows

# On the Windows VM (as Administrator):
Enable-WSManCredSSP -Role Server
Set-Item -Path WSMan:\localhost\Service\Auth\CredSSP -Value $true
Restart-Service WinRM

# Verify:
Get-Item -Path WSMan:\localhost\Service\Auth\CredSSP

# It should say:

Value : true

```

Changing network connection from public to private 

```powershell

# lsit network 
profiles 
Get-NetConnectionProfile

Set-NetConnectionProfile -Name "YourNetworkName" -NetworkCategory Private

Set-NetConnectionProfile -InterfaceIndex YourInterfaceIndex -NetworkCategory Private

```

#### ansible control node

this is the machine that will be used to run the ansible playboo


winping playpook to test the connection to the windows vm

```yml
- name: Test WinRM connection to Windows hosts
  hosts: windows
  gather_facts: false
  vars_files:
    - /home/fadmin/WindowsHardening/ansible_windows_cis/group_vars/windows/vault.yml
  tasks:
    - name: Ensure we can ping WinRM
      win_ping:

    - name: Show connection details (for debug)
      debug:
        msg: "Connected to {{ inventory_hostname }} via {{ ansible_winrm_scheme }}:{{ ansible_port }} as {{ ansible_user }}"
      when: ansible_user is defined 

```

inventory playbook

```yml

all:
  children:
    windows:
      hosts:
        Win11-103125:
          ansible_host: 172.16.3.204
          ansible_port: 5986
      vars:
        ansible_connection: winrm
        ansible_winrm_scheme: https
        ansible_winrm_transport: credssp
        ansible_winrm_server_cert_validation: ignore


```


main playbook

```yml
---
- name: Apply CIS Benchmark to Windows 11
  hosts: windows
  gather_facts: yes
  roles:
    - role: ansible-lockdown.windows_11_cis

  vars:
    win11cis_rule_5_20: false  # Skip disabling Remote Desktop Configuration (SessionEnv)
    win11cis_rule_5_21: false  # Skip disabling Remote Desktop Services (TermService)
    win11cis_rule_5_39: false  # Skip disable Windows Remote Management (WS-Management) (WinRM)
    # rule_19.5.1.1: false
  
```
