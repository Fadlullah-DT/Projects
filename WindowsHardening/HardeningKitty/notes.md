# Windows Hardening done with Hardeningkitty

## Standards
 
The hardeningkitty github follows cis and stig standards




## Execution

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

    # this will allow for the script to run without any issues
    
Import-Module .\HardeningKitty.psm1

    # this will import the module for hardening kitty to run the audit

Invoke-HardeningKitty -Mode Audit -Log -Report

    # this is the audit command that will run the audit and generate a report 
    # the report will be saved in the current directory
    # the log will be saved in the current directory as well

Invoke-HardeningKitty -Mode Config -Report -ReportFile C:\\Users\Fadlullah LC\code\WindowsHardening\my_hardeningkitty_report.csv

    # this will create a config report and save it to the specified file path
    
Invoke-HardeningKitty -Mode Config -Backup

    # this will create a backup of the current configuration
    
Invoke-HardeningKitty -Mode HailMary -Log -Report -FileFindingList .\lists\finding_list_0x6d69636b_machine.csv

    # this will deploy the config from the finding list file

```
Invoke-HardeningKitty -Mode HailMary -Log -Report -FileFindingList .\lists\hardeningkitty_desktop-ud5qc2k_config_backup-20251009.csv