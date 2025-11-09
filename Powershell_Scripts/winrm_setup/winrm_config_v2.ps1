#Requires -Version 5.1
#Requires -RunAsAdministrator

<#
.SYNOPSIS
    Configures WinRM for Ansible remote management with HTTPS and CredSSP support.

.DESCRIPTION
    This script automates the complete setup of WinRM on Windows for Ansible connectivity:
    - Enables PowerShell Remoting
    - Creates self-signed certificate for HTTPS
    - Configures HTTPS listener on port 5986
    - Sets up firewall rules
    - Enables CredSSP authentication
    - Configures network profile if needed

.PARAMETER LogPath
    Path where log file will be created. Default: C:\Logs\WinRM-Setup.log

.PARAMETER SkipNetworkProfile
    Skip network profile configuration (Public to Private conversion)

.EXAMPLE
    .\Configure-WinRMForAnsible.ps1
    
.EXAMPLE
    .\Configure-WinRMForAnsible.ps1 -LogPath "D:\Logs\winrm.log" -SkipNetworkProfile
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory = $false)]
    [string]$LogPath = "C:\Logs\WinRM-Setup.log",
    
    [Parameter(Mandatory = $false)]
    [switch]$SkipNetworkProfile
)

#region Configuration
$ErrorActionPreference = "Stop"
$Script:LogFile = $LogPath
$Script:ConsoleWidth = 80
#endregion

#region Logging Functions
function Write-Log {
    <#
    .SYNOPSIS
        Writes messages to console and log file with timestamp
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$Message,
        
        [Parameter(Mandatory = $false)]
        [ValidateSet('INFO', 'SUCCESS', 'WARNING', 'ERROR')]
        [string]$Level = 'INFO'
    )
    
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $LogMessage = "[$Timestamp] [$Level] $Message"
    
    # Ensure log directory exists
    $LogDir = Split-Path -Path $Script:LogFile -Parent
    if (-not (Test-Path -Path $LogDir)) {
        New-Item -Path $LogDir -ItemType Directory -Force | Out-Null
    }
    
    # Write to file
    Add-Content -Path $Script:LogFile -Value $LogMessage -ErrorAction SilentlyContinue
    
    # Write to console with colors
    switch ($Level) {
        'SUCCESS' { Write-Host $Message -ForegroundColor Green }
        'WARNING' { Write-Host $Message -ForegroundColor Yellow }
        'ERROR'   { Write-Host $Message -ForegroundColor Red }
        default   { Write-Host $Message -ForegroundColor White }
    }
}

function Write-Section {
    <#
    .SYNOPSIS
        Writes a formatted section header
    #>
    param([string]$Title)
    
    $Line = "=" * $Script:ConsoleWidth
    Write-Log -Message "`n$Line" -Level INFO
    Write-Log -Message "  $Title" -Level INFO
    Write-Log -Message "$Line" -Level INFO
}
#endregion

#region Core Functions
function Enable-PSRemotingConfiguration {
    <#
    .SYNOPSIS
        Enables PowerShell Remoting and WinRM service
    #>
    try {
        Write-Log -Message "Enabling PowerShell Remoting..." -Level INFO
        Enable-PSRemoting -Force -SkipNetworkProfileCheck -ErrorAction Stop
        Write-Log -Message "PowerShell Remoting enabled successfully" -Level SUCCESS
        
        Write-Log -Message "Configuring WS-Management..." -Level INFO
        Set-WSManQuickConfig -Force -ErrorAction Stop
        Write-Log -Message "WS-Management configured successfully" -Level SUCCESS
        
        return $true
    }
    catch {
        Write-Log -Message "Failed to enable PSRemoting: $($_.Exception.Message)" -Level ERROR
        return $false
    }
}

