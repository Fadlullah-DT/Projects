# Windows 11  Hardening with Ansible

## Table of Contents

- [Windows 11  Hardening with Ansible](#windows-11--hardening-with-ansible)
  - [Table of Contents](#table-of-contents)
  - [1. Initial WinRM Setup for Ansible](#1-initial-winrm-setup-for-ansible)
  - [1.1 Setting up windows for ansible (On the Windows VM)](#11-setting-up-windows-for-ansible-on-the-windows-vm)
    - [1.2 Inventory file for Ansible](#12-inventory-file-for-ansible)
    - [1.3 Test connection](#13-test-connection)
  - [3. Running the Hardening / Lockdown Playbook](#3-running-the-hardening--lockdown-playbook)
  - [4. Post-Hardening Adjustments \& Remote Access](#4-post-hardening-adjustments--remote-access)

## 1. Initial WinRM Setup for Ansible

## 1.1 Setting up windows for ansible (On the Windows VM)

Quick setup of Winrm

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


```

Note: Requires administrator privileges. Enable-PSRemoting is typically sufficient on its own.

### 1.2 Inventory file for Ansible

These are the various ways to connect to the windows I used most of these when trying to connect

```yml
all:
  hosts:
    win11:
      ansible_host: # IP address or hostname of the Windows machine
      ansible_user: # Windows account username for authentication
      ansible_password: # Windows account password for authentication
      ansible_connection: winrm # Use WinRM protocol to connect to Windows hosts
      ansible_winrm_transport: basic # Simple username/password authentication (less secure)
      ansible_connection: winrm
      ansible_winrm_transport: ntlm # Authentication method using NTLM (New Technology LAN Manager)
      ansible_connection: winrm
      ansible_winrm_transport: credssp # Alternative auth method with credential delegation
      ansible_connection: psr # Alternative connection using PowerShell Remoting Protocol
      ansible_psrp_auth: credssp # Authentication method for PSRP connection
      ansible_connection: winrm
      ansible_winrm_transport: basic
      ansible_winrm_port: 5986 # HTTPS port for WinRM (5985 HTTP)
      ansible_winrm_server_cert_validation: ignore # Skips SSL certificate validation
```

- *Note do not use these straight like this chose which connection and transport pair to test/work with (eg winrm +basic or winrm+ntlm)*

### 1.3 Test connection

From the control node I ran:

```bash
ansible -i windows11.yml win11 -m win_ping -vv
```

Expected result: *if you have configured the winrm listeners and ports are using the proper connection and transport that is allowed on your server*

```json
win11 | SUCCESS => {
  "changed": false,
  "ping": "pong"
}
```

## 3. Running the Hardening / Lockdown Playbook

- clone the github repo that has the Windows Lockdown role/playbook for Windows 11.(git clone <https://github.com/ansible-lockdown/Windows-2022-CIS.git>)
- the first run the connection dropped because one of the tasks disabled the WinRM service. I changed that specific task/variable to `false` (i.e., do *not* disable WinRM) so I could maintain management connectivity.
- After adjusting YAML formatting issues (missing colons, indent issues) the playbook ran successfully with only minor errors.

---

## 4. Post-Hardening Adjustments & Remote Access

After hardening:

- Remote Desktop Protocol (RDP) was disabled which is good for security, but still needed for admin access.
  **Steps to allow RDP for administrators only:**

- Use Group Policy Management
  - In `Computer Configuration → Policies → Windows Settings → Security Settings → Local Policies → User Rights Assignment` edit **Allow log on through Remote Desktop Services** to include only `Administrators`.

---

[Installation and configuration for Windows Remote Management](https://learn.microsoft.com/en-us/windows/win32/winrm/installation-and-configuration-for-windows-remote-management)

[Managing Windows hosts with Ansible](https://docs.ansible.com/ansible/latest/os_guide/intro_windows.html?utm_source=chatgpt.com)

[Enhancing WinRM Security: Best Practices for Windows](https://wafatech.sa/blog/windows-server/windows-security/enhancing-winrm-security-best-practices-for-windows-server-administration/?utm_source=chatgpt.com)

[WinRM Security - Microsoft Q&A](https://learn.microsoft.com/en-us/answers/questions/1294386/winrm-security?utm_source=chatgpt.com)

[Security considerations for PowerShell Remoting using](https://learn.microsoft.com/en-us/powershell/scripting/security/remoting/winrm-security?view=powershell-7.5&utm_source=chatgpt.com)

[Hardening Microsoft Windows 10 and Windows 11](https://www.cyber.gov.au/sites/default/files/2024-07/PROTECT%20-%20Hardening%20Microsoft%20Windows%2010%20and%20Windows%2011%20Workstations%20%28July%202024%29.pdf?utm_source=chatgpt.com)

[Ansible Lockdown: The Ultimate Step-by-Step Guide to Security Hardening & Compliance](https://medium.com/@rajkumarkumawat/ansible-lockdown-the-ultimate-step-by-step-guide-to-security-hardening-compliance-9e2ee0a4472d)

[Ansible-Lockdown](https://ansible-lockdown.readthedocs.io/en/latest/index.html)
