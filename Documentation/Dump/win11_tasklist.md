# Windows 11 Ansible Lockdown task list

This is a list of the High-level outcome on the target Windows 11 device

- System will be configured to CIS Benchmarks for Windows 11, including:
  - Account policies, audit policies, and security options
  - Services configuration and feature restrictions
  - Defender, Firewall, SmartScreen, BitLocker and Device Guard controls (as applicable)
  - Microsoft Edge/Internet Explorer legacy and privacy settings
  - Telemetry and data collection reductions
  - Remote Desktop, SMB, and legacy protocol hardening
  - PowerShell, Script, and Macro execution restrictions
  - User experience/privacy settings per CIS

## Table of Contents

- [Windows 11 Ansible Lockdown task list](#windows-11-ansible-lockdown-task-list)
  - [Table of Contents](#table-of-contents)
  - [Section 1 – Account Policies](#section-1--account-policies)
    - [Section 1.1 Password Policy - cis\_1.1.x.yml](#section-11-password-policy---cis_11xyml)
    - [Section 1.2 Account Lockout Policy - cis\_1.2.x.yml and cis\_1.2\_cloud\_lockout\_order.yml (for cloud systems)](#section-12-account-lockout-policy---cis_12xyml-and-cis_12_cloud_lockout_orderyml-for-cloud-systems)
  - [Section 2 Local Policies Summary](#section-2-local-policies-summary)
    - [2.2 User Rights Assignment (cis\_2.2.x.yml)](#22-user-rights-assignment-cis_22xyml)
    - [2.3.1 Accounts Policy (cis\_2.3.1.x.yml)](#231-accounts-policy-cis_231xyml)
    - [2.3.2 Audit Policy (cis\_2.3.2.x.yml)](#232-audit-policy-cis_232xyml)
    - [2.3.4 Devices (cis\_2.3.4.x.yml)](#234-devices-cis_234xyml)
    - [2.3.6 Domain Member (cis\_2.3.6.x.yml) \[only when domain-joined\]](#236-domain-member-cis_236xyml-only-when-domain-joined)
    - [2.3.7 Interactive Logon (cis\_2.3.7.x.yml)](#237-interactive-logon-cis_237xyml)
    - [2.3.8 Microsoft Network Client (cis\_2.3.8.x.yml)](#238-microsoft-network-client-cis_238xyml)
    - [2.3.9 Microsoft Network Server (cis\_2.3.9.x.yml)](#239-microsoft-network-server-cis_239xyml)
    - [2.3.10 Network Access (cis\_2.3.10.x.yml)](#2310-network-access-cis_2310xyml)
    - [2.3.11 Network Security (cis\_2.3.11.x.yml)](#2311-network-security-cis_2311xyml)
    - [2.3.14 System Cryptography (cis\_2.3.14.x.yml)](#2314-system-cryptography-cis_2314xyml)
    - [2.3.15 System Objects (cis\_2.3.15.x.yml)](#2315-system-objects-cis_2315xyml)
    - [2.3.17 User Account Control (cis\_2.3.17.x.yml)](#2317-user-account-control-cis_2317xyml)
  - [Section 5 - System Services Summary](#section-5---system-services-summary)
    - [5.x Services (cis\_5.x.yml)](#5x-services-cis_5xyml)
  - [Section 9 - Windows Firewall](#section-9---windows-firewall)
    - [9.1 Domain Profile (cis\_9.1.x.yml)](#91-domain-profile-cis_91xyml)
    - [9.2 Private Profile (cis\_9.2.x.yml)](#92-private-profile-cis_92xyml)
    - [9.3 Public Profile (cis\_9.3.x.yml)](#93-public-profile-cis_93xyml)
  - [Section 17 - Advanced Audit Policy Configuration Summary](#section-17---advanced-audit-policy-configuration-summary)
    - [17.1 Account Logon (cis\_17.1.x.yml)](#171-account-logon-cis_171xyml)
    - [17.2 Account Management (cis\_17.2.x.yml)](#172-account-management-cis_172xyml)
    - [17.3 Detailed Tracking (cis\_17.3.x.yml)](#173-detailed-tracking-cis_173xyml)
    - [17.5 Logon/Logoff (cis\_17.5.x.yml)](#175-logonlogoff-cis_175xyml)
    - [17.6 Object Access (cis\_17.6.x.yml)](#176-object-access-cis_176xyml)
    - [17.7 Policy Change (cis\_17.7.x.yml)](#177-policy-change-cis_177xyml)
    - [17.8 Privilege Use (cis\_17.8.x.yml)](#178-privilege-use-cis_178xyml)
    - [17.9 System (cis\_17.9.x.yml)](#179-system-cis_179xyml)
  - [Section 18](#section-18)
    - [](#)
  - [Section 19 - Administrative Templates (User)](#section-19---administrative-templates-user)
    - [19.5 Notifications (cis\_19.5.1.x.yml)](#195-notifications-cis_1951xyml)
    - [19.6 Assistance (cis\_19.6.6.x.yml)](#196-assistance-cis_1966xyml)
    - [19.7 Windows Components (multiple files)](#197-windows-components-multiple-files)

## Section 1 – Account Policies

### Section 1.1 Password Policy - cis_1.1.x.yml
  
- 1.1.1 Enforce password history (24 or more passwords)  
  - Prevents users from reusing old passwords.
- 1.1.2 Maximum password age (365 days or fewer, not 0)
  - Forces users to change passwords at least once a year.
- 1.1.3 Minimum password age (1 day or more)
  - Prevents bypassing password history by changing passwords repeatedly.
- 1.1.4 Minimum password length (14 or more characters)
- 1.1.5 Password must meet complexity requirements (Enabled)
  - Ensures passwords include a mix of uppercase, lowercase, numbers, and symbols.
- 1.1.6 Relax minimum password length limits (Enabled)
- 1.1.7 Store passwords using reversible encryption (Disabled)
  - Prevents storing passwords in a reversible (less secure) format.

### Section 1.2 Account Lockout Policy - cis_1.2.x.yml and cis_1.2_cloud_lockout_order.yml (for cloud systems)

- 1.2.1 Account lockout duration (15 minutes or more)
- 1.2.2 Account lockout threshold (5 or fewer invalid attempts, not 0)
  - Prevents unlimited brute-force attempts.
- 1.2.3 Allow Administrator account lockout (Enabled)
  - Ensures even the Administrator account is subject to lockout protection.
- 1.2.4 Reset account lockout counter (15 minutes or more)

## Section 2 Local Policies Summary

### 2.2 User Rights Assignment (cis_2.2.x.yml)

- 2.2.1 Ensure Access Credential Manager as a trusted caller (No One)
- 2.2.2 Ensure Access this computer from the network (Administrators, Remote Desktop Users)
- 2.2.3 Ensure Act as part of the operating system (No One)
- 2.2.4 EnsureAdjust memory quotas for a process (Administrators, Local Service, Network Service)
- 2.2.5 Ensure Allow log on locally (Administrators, Users)
- 2.2.6 Ensure Allow log on through Remote Desktop Services (Administrators, Remote Desktop Users)
- 2.2.7 Ensure Back up files and directories (Administrators)
- 2.2.8 Ensure Change the system time (Administrators, Local Service)
- 2.2.9 Ensure Change the time zone (Administrators, Local Service, Users)
- 2.2.10 Ensure Create a pagefile (Administrators)
- 2.2.11 Ensure Create a token object (No One)
- 2.2.12 Ensure Create global objects (Administrators, Local Service, Network Service, Service)
- 2.2.13 Ensure Create permanent shared objects (No One)
- 2.2.14 Ensure Create symbolic links (Administrators (add NT VIRTUAL MACHINE\Virtual Machines if Hyper-V installed))
- 2.2.15 Ensure Debug programs (Administrators)
- 2.2.16 Ensure Deny access to this computer from the network (Guests)
- 2.2.17 Ensure Deny log on as a batch job (Guests)
- 2.2.18 Ensure Deny log on as a service (Guests)
- 2.2.19 Ensure Deny log on locally (Guests)
- 2.2.20 Ensure Deny log on through Remote Desktop Services -> Guests, Local account
- 2.2.21 Ensure Enable computer and user accounts to be trusted for delegation -> No One
- 2.2.22 Ensure Force shutdown from a remote system -> Administrators
- 2.2.23 Ensure Generate security audits -> Local Service, Network Service
- 2.2.24 Ensure Impersonate a client after authentication -> Administrators, Local Service, Network Service, Service (add IIS_IUSRS if IIS Web Server installed)
- 2.2.25 Ensure Increase scheduling priority -> Administrators, Window Manager\Window Manager Group
- 2.2.26 Ensure Load and unload device drivers -> Administrators
- 2.2.27 Ensure Lock pages in memory -> No One
- 2.2.28 Ensure Log on as a batch job -> Configurable (defaults per var)
- 2.2.29 Ensure Log on as a service (Configurable; may include NT VIRTUAL MACHINE\Virtual Machines and/or WDAGUtilityAccount)
- 2.2.30 Ensure Manage auditing and security log (Administrators)
- 2.2.31 Ensure Modify an object label (No One)
- 2.2.32 Ensure Modify firmware environment values (Administrators)
- 2.2.33 Ensure Perform volume maintenance tasks (Administrators)
- 2.2.34 Ensure Profile single process (Administrators)
- 2.2.35 Ensure Profile system performance (Administrators, NT SERVICE\WdiServiceHost)
- 2.2.36 Ensure Replace a process level token (LOCAL SERVICE, NETWORK SERVICE)
- 2.2.37 Ensure Restore files and directories (Administrators)
- 2.2.38 Ensure Shut down the system (Administrators, Users)
- 2.2.39 Ensure Take ownership of files or other objects (Administrators)

### 2.3.1 Accounts Policy (cis_2.3.1.x.yml)

- 2.3.1.1 Block Microsoft accounts (Users can’t add or log on with Microsoft accounts)
- 2.3.1.2 Guest account status (Disabled)
- 2.3.1.3 Limit local account use of blank passwords to console logon only (Enabled)
- 2.3.1.4 Rename administrator account (Configurable; variable)
- 2.3.1.5 Rename guest account (Configurable; variable)

### 2.3.2 Audit Policy (cis_2.3.2.x.yml)

- 2.3.2.1 Force subcategory audit policy to override category policy (Enabled)
- 2.3.2.2 Shut down immediately if unable to log security audits (Disabled)

### 2.3.4 Devices (cis_2.3.4.x.yml)

- 2.3.4.1 Prevent users from installing printer drivers (Enabled)

### 2.3.6 Domain Member (cis_2.3.6.x.yml) [only when domain-joined]

- 2.3.6.1 Digitally encrypt or sign secure channel data (always) (Enabled)
- 2.3.6.2 Digitally encrypt secure channel data when possible (Enabled)
- 2.3.6.3 Digitally sign secure channel data when possible (Enabled)
- 2.3.6.4 Disable machine account password changes (Disabled)
- 2.3.6.5 Maximum machine account password age (30 or fewer days, not 0)
- 2.3.6.6 Require strong Windows 2000 or later session key (Enabled)

### 2.3.7 Interactive Logon (cis_2.3.7.x.yml)

- 2.3.7.1 Do not require CTRL+ALT+DEL (Disabled)
- 2.3.7.2 Don’t display last signed-in (Enabled)
- 2.3.7.3 Machine account lockout threshold (10 or fewer attempts, not 0)
- 2.3.7.4 Machine inactivity limit (900 or fewer seconds, not 0)
- 2.3.7.5 Message text for users attempting to log on (Configurable)
- 2.3.7.6 Message title for users attempting to log on (Configurable)
- 2.3.7.7 Number of previous logons to cache (4 or fewer)
- 2.3.7.8 Prompt user to change password before expiration (5–14 days)
- 2.3.7.9 Smart card removal behavior (Lock Workstation or higher; domain-joined)

### 2.3.8 Microsoft Network Client (cis_2.3.8.x.yml)

- 2.3.8.1 Digitally sign communications (always) (Enabled)
- 2.3.8.2 Digitally sign communications if server agrees (Enabled)
- 2.3.8.3 Send unencrypted password to third-party SMB servers (Disabled)

### 2.3.9 Microsoft Network Server (cis_2.3.9.x.yml)

- 2.3.9.1 Idle time before suspending session (15 or fewer minutes)
- 2.3.9.2 Digitally sign communications (always) (Enabled)
- 2.3.9.3 Digitally sign communications if client agrees (Enabled)
- 2.3.9.4 Disconnect clients when logon hours expire (Enabled)
- 2.3.9.5 Server SPN target name validation level (Accept if provided by client or higher)

### 2.3.10 Network Access (cis_2.3.10.x.yml)

- 2.3.10.1 Allow anonymous SID/Name translation (Disabled)
- 2.3.10.2 Do not allow anonymous enumeration of SAM accounts (Enabled)
- 2.3.10.3 Do not allow anonymous enumeration of SAM accounts and shares (Enabled)
- 2.3.10.4 Do not allow storage of passwords and credentials for network authentication (Enabled)
- 2.3.10.5 Let Everyone permissions apply to anonymous users (Disabled)
- 2.3.10.6 Named Pipes that can be accessed anonymously (None)
- 2.3.10.7 Remotely accessible registry paths (Configured list)
- 2.3.10.8 Remotely accessible registry paths and sub-paths (Configured list)
- 2.3.10.9 Restrict anonymous access to Named Pipes and Shares (Enabled)
- 2.3.10.10 Restrict clients allowed to make remote calls to SAM (Administrators only)
- 2.3.10.11 Shares that can be accessed anonymously (None)
- 2.3.10.12 Sharing and security model for local accounts (Classic; local users authenticate as themselves)

### 2.3.11 Network Security (cis_2.3.11.x.yml)

- 2.3.11.1 Allow Local System to use computer identity for NTLM (Enabled)
- 2.3.11.2 Allow LocalSystem NULL session fallback (Disabled)
- 2.3.11.3 Allow PKU2U auth requests to use online identities (Disabled)
- 2.3.11.4 Configure encryption types allowed for Kerberos (AES128/256 + Future; optionally include RC4 for legacy)
- 2.3.11.5 Do not store LAN Manager hash value on next password change (Enabled)
- 2.3.11.6 Force logoff when logon hours expire (Enabled)
- 2.3.11.7 LAN Manager authentication level (Send NTLMv2 only; Refuse LM/NTLM)
- 2.3.11.8 LDAP client signing requirements (Negotiate or higher)
- 2.3.11.9 Minimum session security for NTLM SSP clients (Require NTLMv2 + 128-bit)
- 2.3.11.10 Minimum session security for NTLM SSP servers (Require NTLMv2 + 128-bit)
- 2.3.11.11 Restrict NTLM: Audit Incoming NTLM Traffic (Enable auditing for all accounts)
- 2.3.11.12 Restrict NTLM: Outgoing NTLM traffic to remote servers (Audit all or higher)

### 2.3.14 System Cryptography (cis_2.3.14.x.yml)

- 2.3.14.1 Force strong key protection for user keys stored on the computer (Prompt on first use or higher)

### 2.3.15 System Objects (cis_2.3.15.x.yml)

- 2.3.15.1 Require case insensitivity for non-Windows subsystems (Enabled)
- 2.3.15.2 Strengthen default permissions of internal system objects (Enabled)

### 2.3.17 User Account Control (cis_2.3.17.x.yml)

- 2.3.17.1 Admin Approval Mode for the Built-in Administrator account (Enabled)
- 2.3.17.2 Behavior of elevation prompt for administrators (Prompt for consent on the secure desktop; configurable)
- 2.3.17.3 Behavior of elevation prompt for standard users (Automatically deny)
- 2.3.17.4 Detect application installations and prompt for elevation (Enabled)
- 2.3.17.5 Only elevate UIAccess apps installed in secure locations (Enabled)
- 2.3.17.6 Run all administrators in Admin Approval Mode (Enabled)
- 2.3.17.7 Switch to the secure desktop when prompting for elevation (Enabled)
- 2.3.17.8 Virtualize file and registry write failures to per-user locations (Enabled)

## Section 5 - System Services Summary

### 5.x Services (cis_5.x.yml)

- 5.1 Bluetooth Audio Gateway Service (BTAGService) (Disabled)
- 5.2 Bluetooth Support Service (bthserv) (Disabled)
- 5.3 Computer Browser (Browser) (Disabled or Not Installed)
- 5.4 Downloaded Maps Manager (MapsBroker) (Disabled)
- 5.5 Geolocation Service (lfsvc) (Disabled)
- 5.6 IIS Admin Service (IISADMIN) (Disabled or Not Installed)
- 5.7 Infrared monitor service (irmon) (Disabled or Not Installed)
- 5.8 Link-Layer Topology Discovery Mapper (lltdsvc) (Disabled)
- 5.9 LxssManager (LxssManager) (Disabled or Not Installed)
- 5.10 Microsoft FTP Service (FTPSVC) (Disabled or Not Installed)
- 5.11 Microsoft iSCSI Initiator Service (MSiSCSI) (Disabled)
- 5.12 OpenSSH SSH Server (sshd) (Disabled or Not Installed)
- 5.13 Peer Name Resolution Protocol (PNRPsvc) (Disabled)
- 5.14 Peer Networking Grouping (p2psvc) (Disabled)
- 5.15 Peer Networking Identity Manager (p2pimsvc) (Disabled)
- 5.16 PNRP Machine Name Publication Service (PNRPAutoReg) (Disabled)
- 5.17 Print Spooler (Spooler) (Disabled)
- 5.18 Problem Reports and Solutions Control Panel Support (wercplsupport) (Disabled)
- 5.19 Remote Access Auto Connection Manager (RasAuto) (Disabled)
- 5.20 Remote Desktop Configuration (SessionEnv) (Disabled)
- 5.21 Remote Desktop Services (TermService) (Disabled)
- 5.22 Remote Desktop Services UserMode Port Redirector (UmRdpService) (Disabled)
- 5.23 Remote Procedure Call (RPC) Locator (RpcLocator) (Disabled)
- 5.24 Remote Registry (RemoteRegistry) (Disabled)
- 5.25 Routing and Remote Access (RemoteAccess) (Disabled)
- 5.26 Server (LanmanServer) (Disabled)
- 5.27 Simple TCP/IP Services (simptcp) (Disabled or Not Installed)
- 5.28 SNMP Service (SNMP) (Disabled or Not Installed)
- 5.29 Special Administration Console Helper (sacsvr) (Disabled or Not Installed)
- 5.30 SSDP Discovery (SSDPSRV) (Disabled)
- 5.31 UPnP Device Host (upnphost) (Disabled)
- 5.32 Web Management Service (WMSvc) (Disabled or Not Installed)
- 5.33 Windows Error Reporting Service (WerSvc) (Disabled)
- 5.34 Windows Event Collector (Wecsvc) (Disabled)
- 5.35 Windows Media Player Network Sharing Service (WMPNetworkSvc) (Disabled or Not Installed)
- 5.36 Windows Mobile Hotspot Service (icssvc) (Disabled)
- 5.37 Windows Push Notifications System Service (WpnService) (Disabled)
- 5.38 Windows PushToInstall Service (PushToInstall) (Disabled)
- 5.39 Windows Remote Management (WS-Management) (WinRM) (Disabled)
- 5.40 World Wide Web Publishing Service (W3SVC) (Disabled or Not Installed)
- 5.41 Xbox Accessory Management Service (XboxGipSvc) (Disabled)
- 5.42 Xbox Live Auth Manager (XblAuthManager) (Disabled)
- 5.43 Xbox Live Game Save (XblGameSave) (Disabled)
- 5.44 Xbox Live Networking Service (XboxNetApiSvc) (Disabled)

## Section 9 - Windows Firewall

### 9.1 Domain Profile (cis_9.1.x.yml)

- 9.1.1 Windows Firewall: Domain: Firewall state (On)
- 9.1.2 Windows Firewall: Domain: Inbound connections (Block; default)
- 9.1.3 Windows Firewall: Domain: Settings: Display a notification (No)
- 9.1.4 Windows Firewall: Domain: Logging: Name (%SystemRoot%/System32/logfiles/firewall/domainfw.log)
- 9.1.5 Windows Firewall: Domain: Logging: Size limit (KB) (16,384 KB or greater)
- 9.1.6 Windows Firewall: Domain: Logging: Log dropped packets (Yes)
- 9.1.7 Windows Firewall: Domain: Logging: Log successful connections (Yes)

### 9.2 Private Profile (cis_9.2.x.yml)

- 9.2.1 Windows Firewall: Private: Firewall state (On)
- 9.2.2 Windows Firewall: Private: Inbound connections (Block; default)
- 9.2.3 Windows Firewall: Private: Settings: Display a notification (No)
- 9.2.4 Windows Firewall: Private: Logging: Name (%SystemRoot%/System32/logfiles/firewall/privatefw.log)
- 9.2.5 Windows Firewall: Private: Logging: Size limit (KB) (16,384 KB or greater)
- 9.2.6 Windows Firewall: Private: Logging: Log dropped packets (Yes)
- 9.2.7 Windows Firewall: Private: Logging: Log successful connections (Yes)

### 9.3 Public Profile (cis_9.3.x.yml)

- 9.3.1 Windows Firewall: Public: Firewall state (On)
- 9.3.2 Windows Firewall: Public: Inbound connections (Block; default)
- 9.3.3 Windows Firewall: Public: Settings: Display a notification (No)
- 9.3.4 Windows Firewall: Public: Settings: Apply local firewall rules (No)
- 9.3.5 Windows Firewall: Public: Settings: Apply local connection security rules (No)
- 9.3.6 Windows Firewall: Public: Logging: Name (%SystemRoot%/System32/logfiles/firewall/publicfw.log)
- 9.3.7 Windows Firewall: Public: Logging: Size limit (KB) (16,384 KB or greater)
- 9.3.8 Windows Firewall: Public: Logging: Log dropped packets (Yes)
- 9.3.9 Windows Firewall: Public: Logging: Log successful connections (Yes)

## Section 17 - Advanced Audit Policy Configuration Summary

### 17.1 Account Logon (cis_17.1.x.yml)

- 17.1.1 Audit Credential Validation (Success and Failure)

### 17.2 Account Management (cis_17.2.x.yml)

- 17.2.1 Audit Application Group Management (Success and Failure)
- 17.2.2 Audit Security Group Management (Success)
- 17.2.3 Audit User Account Management (Success and Failure)

### 17.3 Detailed Tracking (cis_17.3.x.yml)

- 17.3.1 Audit PNP Activity (Success)
- 17.3.2 Audit Process Creation (Success)

### 17.5 Logon/Logoff (cis_17.5.x.yml)

- 17.5.1 Audit Account Lockout (Failure)
- 17.5.2 Audit Group Membership (Success)
- 17.5.3 Audit Logoff (Success)
- 17.5.4 Audit Logon (Success and Failure)
- 17.5.5 Audit Other Logon/Logoff Events (Success and Failure)
- 17.5.6 Audit Special Logon (Success)

### 17.6 Object Access (cis_17.6.x.yml)

- 17.6.1 Audit Detailed File Share (Failure)
- 17.6.2 Audit File Share (Success and Failure)
- 17.6.3 Audit Other Object Access Events (Success and Failure)
- 17.6.4 Audit Removable Storage (Success and Failure)

### 17.7 Policy Change (cis_17.7.x.yml)

- 17.7.1 Audit Audit Policy Change (Success)
- 17.7.2 Audit Authentication Policy Change (Success)
- 17.7.3 Audit Authorization Policy Change (Success)
- 17.7.4 Audit MPSSVC Rule-Level Policy Change (Success and Failure)
- 17.7.5 Audit Other Policy Change Events (Failure)

### 17.8 Privilege Use (cis_17.8.x.yml)

- 17.8.1 Audit Sensitive Privilege Use (Success and Failure)

### 17.9 System (cis_17.9.x.yml)

- 17.9.1 Audit IPsec Driver (Success and Failure)
- 17.9.2 Audit Other System Events (Success and Failure)
- 17.9.3 Audit Security State Change (Success)
- 17.9.4 Audit Security System Extension (Success)
- 17.9.5 Audit System Integrity (Success and Failure)

## Section 18

###

## Section 19 - Administrative Templates (User)

### 19.5 Notifications (cis_19.5.1.x.yml)

- 19.5.1.1 Turn off toast notifications on the lock screen (Enabled)

### 19.6 Assistance (cis_19.6.6.x.yml)

- 19.6.6.1.1 Turn off Help Experience Improvement Program (Enabled)

### 19.7 Windows Components (multiple files)

- 19.7.5.1 Do not preserve zone information in file attachments (Disabled)
- 19.7.5.2 Notify antivirus programs when opening attachments (Enabled)
- 19.7.8.1 Configure Windows spotlight on lock screen (Disabled)
- 19.7.8.2 Do not suggest third-party content in Windows spotlight (Enabled)
- 19.7.8.3 Do not use diagnostic data for tailored experiences (Enabled)
- 19.7.8.4 Turn off all Windows spotlight features (Enabled)
- 19.7.8.5 Turn off Spotlight collection on Desktop (Enabled)
- 19.7.26.1 Prevent users from sharing files within their profile (Enabled)
- 19.7.38.1 Turn off Windows Copilot (Enabled)
- 19.7.42.1 Always install with elevated privileges (Disabled)
- 19.7.44.2.1 Prevent Codec Download (Enabled)