function New-SelfSignedCertificateForWinRM {
    <#
    .SYNOPSIS
        Creates a self-signed certificate for WinRM HTTPS listener
    #>
    try {
        $Hostname = [System.Net.Dns]::GetHostByName($env:COMPUTERNAME).HostName
        Write-Log -Message "Creating self-signed certificate for hostname: $Hostname" -Level INFO
        
        # Check if certificate already exists
        $ExistingCert = Get-ChildItem -Path Cert:\LocalMachine\My | 
            Where-Object { $_.Subject -eq "CN=$Hostname" -and $_.EnhancedKeyUsageList.FriendlyName -contains "Server Authentication" } |
            Select-Object -First 1
        
        if ($ExistingCert) {
            Write-Log -Message "Found existing certificate with thumbprint: $($ExistingCert.Thumbprint)" -Level WARNING
            $Response = Read-Host "Use existing certificate? (Y/N)"
            if ($Response -eq 'Y') {
                return @{
                    Hostname = $Hostname
                    Thumbprint = $ExistingCert.Thumbprint
                }
            }
        }
        
        # Create new certificate
        $Cert = New-SelfSignedCertificate `
            -Subject "CN=$Hostname" `
            -TextExtension '2.5.29.37={text}1.3.6.1.5.5.7.3.1' `
            -CertStoreLocation Cert:\LocalMachine\My `
            -NotAfter (Get-Date).AddYears(5) `
            -ErrorAction Stop
        
        $Thumbprint = $Cert.Thumbprint
        Write-Log -Message "Certificate created successfully" -Level SUCCESS
        Write-Log -Message "Thumbprint: $Thumbprint" -Level INFO
        
        return @{
            Hostname = $Hostname
            Thumbprint = $Thumbprint
        }
    }
    catch {
        Write-Log -Message "Failed to create certificate: $($_.Exception.Message)" -Level ERROR
        return $null
    }
}

function Remove-AllWinRMListeners {
    <#
    .SYNOPSIS
        Removes all existing WinRM listeners (HTTP and HTTPS)
    #>
    try {
        Write-Log -Message "Checking for existing WinRM listeners..." -Level INFO
        
        $AllListeners = Get-ChildItem -Path WSMan:\localhost\Listener -ErrorAction SilentlyContinue
        
        if (-not $AllListeners) {
            Write-Log -Message "No existing listeners found" -Level INFO
            return $true
        }
        
        $ListenerCount = ($AllListeners | Measure-Object).Count
        Write-Log -Message "Found $ListenerCount existing listener(s)" -Level WARNING
        
        foreach ($Listener in $AllListeners) {
            $Transport = "Unknown"
            $Address = "Unknown"
            
            # Extract transport type and address
            foreach ($Key in $Listener.Keys) {
                if ($Key -like "*Transport=*") {
                    $Transport = $Key.Split('=')[1]
                }
                if ($Key -like "*Address=*") {
                    $Address = $Key.Split('=')[1]
                }
            }
            
            Write-Log -Message "Removing $Transport listener (Address: $Address)..." -Level INFO
            Remove-Item -Path $Listener.PSPath -Recurse -Force -ErrorAction Stop
            Write-Log -Message "$Transport listener removed successfully" -Level SUCCESS
        }
        
        return $true
    }
    catch {
        Write-Log -Message "Failed to remove listeners: $($_.Exception.Message)" -Level ERROR
        return $false
    }
}

function New-WinRMHttpsListener {
    <#
    .SYNOPSIS
        Creates WinRM HTTPS listener using the newly created certificate
    #>
    param(
        [Parameter(Mandatory = $true)]
        [hashtable]$CertInfo
    )
    
    try {
        Write-Log -Message "Creating new HTTPS listener with newly created certificate..." -Level INFO
        Write-Log -Message "Certificate Thumbprint: $($CertInfo.Thumbprint)" -Level INFO
        Write-Log -Message "Hostname: $($CertInfo.Hostname)" -Level INFO
        
        # Verify certificate exists
        $CertExists = Get-ChildItem -Path Cert:\LocalMachine\My | 
            Where-Object { $_.Thumbprint -eq $CertInfo.Thumbprint }
        
        if (-not $CertExists) {
            Write-Log -Message "Certificate with thumbprint $($CertInfo.Thumbprint) not found in certificate store!" -Level ERROR
            return $false
        }
        
        Write-Log -Message "Certificate verified in LocalMachine\My store" -Level SUCCESS
        
        # Create the HTTPS listener using New-WSManInstance
        $ListenerParams = @{
            ResourceURI = "winrm/config/Listener"
            SelectorSet = @{
                Address = "*"
                Transport = "HTTPS"
            }
            ValueSet = @{
                Hostname = $CertInfo.Hostname
                CertificateThumbprint = $CertInfo.Thumbprint
            }
        }
        
        New-WSManInstance @ListenerParams -ErrorAction Stop | Out-Null
        
        Write-Log -Message "HTTPS listener created successfully" -Level SUCCESS
        Write-Log -Message "Listening on: 0.0.0.0:5986 (HTTPS)" -Level INFO
        
        # Verify listener was created
        Start-Sleep -Seconds 1
        $NewListener = Get-ChildItem -Path WSMan:\localhost\Listener | 
            Where-Object { $_.Keys -like "*Transport=HTTPS*" }
        
        if ($NewListener) {
            Write-Log -Message "Listener verification: PASSED" -Level SUCCESS
            return $true
        }
        else {
            Write-Log -Message "Listener verification: FAILED - Listener not found after creation" -Level ERROR
            return $false
        }
    }
    catch {
        Write-Log -Message "Failed to create HTTPS listener: $($_.Exception.Message)" -Level ERROR
        
        # Additional troubleshooting info
        if ($_.Exception.Message -like "*thumb*") {
            Write-Log -Message "Certificate thumbprint issue detected. Verify certificate exists in Cert:\LocalMachine\My" -Level ERROR
        }
        
        return $false
    }
}

function Set-WinRMFirewallRule {
    <#
    .SYNOPSIS
        Creates or enables firewall rule for WinRM HTTPS (port 5986)
    #>
    try {
        Write-Log -Message "Checking WinRM firewall rules..." -Level INFO
        
        # Check for existing rule
        $ExistingRule = Get-NetFirewallRule -DisplayName "*WinRM*HTTPS*" -ErrorAction SilentlyContinue |
            Where-Object { $_.Enabled -eq $true }
        
        if ($ExistingRule) {
            Write-Log -Message "WinRM HTTPS firewall rule already exists and is enabled" -Level SUCCESS
            return $true
        }
        
        # Check if rule exists but is disabled
        $DisabledRule = Get-NetFirewallRule -DisplayName "*WinRM*HTTPS*" -ErrorAction SilentlyContinue |
            Where-Object { $_.Enabled -eq $false } | Select-Object -First 1
        
        if ($DisabledRule) {
            Write-Log -Message "Enabling existing WinRM HTTPS firewall rule..." -Level INFO
            Enable-NetFirewallRule -Name $DisabledRule.Name -ErrorAction Stop
            Write-Log -Message "Firewall rule enabled successfully" -Level SUCCESS
            return $true
        }
        
        # Create new rule
        Write-Log -Message "Creating new WinRM HTTPS firewall rule..." -Level INFO
        New-NetFirewallRule `
            -Name "WinRM-HTTPS-Ansible" `
            -DisplayName "WinRM HTTPS (Ansible)" `
            -Description "Allows WinRM HTTPS traffic for Ansible management" `
            -Enabled True `
            -Direction Inbound `
            -Protocol TCP `
            -LocalPort 5986 `
            -Action Allow `
            -Profile Any `
            -ErrorAction Stop | Out-Null
        
        Write-Log -Message "Firewall rule created successfully (Port 5986)" -Level SUCCESS
        return $true
    }
    catch {
        Write-Log -Message "Failed to configure firewall rule: $($_.Exception.Message)" -Level ERROR
        return $false
    }
}

function Enable-CredSSPAuthentication {
    <#
    .SYNOPSIS
        Enables CredSSP authentication for WinRM
    #>
    try {
        Write-Log -Message "Enabling CredSSP authentication..." -Level INFO
        
        # Enable CredSSP server role
        Enable-WSManCredSSP -Role Server -Force -ErrorAction Stop | Out-Null
        
        # Configure CredSSP in WinRM
        Set-Item -Path WSMan:\localhost\Service\Auth\CredSSP -Value $true -Force -ErrorAction Stop
        
        Write-Log -Message "Restarting WinRM service..." -Level INFO
        Restart-Service WinRM -Force -ErrorAction Stop
        Start-Sleep -Seconds 2
        
        # Verify configuration
        $CredSSPValue = (Get-Item -Path WSMan:\localhost\Service\Auth\CredSSP).Value
        
        if ($CredSSPValue -eq $true) {
            Write-Log -Message "CredSSP authentication enabled successfully" -Level SUCCESS
            return $true
        }
        else {
            Write-Log -Message "CredSSP verification failed" -Level WARNING
            return $false
        }
    }
    catch {
        Write-Log -Message "Failed to enable CredSSP: $($_.Exception.Message)" -Level ERROR
        return $false
    }
}

function Set-NetworkProfileToPrivate {
    <#
    .SYNOPSIS
        Changes network profile from Public to Private
    #>
    try {
        Write-Log -Message "Checking network connection profiles..." -Level INFO
        
        $PublicProfiles = Get-NetConnectionProfile | Where-Object { $_.NetworkCategory -eq 'Public' }
        
        if (-not $PublicProfiles) {
            Write-Log -Message "No Public network profiles found" -Level SUCCESS
            return $true
        }
        
        Write-Log -Message "Found $($PublicProfiles.Count) Public network profile(s)" -Level WARNING
        
        foreach ($Profile in $PublicProfiles) {
            Write-Log -Message "Changing '$($Profile.Name)' to Private..." -Level INFO
            Set-NetConnectionProfile -InterfaceIndex $Profile.InterfaceIndex -NetworkCategory Private -ErrorAction Stop
            Write-Log -Message "Network profile changed successfully" -Level SUCCESS
        }
        
        return $true
    }
    catch {
        Write-Log -Message "Failed to change network profile: $($_.Exception.Message)" -Level ERROR
        return $false
    }
}

function Get-WinRMConfiguration {
    <#
    .SYNOPSIS
        Displays current WinRM configuration summary
    #>
    try {
        Write-Section -Title "WinRM Configuration Summary"
        
        # Service status
        $WinRMService = Get-Service -Name WinRM
        Write-Log -Message "WinRM Service: $($WinRMService.Status) (StartType: $($WinRMService.StartType))" -Level INFO
        
        # Listeners
        Write-Log -Message "`nConfigured Listeners:" -Level INFO
        $Listeners = Get-ChildItem -Path WSMan:\localhost\Listener
        foreach ($Listener in $Listeners) {
            $Transport = ($Listener.Keys | Where-Object { $_ -like "*Transport*" }).Split('=')[1]
            $Port = if ($Transport -eq 'HTTPS') { '5986' } else { '5985' }
            Write-Log -Message "  - $Transport on port $Port" -Level INFO
        }
        
        # Authentication methods
        Write-Log -Message "`nAuthentication Methods:" -Level INFO
        $AuthMethods = Get-ChildItem -Path WSMan:\localhost\Service\Auth
        foreach ($Method in $AuthMethods) {
            $Status = if ($Method.Value -eq 'true') { 'Enabled' } else { 'Disabled' }
            Write-Log -Message "  - $($Method.Name): $Status" -Level INFO
        }
        
        # Firewall rules
        Write-Log -Message "`nFirewall Rules:" -Level INFO
        $FirewallRules = Get-NetFirewallRule -DisplayName "*WinRM*" | Where-Object { $_.Enabled -eq $true }
        foreach ($Rule in $FirewallRules) {
            Write-Log -Message "  - $($Rule.DisplayName): Enabled" -Level INFO
        }
        
        # Network profiles
        Write-Log -Message "`nNetwork Profiles:" -Level INFO
        $Profiles = Get-NetConnectionProfile
        foreach ($Profile in $Profiles) {
            Write-Log -Message "  - $($Profile.Name): $($Profile.NetworkCategory)" -Level INFO
        }
        
        return $true
    }
    catch {
        Write-Log -Message "Failed to retrieve configuration: $($_.Exception.Message)" -Level ERROR
        return $false
    }
}
#endregion

