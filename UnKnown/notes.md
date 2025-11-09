

### 3. HailMary Mode

**Purpose:** Automatically apply all security hardening recommendations from a finding list.

**Usage:**
```powershell
Invoke-HardeningKitty -Mode HailMary -FileFindingList .\lists\finding_list_0x6d69636k_machine.csv -Log -Report
```

**⚠️ CRITICAL WARNINGS:**
- **ALWAYS create a system restore point first** (done automatically unless `-SkipRestorePoint` is used)
- **Review the finding list carefully** before execution
- **Test in a non-production environment first**
- Can significantly alter system behavior and functionality
- May require system restart for changes to take effect

**What it does:**
- Creates system restore point
- Applies all security configurations from finding list
- Modifies registry settings
- Configures security policies
- Sets audit policies
- Enables/disables Windows features
- Configures Windows Defender
- Sets firewall rules
- Configures exploit protection

**Example:**
```powershell
# Safe execution with restore point
Invoke-HardeningKitty -Mode HailMary -Log -Report

# Skip restore point (NOT recommended)
Invoke-HardeningKitty -Mode HailMary -SkipRestorePoint
```

### 4. GPO Mode

**Purpose:** Create a Group Policy Object (GPO) with registry-based hardening settings.

**Usage:**
```powershell
Invoke-HardeningKitty -Mode GPO -GPOname "HardeningKitty-Policy" -FileFindingList .\lists\finding_list_0x6d69636k_machine.csv
```

**Requirements:**
- Domain admin rights
- Group Policy Management PowerShell module installed
- Domain-joined system

**What it does:**
- Creates a new GPO with specified name
- Populates GPO with registry-based policies from finding list
- Only applies registry method findings (other methods skipped)
- GPO can then be linked to OUs for deployment

**Limitations:**
- Only processes registry-based settings
- Does not include audit policies, services, or other non-registry configurations

## Command Parameters

### Essential Parameters

| Parameter | Description | Example |
|-----------|-------------|---------|
| `-Mode` | Operation mode: Audit, Config, HailMary, GPO | `-Mode Audit` |
| `-FileFindingList` | Path to CSV finding list | `-FileFindingList .\lists\custom_list.csv` |
| `-Log` | Enable logging to file | `-Log` |
| `-LogFile` | Custom log file path | `-LogFile C:\logs\audit.log` |
| `-Report` | Create CSV report | `-Report` |
| `-ReportFile` | Custom report file path | `-ReportFile C:\reports\result.csv` |
| `-Backup` | Create configuration backup | `-Backup` |
| `-BackupFile` | Custom backup file path | `-BackupFile C:\backup\config.csv` |

### Optional Parameters

| Parameter | Description | Example |
|-----------|-------------|---------|
| `-Source` | Configuration source: GPO or Intune | `-Source Intune` |
| `-EmojiSupport` | Enable emoji in output | `-EmojiSupport` |
| `-SkipMachineInformation` | Skip system info display | `-SkipMachineInformation` |
| `-SkipUserInformation` | Skip user info display | `-SkipUserInformation` |
| `-SkipLanguageWarning` | Skip non-English warning | `-SkipLanguageWarning` |
| `-SkipRestorePoint` | Skip restore point (HailMary) | `-SkipRestorePoint` |
| `-Filter` | Filter findings | `-Filter { $_.Severity -eq "High" }` |
| `-GPOname` | GPO name for GPO mode | `-GPOname "Security-Policy"` |

## Finding List Files

Finding lists are CSV files that define security checks and recommendations. The default list is:
- `finding_list_0x6d69636b_machine.csv` - Machine-level settings

### Finding List Structure

Each finding includes:
- **ID**: Unique identifier
- **Category**: Security domain (e.g., "Account Policies", "Windows Firewall")
- **Name**: Human-readable description
- **Method**: How to check/apply the setting
- **MethodArgument**: Specific parameter for the method
- **RegistryPath**: Registry location (for registry methods)
- **RegistryItem**: Registry key name
- **DefaultValue**: Windows default value
- **RecommendedValue**: Hardened/secure value
- **Operator**: Comparison operator (=, >=, <=, contains, etc.)
- **Severity**: Impact level (Low, Medium, High)

### Supported Methods

1. **Registry**: Read/write registry values
2. **RegistryList**: Dynamic registry keys with incremental names
3. **secedit**: Security policy configuration
4. **auditpol**: Audit policy settings
5. **accountpolicy**: Account lockout and password policies
6. **accesschk**: User rights assignment
7. **WindowsOptionalFeature**: Enable/disable Windows features
8. **CimInstance**: Query WMI/CIM classes
9. **BitLockerVolume**: BitLocker encryption status
10. **MpPreference**: Windows Defender settings
11. **MpPreferenceAsr**: Attack Surface Reduction rules
12. **MpPreferenceExclusion**: Defender exclusions
13. **Processmitigation**: Exploit protection settings
14. **bcdedit**: Boot configuration
15. **FirewallRule**: Windows Firewall rules
16. **service**: Windows service configuration
17. **ScheduledTask**: Scheduled task state

## Execution Examples

### Basic Audit
```powershell
# Import module
Import-Module .\HardeningKitty.psm1

# Run audit with default list
Invoke-HardeningKitty -Mode Audit -Log -Report
```

### Custom Finding List Audit
```powershell
Invoke-HardeningKitty -Mode Audit -FileFindingList .\lists\custom_security.csv -Report -ReportFile C:\reports\audit.csv
```

