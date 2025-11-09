# Ansible Lockdown for Windows 11

This documentation follows my Windows 11 hardening using the ansible-lockdown-windows-11-cis role.

## Table of Content

- [Ansible Lockdown for Windows 11](#ansible-lockdown-for-windows-11)
  - [Table of Content](#table-of-content)
  - [Setting Up Windows VM](#setting-up-windows-vm)
    - [Configure WinRM on Windows for Ansible](#configure-winrm-on-windows-for-ansible)
    - [Ansible Control Node](#ansible-control-node)

## Setting Up Windows VM

After creating the VM, installing all the drivers and the guest agent using VirtIO, make sure that you can ping the VM IP from your local machine.

Example: `ping 192.168.0.115`

- If successful, continue to Section 1 of this walkthrough.
- If you receive no response, go on Proxmox to another VM on the same network and try pinging the Windows 11 VM. If unsuccessful, go on the Windows VM and try pinging the other VM on the same network.

Now we know that the Windows VM is able to ping other devices, but we can't ping the Windows VM, so the issue could be with the ICMP firewall rule on your Windows VM.

Run this command:

```powershell
Get-NetFirewallPortFilter -Protocol icmpv4 | Get-NetFirewallRule | ft name,enabled,direction,action

# This will show all ICMPv4 firewall rules. Look for the rule that includes `ICMP4-ERQ-In` (this is for inbound ICMPv4 echo requests). If it is disabled or false, enable it.

# This command will get all the file and printer sharing firewall rules:

Get-NetFirewallRule -DisplayGroup "File and Printer Sharing" | Select-Object Name, Enabled, Direction

# To enable the ERQ-In firewall rule:

Enable-NetFirewallRule -Name FPS-ICMP4-ERQ-In


Get-NetFirewallRule -DisplayGroup "File and Printer Sharing" | Select-Object Name, Enabled, Direction 

# will get all the file and printer sharing firewall rules
```

Verify that you can now ping by pinging the device IP from your local machine again.

### Configure WinRM on Windows for Ansible

Setup of WinRM:

```powershell
Enable-PSRemoting -Force
# Configures the computer to receive remote PowerShell commands
# Starts WinRM service and sets it to auto-start
# Creates firewall exceptions for remote access (incoming connection on ports 5985 (HTTP) and 5986 (HTTPS))

Set-WSManQuickConfig -Force
# Configures the WS-Management protocol for WinRM
# Starts WinRM service and enables listeners
# Redundant if Enable-PSRemoting already ran

winrm quickconfig 
# Configures WinRM with default settings
# (winrm quickconfig -transport:https) creates an HTTPS listener

# Creating a custom WinRM listener using HTTPS transport
# Creating a new self-signed certificate on the Windows VM

$Hostname = [System.Net.Dns]::GetHostByName($env:computerName).HostName
$Cert = New-SelfSignedCertificate -Subject "CN=$Hostname" -TextExtension '2.5.29.37={text}1.3.6.1.5.5.7.3.1' -CertStoreLocation Cert:\LocalMachine\My
$Thumbprint = $Cert.Thumbprint

# Viewing the self-signed certificate that was created

(Get-ChildItem Cert:\LocalMachine\My | Where-Object {$_.Subject -like "*CN=$Hostname*"}).Thumbprint

# Creating the custom WinRM listener using the self-signed certificate

winrm create winrm/config/Listener?Address=*+Transport=HTTPS '@{Hostname="$Hostname";CertificateThumbprint="$Thumbprint"}'

# Replace $Hostname with the actual hostname and $Thumbprint with the certificate's thumbprint.
```

Check if the WinRM firewall rule is enabled/exists. If not, create the firewall rule that will allow WinRM traffic on port 5986:

```powershell
Get-NetFirewallRule -DisplayName "*WinRM*" | ft DisplayName, Enabled

# Nothing showed up after running this, so the WinRM firewall rule does not exist 

New-NetFirewallRule -Name "AllowWinRM_HTTPS" -DisplayName "Allow WinRM HTTPS" `
-Enabled True -Direction Inbound -Protocol TCP -LocalPort 5986 -Action Allow

# This creates the firewall rule for WinRM allowing traffic on port 5986
```

Enable CredSSP on Windows:

```powershell
# On the Windows VM (as Administrator):
Enable-WSManCredSSP -Role Server
Set-Item -Path WSMan:\localhost\Service\Auth\CredSSP -Value $true
Restart-Service WinRM

# Verify:
Get-Item -Path WSMan:\localhost\Service\Auth\CredSSP

# It should say:
Value : true
```

Changing network connection from public to private:

```powershell
# List network profiles 
Get-NetConnectionProfile

Set-NetConnectionProfile -Name "YourNetworkName" -NetworkCategory Private

Set-NetConnectionProfile -InterfaceIndex YourInterfaceIndex -NetworkCategory Private
```

### Ansible Control Node

This is the machine that will be used to run the Ansible playbook.

WinPing playbook to test the connection to the Windows VM:

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

Inventory playbook:

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

Main playbook:

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

uw4CpIWdsj4zKEl