#region Main Execution
function Start-WinRMConfiguration {
    <#
    .SYNOPSIS
        Main function that orchestrates the entire WinRM configuration process
    #>
    
    Write-Section -Title "WinRM Configuration for Ansible"
    Write-Log -Message "Script started at $(Get-Date)" -Level INFO
    Write-Log -Message "Log file: $Script:LogFile" -Level INFO
    
    $Results = @{
        PSRemoting = $false
        Certificate = $false
        HTTPSListener = $false
        Firewall = $false
        CredSSP = $false
        NetworkProfile = $false
    }
    
    # Step 1: Enable PS Remoting
    Write-Section -Title "Step 1: Enable PowerShell Remoting"
    $Results.PSRemoting = Enable-PSRemotingConfiguration
    
    if (-not $Results.PSRemoting) {
        Write-Log -Message "Critical error: Cannot proceed without PSRemoting" -Level ERROR
        return $false
    }
    
    # Step 2: Create Certificate
    Write-Section -Title "Step 2: Create Self-Signed Certificate"
    $CertInfo = New-SelfSignedCertificateForWinRM
    $Results.Certificate = ($null -ne $CertInfo)
    
    if (-not $Results.Certificate) {
        Write-Log -Message "Critical error: Cannot proceed without certificate" -Level ERROR
        return $false
    }
    
    # Step 3: Create HTTPS Listener
    Write-Section -Title "Step 3: Configure HTTPS Listener"
    $Results.HTTPSListener = New-WinRMHttpsListener -CertInfo $CertInfo
    
    # Step 4: Configure Firewall
    Write-Section -Title "Step 4: Configure Firewall Rules"
    $Results.Firewall = Set-WinRMFirewallRule
    
    # Step 5: Enable CredSSP
    Write-Section -Title "Step 5: Enable CredSSP Authentication"
    $Results.CredSSP = Enable-CredSSPAuthentication
    
    # Step 6: Network Profile (Optional)
    if (-not $SkipNetworkProfile) {
        Write-Section -Title "Step 6: Configure Network Profile"
        $Results.NetworkProfile = Set-NetworkProfileToPrivate
    }
    else {
        Write-Log -Message "Skipping network profile configuration (SkipNetworkProfile flag set)" -Level WARNING
        $Results.NetworkProfile = $true
    }
    
    # Display Summary
    Write-Section -Title "Configuration Results"
    $AllSuccess = $true
    foreach ($Key in $Results.Keys) {
        $Status = if ($Results[$Key]) { "SUCCESS" } else { "FAILED" }
        $Level = if ($Results[$Key]) { "SUCCESS" } else { "ERROR" }
        Write-Log -Message "${Key}: $Status" -Level $Level
        if (-not $Results[$Key]) { $AllSuccess = $false }
    }
    
    # Display current configuration
    Get-WinRMConfiguration
    
    # Final message
    Write-Section -Title "Configuration Complete"
    if ($AllSuccess) {
        Write-Log -Message "All configuration steps completed successfully!" -Level SUCCESS
        Write-Log -Message "`nNext Steps:" -Level INFO
        Write-Log -Message "1. Test connectivity: Test-WSMan -ComputerName $env:COMPUTERNAME -UseSSL" -Level INFO
        Write-Log -Message "2. Configure your Ansible inventory with:" -Level INFO
        Write-Log -Message "   ansible_connection: winrm" -Level INFO
        Write-Log -Message "   ansible_port: 5986" -Level INFO
        Write-Log -Message "   ansible_winrm_transport: credssp" -Level INFO
        Write-Log -Message "   ansible_winrm_server_cert_validation: ignore" -Level INFO
    }
    else {
        Write-Log -Message "Configuration completed with errors. Check log file for details." -Level WARNING
    }
    
    Write-Log -Message "Script completed at $(Get-Date)" -Level INFO
    return $AllSuccess
}
#endregion

# Execute main function
try {
    $Success = Start-WinRMConfiguration
    exit $(if ($Success) { 0 } else { 1 })
}
catch {
    Write-Log -Message "Unhandled exception: $($_.Exception.Message)" -Level ERROR
    Write-Log -Message "Stack trace: $($_.ScriptStackTrace)" -Level ERROR
    exit 1
}