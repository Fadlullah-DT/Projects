# HardeningKitty Documentation

## Overview

HardeningKitty is a PowerShell-based tool designed to harden Windows systems by applying security configurations and best practices. It supports guidelines from Microsoft, CIS Benchmarks, DoD STIG and BSI SiSyPHuS. HardeningKitty retrieves the current system configuration and compares it with a predefined checklist(finding lists) of hardening measures. It can also apply these measures to enhance the system's security. The tool provides detailed reports on the system's compliance with the supported security baseline.

## Operation Modes

### 1. Audit Mode

```powershell
Invoke-HardeningKitty -Mode Audit -Log -Report
```

**Purpose:** Assess the current security posture of your system without making changes.

**What it does:**

- Reads current system configuration
- Compares settings against recommended values in the finding list
- Generates a security score (1-6 scale)
- Identifies vulnerabilities by severity (High, Medium, Low)
- Creates detailed reports of passed and failed checks

**Output:**

- Log file with detailed execution information
- CSV report with all findings

### 2. Config Mode

**Usage:**

```powershell
Invoke-HardeningKitty -Mode Config -Report -ReportFile C:\path\to\report.csv
```

**Purpose:** Retrieve and display current system configuration values without assessment.
**NOTE:** If a setting has not been configured HardeningKitty will use a default value stored in the finding lists.

**What it does:**

- Reads current system configuration
- Outputs values without comparing to recommendations
- Useful for documenting current state
  - System documentation
  - pre-hardening baseline capture
- Create backup configuration in case of rollback needs


    ```powershell
    Invoke-HardeningKitty -Mode Config -Backup
    ```

### 3. HailMary Mode

**Purpose:** Automatically apply all security hardening recommendations from a finding list.

**Usage:**

```powershell
Invoke-HardeningKitty -Mode HailMary -FileFindingList .\lists\finding_list_0x6d69636k_machine.csv -Log -Report
```

**What it does:**

- Applies all security configurations from finding list
- Modifies registry settings
- Configures security policies
- Sets audit policies
- Enables/disables Windows features
- Configures Windows Defender
- Sets firewall rules
- Configures exploit protection


**⚠️ WARNINGS:**

- **ALWAYS create a system restore point first**
  - In windows search type "Create a restore point"
  - if you haven't done one before you will have to configure
    - click configure
    - click turn on system protection
    - click apply
  - now click create
  - type a description to help identify the restore point
  - click create
  - now with the restore point created if anything goes wrong before or after running HardeningKitty you can restore to this point
    - though I feel this step should be ran even before running the audit
- **Test in a non-production environment first**
- **The script will disable adding/logging in with MIcrosoft Account**
  - if you are using one to login you will no longer be able to after running HardeningKitty hailmary
    - create a local account and add it to the administrators group
    - if you do make the mistake of running hailmary before doing this you can restore to the restore point created earlier through the windows recovery environment
  - if you did have a local admin account and wanted to recover/reactivate signin with microsoft just run hailmary mode again but specifie the config backup csv file that was created
- Can significantly alter system behavior and functionality
- 
- Requires system restart for changes to take effect
- 