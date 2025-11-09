# Windows Server 2022 Hardening with Ansible Lockdown

## Table of Contents

- [Windows Server 2022 Hardening with Ansible Lockdown](#windows-server-2022-hardening-with-ansible-lockdown)
  - [Table of Contents](#table-of-contents)
  - [Overview](#overview)
  - [Phase 1: VM \& OS Preparation](#phase-1-vm--os-preparation)
  - [Phase 2: WinRM \& Ansible Configuration](#phase-2-winrm--ansible-configuration)
    - [On the **Windows Server 2022** (Target)](#on-the-windows-server-2022-target)
    - [On the **Windows 11 Ansible Control Node**](#on-the-windows-11-ansible-control-node)
  - [Phase 3: Applying the CIS Benchmark](#phase-3-applying-the-cis-benchmark)
    - [1. Role Installation](#1-role-installation)
    - [2. Execute the playbook](#2-execute-the-playbook)
  - [Phase 4: Validation \& Testing](#phase-4-validation--testing)
    - [🔹 Post-Hardening Checks](#-post-hardening-checks)

---

## Overview

This documentation outlines the process of **hardening a Windows Server 2022 system** using the **Ansible Lockdown CIS Benchmark role**.
The setup is based on a **Proxmox lab environment** where:

- A **Windows 11** acts as the **Ansible control node**.
- A **Windows Server 2022** VM acts as the **Domain Controller (DC)** for testing.
- All management is done remotely via **WinRM** and **Ansible automation**.

---

## Phase 1: VM & OS Preparation

1. **Deploy the VM**

   - Created a Windows Server 2022 Standard Edition VM in **Proxmox**.
   - Assigned appropriate CPU, memory, and storage.
   - Installed all latest Windows Updates.

2. **System Configuration**

   - Renamed server: `WIN-DC01`
   - Joined domain: `Demo.AMJC.com`
   - Installed Active Directory Domain Services (AD DS) and promoted to domain controller.

---

## Phase 2: WinRM & Ansible Configuration

### On the **Windows Server 2022** (Target)

```powershell
Enable-PSRemoting -Force
winrm quickconfig
winrm set winrm/config/service/Auth '@{Basic="true"}'
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
Restart-Service WinRM
winrm enumerate winrm/config/listener
```

### On the **Windows 11 Ansible Control Node**

1. Installed **Ansible** via **WSL** or **Python environment**.

2. Installed required Python modules:

   ```bash
   pip install pywinrm passlib jmespath lxml xmltodict
   ```

3. Created **Ansible inventory** (`inventory.ini`):

   ```ini
   [windows_servers]
   win-dc01.Demo.AMJC

   [windows_servers:vars]
   ansible_user=Demo\Administrator
   ansible_password=YourSecurePassword
   ansible_connection=winrm
   ansible_winrm_transport=basic
   ansible_winrm_server_cert_validation=ignore
   ```

4. Verified connection:

   ```bash
   ansible -i inventory.ini windows_servers -m win_ping
   ```

---

## Phase 3: Applying the CIS Benchmark

### 1. Role Installation

```bash
git clone https://github.com/ansible-community/ansible-lockdown.git
```

### 2. Execute the playbook

```bash
ansible-playbook -i winserver.yml site.yml -vvv 
```

---

## Phase 4: Validation & Testing

### 🔹 Post-Hardening Checks

| Validation Area       | Description                                                     |
| --------------------- | --------------------------------------------------------------- |
| **Account Policies**  | Administrator renamed or protected, Guest disabled              |
| **Firewall**          | Domain profile active, restrictive inbound rules                |
| **Audit Policy**      | Logon events, privilege use, and object access auditing enabled |
| **Remote Access**     | RDP restricted to admin group, NLA enabled                      |

---
