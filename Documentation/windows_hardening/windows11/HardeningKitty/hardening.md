# Windows Server Hardening Project

## Overview

This project focuses on hardening a Windows 11 environment using **HardeningKitty**, an open-source Windows security auditing and hardening tool. The goal is to improve the system’s security posture, reduce attack surface, and gain practical experience in Windows hardening.

---

## Environment Setup

- **Platform:** Proxmox Virtual Environment  
- **OS:** Windows 11 pro  
- **Tool Used:** HardeningKitty PowerShell script  
- **Mode of Execution:** Local ran directly on the machine(recommended to run in a VM for testing)

---

## 🔒 Hardening Process

### 1. Preparation

Before running HardeningKitty:

- Created a **System Restore Point** to allow rollback in case of misconfiguration.
- Verified administrator privileges.
- Researched multiple Windows hardening resources online to understand best practices.

### 2. HardeningKitty Execution

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

    # this will allow for the script to run without any issues
    
Import-Module .\HardeningKitty.psm1

    # this will import the module for hardening kitty to run the audit
```

#### Audit Mode

- Command used:
  
  ```powershell
  Invoke-HardeningKitty -Mode Audit -Log -Report
  ```

- This mode compares the system’s current configuration to HardeningKitty’s security baseline.
- It generated two reports saved to current directory:
  - **TXT Report:** Summary of findings
  - **CSV File:** Comparison of settings vs baseline
- The audit did **not** change any system settings.
- The tool provided a **security score (1–6)** — 1 being *insufficient* and 6 being *excellent*.

#### Config Mode

- Command used:

  ```powershell
  Invoke-HardeningKitty -Mode Config -Report -ReportFile C:\\Users\Fadlullah LC\code\WindowsHardening\my_hardeningkitty_report.csv
  ```

- This will create a config report for your current configuration and save it to the specified file path

##### Config Backup Mode

- Command used:

  ```powershell
  Invoke-HardeningKitty -Mode Config -Backup
  ```

- Saves a backup of the current system configuration to a findings list.
- Used in case restoration is needed later.

#### ⚡ HailMary Mode

- Command used:

  ```powershell
  Invoke-HardeningKitty -Mode HailMary -Log -Report -FileFindingList .\lists\finding_list_0x6d69636b_machine.csv
  ```

- Applied the hardening measures automatically using the default findings list.
- Custom findings lists can be used for tailored configurations.

- To restore using the saved Backup findings lsit:
  
  ```powershell
  Invoke-HardeningKitty -Mode HailMary -Log -Report -FileFindingList .\lists\hardeningkitty_desktop-ud5qc2k_config_backup-20251009.csv
  ```

---

## ⚠️ Issues Encountered

### Microsoft Account Lockout

- HardeningKitty disables the ability to log in with a Microsoft account.
- The system only had a Microsoft account user → resulted in being locked out after reboot.
- Unable to restore due to BitLocker recovery key not backed up.
- Performed a **fresh Windows installation** and repeated setup.

### Second Attempt (Successful)

- Created a **Local Administrator** account.
- Disabled **BitLocker** before running the script.
- Reran HardeningKitty successfully and logged in normally afterward.

---

## 🔍 Verification & Testing

### 1. Compare Audit Reports

Compared **before** and **after** audit reports to see the improvement.

| Category               | Before | After | Notes                        |
| ---------------------- | ------ | ----- | ---------------------------- |
| Account Lockout Policy | 2      | 6     | Lockout after 5 attempts     |
| PowerShell Logging     | 1      | 6     | Script block logging enabled |
| Firewall               | 4      | 6     | Inbound rules restricted     |

---

### 2. Local Security Policy Check

Opened `secpol.msc` and verified:

- **Password Policies**: Complexity and expiration enforced.
- **Account Lockout**: Active.
- **Security Options**: Guest account disabled, anonymous access restricted.
- **Audit Policy**: Success/failure auditing enabled.

---

### 3. Disabled Services

Checked disabled services using PowerShell:

```powershell
Get-Service | Where-Object {$_.StartType -eq 'Disabled'} | Sort-Object Name
```

Notable disabled services:

- Remote Registry
- SMBv1
- Telnet

---

### 4. Firewall & Network Rules

Verified active rules:

```powershell
Get-NetFirewallRule | Where-Object {$_.Enabled -eq 'True'} | Select DisplayName, Direction, Action
```

Results:

- All inbound rules restricted by default.
- ICMP and RDP allowed only for administrators.

---

### 5. Account & Login Restrictions

| Test                  | Expected   | Result | Status |
| --------------------- | ---------- | ------ | ------ |
| Add Microsoft account | Blocked    | ✅      | Pass   |
| RDP access            | Admin only | ✅      | Pass   |
| Weak password         | Rejected   | ✅      | Pass   |

---

### 6. Windows Defender Status

Checked via PowerShell:

```powershell
Get-MpComputerStatus
```

- Real-time protection: ✅
- Behavior monitoring: ✅
- Cloud protection: ✅
- Exploit protection: ✅

---

### 7. Usability Test

- Normal apps and services run fine.
- Administrative PowerShell commands work.
- Microsoft account integration blocked by design.