### Configuration Backup
```powershell
Invoke-HardeningKitty -Mode Config -Backup -BackupFile C:\backup\pre_hardening_backup.csv
```

### Apply Hardening (HailMary)
```powershell
# Step 1: Backup current config
Invoke-HardeningKitty -Mode Config -Backup

# Step 2: Review the finding list
Get-Content .\lists\finding_list_0x6d69636k_machine.csv | Out-GridView

# Step 3: Apply hardening
Invoke-HardeningKitty -Mode HailMary -Log -Report
```

### Filter High Severity Issues Only
```powershell
Invoke-HardeningKitty -Mode Audit -Filter { $_.Severity -eq "High" } -Report
```

### Create Domain GPO
```powershell
Invoke-HardeningKitty -Mode GPO -GPOname "Corporate-Hardening-Policy" -FileFindingList .\lists\finding_list_0x6d69636k_machine.csv
```

### Intune Configuration Check
```powershell
Invoke-HardeningKitty -Mode Audit -Source Intune -Report
```

## Audit Results Interpretation

### From Your Files

**Pre-Audit Results** (`pre_audit.txt`):
- Multiple failed checks across categories
- Many settings at default/insecure values
- Example: Account lockout duration at 10 minutes (recommended: 15)

**Post-Audit Results** (`post_audit.txt`):
- All checks passed
- Settings aligned with recommendations
- Example: Account lockout duration now 15 minutes

**HailMary Execution** (`hailmary.txt`):
Shows the actual changes made:
- Registry keys created/modified
- Security policies configured
- Audit policies set
- Services disabled
- Firewall rules created

## Understanding Results

### Severity Levels

- **Passed** (Green): Configuration meets security recommendation
- **Low** (Cyan): Minor security gap, low risk
- **Medium** (Yellow): Moderate security risk
- **High** (Red): Significant security vulnerability

### HardeningKitty Score

Scale: 1.00 to 6.00
- **1.00-2.00**: Critical security issues
- **2.01-3.00**: Major improvements needed
- **3.01-4.00**: Moderate security posture
- **4.01-5.00**: Good security posture
- **5.01-6.00**: Excellent security posture

Calculation:
```
Score = ((Passed × 4) + (Low × 2) + (Medium × 1)) / (Total × 4) × 5 + 1
```

## Best Practices

### Before Running HailMary

1. **Create a full system backup**
2. **Review the finding list** - understand what will change
3. **Test in a lab environment** first
4. **Document current configuration** using Config mode
5. **Ensure admin rights** for execution
6. **Review application compatibility** - some hardening may break applications

### After Running HailMary

1. **Test all critical applications**
2. **Verify network connectivity**
3. **Check user authentication**
4. **Review Windows Event Logs** for errors
5. **Keep the backup file** for potential rollback

### Recommended Workflow

```powershell
# 1. Initial audit
Invoke-HardeningKitty -Mode Audit -Report -ReportFile initial_audit.csv

# 2. Backup current config
Invoke-HardeningKitty -Mode Config -Backup -BackupFile pre_hardening_backup.csv

# 3. Apply hardening
Invoke-HardeningKitty -Mode HailMary -Log -Report

# 4. Post-hardening audit
Invoke-HardeningKitty -Mode Audit -Report -ReportFile post_audit.csv

# 5. Compare results
Compare-Object (Import-Csv initial_audit.csv) (Import-Csv post_audit.csv) -Property ID, Result
```

## Security Standards Compliance

HardeningKitty helps achieve compliance with:
- **CIS Benchmarks**: Center for Internet Security hardening guides
- **STIG**: Security Technical Implementation Guides (DoD standards)
- **Microsoft Security Baselines**: Recommended security configurations

## System Requirements

- Windows 10/11 or Windows Server 2016+
- PowerShell 5.1 or higher
- Administrator privileges (for most operations)
- Additional tools:
  - `secedit.exe` (built-in)
  - `auditpol.exe` (built-in)
  - `bcdedit.exe` (built-in)
  - `net.exe` (built-in)

## Troubleshooting

### Common Issues

1. **"Not Admin" Errors**: Run PowerShell as Administrator
2. **Language Warnings**: HardeningKitty designed for English systems
3. **Binary Not Found**: Ensure Windows system binaries are available
4. **GPO Mode Fails**: Requires domain admin and Group Policy module
5. **Some Settings Not Applied**: May require system restart

### Restore System

If issues occur after HailMary:
```powershell
# Use Windows System Restore
rstrui.exe

# Or restore from backup file manually
# Review backup CSV and revert specific settings
```

## File Outputs

### Log File Format
```
[*] 2025-10-09 - Starting HardeningKitty
[*] 2025-10-09 - Getting machine information
[$] 2025-10-09 - ID 1000, SMBv1 Support, Result=Disabled, Recommended=Disabled, Severity=Passed
```

### Report File Format (CSV)
```csv
ID,Category,Name,Severity,Result,Recommended,TestResult,SeverityFinding,DefaultValue,Filter
1000,Features,SMBv1 Support,Passed,Disabled,Disabled,Passed,High,False,
```

### Backup File Format (CSV)
Contains all settings needed to restore configuration, including registry paths, method arguments, and current values.

## Conclusion

HardeningKitty is a powerful tool for Windows security hardening. Always use caution with HailMary mode, test thoroughly, and maintain backups. The Audit mode provides valuable insights into your security posture without risk, while HailMary enables rapid deployment of security baselines.