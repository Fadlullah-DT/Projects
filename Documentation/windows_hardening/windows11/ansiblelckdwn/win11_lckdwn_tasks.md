# Windows 11 CIS Lockdown Tasks

This is a list of the High-level outcome on the target Windows 11 device

- System that will be configured to CIS Benchmarks for Windows 11, including:
  - Account policies, audit policies, and security options
  - Services configuration and feature restrictions
  - Defender, Firewall, SmartScreen, BitLocker and Device Guard controls (as applicable)
  - Microsoft Edge/Internet Explorer legacy and privacy settings
  - Telemetry and data collection reductions
  - Remote Desktop, SMB, and legacy protocol hardening
  - PowerShell, Script, and Macro execution restrictions
  - User experience/privacy settings per CIS policies

## Table Of Contents

- [Windows 11 CIS Lockdown Tasks](#windows-11-cis-lockdown-tasks)
  - [Table Of Contents](#table-of-contents)
  - [Section 1 - Account Policies](#section-1---account-policies)
    - [Section 1.1](#section-11)
      - [Section 1.1 Password Policy - cis\_1.1.x.yml](#section-11-password-policy---cis_11xyml)
    - [Section 1.2](#section-12)
      - [Section 1.2 Account Lockout Policy - cis\_1.2.x.yml](#section-12-account-lockout-policy---cis_12xyml)
      - [Section 1.2 Account Lockout Policy (for cloud systems) - cis\_1.2\_cloud\_lockout\_order.yml](#section-12-account-lockout-policy-for-cloud-systems---cis_12_cloud_lockout_orderyml)
    - [Section 1 main.yml](#section-1-mainyml)
  - [Section 2 - Local Policies](#section-2---local-policies)
    - [Section 2.2](#section-22)
      - [Section 2.2 User Right Assignment - cis\_2.2.x.yml](#section-22-user-right-assignment---cis_22xyml)
    - [Section 2.3](#section-23)
      - [Section 2.3.1 Accounts - cis\_2.3.1.x.yml](#section-231-accounts---cis_231xyml)
      - [Section 2.3.2 Audit - cis\_2.3.2.x.yml](#section-232-audit---cis_232xyml)
      - [Section 2.3.4 Devices - cis\_2.3.4.x.yml](#section-234-devices---cis_234xyml)
      - [Section 2.3.6 Domain Member - cis\_2.3.6.x.yml](#section-236-domain-member---cis_236xyml)
      - [Section 2.3.7 Interactive Logon - cis\_2.3.7.x.yml](#section-237-interactive-logon---cis_237xyml)
      - [Section 2.3.8 Microsoft Network Client - cis\_2.3.8.x.yml](#section-238-microsoft-network-client---cis_238xyml)
      - [Section 2.3.9 Microsoft Network Server - cis\_2.3.9.x.yml](#section-239-microsoft-network-server---cis_239xyml)
      - [Section 2.3.10 Network Access - cis\_2.3.10.x.yml](#section-2310-network-access---cis_2310xyml)
      - [Section 2.3.11 Network Security - cis\_2.3.11.x.yml](#section-2311-network-security---cis_2311xyml)
      - [Section 2.3.14 System Cryptography - cis\_2.3.14.x.yml](#section-2314-system-cryptography---cis_2314xyml)
      - [Section 2.3.15 System Objects - cis\_2.3.15.x.yml](#section-2315-system-objects---cis_2315xyml)
      - [Section 2.3.17 User Account Control - cis\_2.3.17.x.yml](#section-2317-user-account-control---cis_2317xyml)
    - [Section 2 main.yml](#section-2-mainyml)
  - [Section 5 - System Services](#section-5---system-services)
    - [Section 5 System Services - cis\_5.x.yml](#section-5-system-services---cis_5xyml)
    - [Section 5 main.yml](#section-5-mainyml)
  - [Section 9 - Windows Firewall](#section-9---windows-firewall)
    - [Section 9.1](#section-91)
      - [Section 9.1 Domain Profile - cis\_9.1.x.yml](#section-91-domain-profile---cis_91xyml)
    - [Section 9.2](#section-92)
      - [Section 9.2  Private Profile - cis\_9.2.x.yml](#section-92--private-profile---cis_92xyml)
    - [Section 9.3](#section-93)
      - [Section 9.3 Public Profile - cis\_9.3.x.yml](#section-93-public-profile---cis_93xyml)
    - [Section 9 main.yml](#section-9-mainyml)
  - [Section 17 - Advanced Audit Policy](#section-17---advanced-audit-policy)
    - [Section 17.1](#section-171)
      - [Section 17.1 Account Logon - cis\_17.1.x.yml](#section-171-account-logon---cis_171xyml)
    - [Section 17.2](#section-172)
      - [Section 17.2 Account Management - cis\_17.2.x.yml](#section-172-account-management---cis_172xyml)
    - [Section 17.3](#section-173)
      - [Section 17.3 Detail Tracking - cis\_17.3.x.yml](#section-173-detail-tracking---cis_173xyml)
    - [Section 17.5](#section-175)
      - [Section 17.5 Logon/Logoff - cis\_17.5.x.yml](#section-175-logonlogoff---cis_175xyml)
    - [Section 17.6](#section-176)
      - [Section 17.6 Object Access - cis\_17.6.x.yml](#section-176-object-access---cis_176xyml)
    - [Section 17.7](#section-177)
      - [Section 17.7 Policy Change - cis\_17.7.x.yml](#section-177-policy-change---cis_177xyml)
    - [Section 17.8](#section-178)
      - [Section 17.8 Privilege Use - cis\_17.8.x.yml](#section-178-privilege-use---cis_178xyml)
    - [Section 17.9](#section-179)
      - [Section 17.9 System - cis\_17.9.x.yml](#section-179-system---cis_179xyml)
    - [Section 17 main.yml](#section-17-mainyml)
  - [Section 18 - Administrative Templates (Computers)](#section-18---administrative-templates-computers)
    - [Section 18.1](#section-181)
      - [Section 18.1.1 Personalization - cis\_18.1.1.x.yml](#section-1811-personalization---cis_1811xyml)
      - [Section 18.1.2 Regional and Language Options - cis\_18.1.2.x.yml](#section-1812-regional-and-language-options---cis_1812xyml)
      - [Section 18.1.3 Online Tips - cis\_18.1.3.x.yml](#section-1813-online-tips---cis_1813xyml)
    - [Section 18.4](#section-184)
      - [Section 18.4 MS Security Guide - cis\_18.4.x.yml](#section-184-ms-security-guide---cis_184xyml)
    - [Section 18.5](#section-185)
      - [Section 18.5 MSS (Legacy) - cis\_18.5.x.yml](#section-185-mss-legacy---cis_185xyml)
    - [Section 18.6](#section-186)
      - [Section 18.6.4 DNS Client - cis\_18.6.4.x.yml](#section-1864-dns-client---cis_1864xyml)
      - [Section 18.6.5 Fonts - cis\_18.6.5.x.yml](#section-1865-fonts---cis_1865xyml)
      - [Section 18.6.8 Lanman Workstation - cis\_18.6.8.x.yml](#section-1868-lanman-workstation---cis_1868xyml)
      - [Section 18.6.9 Link-Layer Topology Discovery - cis\_18.6.9.x.yml](#section-1869-link-layer-topology-discovery---cis_1869xyml)
      - [Section 18.6.10 Microsoft Peer-to-Peer Networking Services - cis\_18.6.10.x.yml](#section-18610-microsoft-peer-to-peer-networking-services---cis_18610xyml)
      - [Section 18.6.11 Network Connections - cis\_18.6.11.x.yml](#section-18611-network-connections---cis_18611xyml)
      - [Section 18.6.14 Network Provider - cis\_18.6.14.x.yml](#section-18614-network-provider---cis_18614xyml)
      - [Section 18.6.19 TCP/IP Settings - cis\_18.6.19.2.x.yml](#section-18619-tcpip-settings---cis_186192xyml)
      - [Section 18.6.20 Windows Connect Now - cis\_18.6.20.x.yml](#section-18620-windows-connect-now---cis_18620xyml)
      - [Section 18.6.21 Windows Connnection Manager - cis\_18.6.21.x.yml](#section-18621-windows-connnection-manager---cis_18621xyml)
      - [Section 18.6.23 WLAN Service - cis\_18.6.23.2.x.yml](#section-18623-wlan-service---cis_186232xyml)
    - [Section 18.7](#section-187)
      - [Section 18.7 Printers - cis\_18.7.x.yml](#section-187-printers---cis_187xyml)
    - [Section 18.8](#section-188)
      - [Section 18.8.1 Notification - cis\_18.8.1.x.yml](#section-1881-notification---cis_1881xyml)
    - [Section 18.9](#section-189)
      - [Section 18.9.3 Audit Process Creation - cis\_18.9.3.x.yml](#section-1893-audit-process-creation---cis_1893xyml)
      - [Section 18.9.4 Credentials Delegation - cis\_18.9.4.x.yml](#section-1894-credentials-delegation---cis_1894xyml)
      - [Section 18.9.5 Device Guard - cis\_18.9.5.x.yml](#section-1895-device-guard---cis_1895xyml)
      - [Section 18.9.7 Device Installation - cis\_18.9.7.x.yml](#section-1897-device-installation---cis_1897xyml)
      - [Section 18.9.13 Early Launch Antimalware - cis\_18.9.13.x.yml](#section-18913-early-launch-antimalware---cis_18913xyml)
      - [Section 18.9.19 Group Policy - cis\_18.9.19.x.yml](#section-18919-group-policy---cis_18919xyml)
      - [Section 18.9.20 Internet Connection Mangement - cis\_18.9.20.x.yml](#section-18920-internet-connection-mangement---cis_18920xyml)
      - [Section 18.9.23 Kerberos - cis\_18.9.23.x.yml](#section-18923-kerberos---cis_18923xyml)
      - [Section 18.9.24 Kernel DMA Protection - cis\_18.9.24.x.yml](#section-18924-kernel-dma-protection---cis_18924xyml)
      - [Section 18.9.25 LAPS - cis\_18.9.25.x.yml](#section-18925-laps---cis_18925xyml)
      - [Section 18.9.26 Local Security Authority - cis\_18.9.26.x.yml](#section-18926-local-security-authority---cis_18926xyml)
      - [Section 18.9.27 Local Services - cis\_18.9.27.x.yml](#section-18927-local-services---cis_18927xyml)
      - [Section 18.9.28 Logon - cis\_18.9.28.x.yml](#section-18928-logon---cis_18928xyml)
      - [Section 18.9.31 OS Policies - cis\_18.9.31.x.yml](#section-18931-os-policies---cis_18931xyml)
      - [Section 18.9.33 Power Mangement - cis\_18.9.33.x.yml](#section-18933-power-mangement---cis_18933xyml)
      - [Section 18.9.35 Remote Assistance - cis\_18.9.35.x.yml](#section-18935-remote-assistance---cis_18935xyml)
      - [Section 18.9.36 Remote Procedure Call - cis\_18.9.36.x.yml](#section-18936-remote-procedure-call---cis_18936xyml)
      - [Section 18.9.47 Troubleshooting and Diagnostics - cis\_18.9.47.x.yml](#section-18947-troubleshooting-and-diagnostics---cis_18947xyml)
      - [Section 18.9.49 User Profiles - cis\_18.9.49.x.yml](#section-18949-user-profiles---cis_18949xyml)
      - [Section 18.9.51 Windows Time Service - cis\_18.9.51.x.yml](#section-18951-windows-time-service---cis_18951xyml)
    - [Section 18.10](#section-1810)
      - [Section 18.10.3 App Package Deployment - cis\_18.10.3.x.yml](#section-18103-app-package-deployment---cis_18103xyml)
      - [Section 18.10.4 App Privacy - cis\_18.10.4.x.yml](#section-18104-app-privacy---cis_18104xyml)
      - [Section 18.10.5 App Runtime - cis\_18.10.5.x.yml](#section-18105-app-runtime---cis_18105xyml)
      - [Section 18.10.7 Autoplay Policies cis\_18.10.7.x.yml](#section-18107-autoplay-policies-cis_18107xyml)
      - [Section 18.10.8 Biometrics - cis\_18.10.8.x.yml](#section-18108-biometrics---cis_18108xyml)
      - [Section 18.10.9 Bitlocker Drive Encryption - cis\_18.10.9.x.yml](#section-18109-bitlocker-drive-encryption---cis_18109xyml)
      - [Section 18.10.10 Camera - cis\_18.10.10.x.yml](#section-181010-camera---cis_181010xyml)
      - [Section 18.10.12 Cloud Content - cis\_18.10.12.x.yml](#section-181012-cloud-content---cis_181012xyml)
      - [Section 18.10.13 Connect - cis\_18.10.13.x.yml](#section-181013-connect---cis_181013xyml)
      - [Section 18.10.14 Credential User Interface - cis\_18.10.14.x.yml](#section-181014-credential-user-interface---cis_181014xyml)
      - [Section 18.10.15 Data Collection and Preview Builds - cis\_18.10.15.x.yml](#section-181015-data-collection-and-preview-builds---cis_181015xyml)
      - [Section 18.10.16 Delivery Optimization - cis\_18.10.16.x.yml](#section-181016-delivery-optimization---cis_181016xyml)
      - [Section 18.10.17 Desktop app installer - cis\_18.10.17.x.yml](#section-181017-desktop-app-installer---cis_181017xyml)
      - [Section 18.10.25 Event Log Service - cis\_18.10.25.x.yml](#section-181025-event-log-service---cis_181025xyml)
      - [Section 18.10.28 File Explorer - cis\_18.10.28.x.yml](#section-181028-file-explorer---cis_181028xyml)
      - [Section 18.10.36 Location and Sensors - cis\_18.10.36.x.yml](#section-181036-location-and-sensors---cis_181036xyml)
      - [Section 18.10.40 Messaging - cis\_18.10.40.x.yml](#section-181040-messaging---cis_181040xyml)
      - [Section 18.10.41 Microsoft Accouint - cis\_18.10.41.x.yml](#section-181041-microsoft-accouint---cis_181041xyml)
      - [Section 18.10.42 Microsoft Defender Antivirus - cis\_18.10.42.x.yml](#section-181042-microsoft-defender-antivirus---cis_181042xyml)
      - [Section 18.10.43 Microsoft Defender Application Guard - cis\_18.10.43.x.yml](#section-181043-microsoft-defender-application-guard---cis_181043xyml)
      - [Section 18.10.49 News and Interests - cis\_18.10.49.x.yml](#section-181049-news-and-interests---cis_181049xyml)
      - [Section 18.10.50 OneDrive - cis\_18.10.50.x.yml](#section-181050-onedrive---cis_181050xyml)
      - [Section 18.10.55 Push To Install - cis\_18.10.55.x.yml](#section-181055-push-to-install---cis_181055xyml)
      - [Section 18.10.56 Remote Desktop Services cis\_18.10.56.x.yml](#section-181056-remote-desktop-services-cis_181056xyml)
      - [Section 18.10.57 RSS Feeds - cis\_18.10.57.x.yml](#section-181057-rss-feeds---cis_181057xyml)
      - [Section 18.10.58 Search - cis\_18.10.58.x.yml](#section-181058-search---cis_181058xyml)
      - [Section 18.10.62 Software Protection Platform - cis\_18.10.62.x.yml](#section-181062-software-protection-platform---cis_181062xyml)
      - [Section 18.10.65 Store - cis\_18.10.65.x.yml](#section-181065-store---cis_181065xyml)
      - [Section 18.10.71 Widgets - cis\_18.10.71.x.yml](#section-181071-widgets---cis_181071xyml)
      - [Section 18.10.75 Windows Defender SmartScreen - cis\_18.10.75.x.yml](#section-181075-windows-defender-smartscreen---cis_181075xyml)
      - [Section 18.10.77 Windows Game Recording and Broadcasting - cis\_18.10.77.x.yml](#section-181077-windows-game-recording-and-broadcasting---cis_181077xyml)
      - [Section 18.10.78 Windwos Hello for Business - cis\_18.10.78.x.yml](#section-181078-windwos-hello-for-business---cis_181078xyml)
      - [Section 18.10.79 Windows Ink Workspace - cis\_18.10.79.x.yml](#section-181079-windows-ink-workspace---cis_181079xyml)
      - [Section 18.10.80 Windows Installer - cis\_18.10.80.x.yml](#section-181080-windows-installer---cis_181080xyml)
      - [Section 18.10.81 Windows Logon Options - cis\_18.10.81.x.yml](#section-181081-windows-logon-options---cis_181081xyml)
      - [Section 18.10.86 Windows PowerShell - cis\_18.10.86.x.yml](#section-181086-windows-powershell---cis_181086xyml)
      - [Section 18.10.88 Windows Remote Management (WinRM) - cis\_18.10.88.x.yml](#section-181088-windows-remote-management-winrm---cis_181088xyml)
      - [Section 18.10.89 Windows Remote Shell - cis\_18.10.89.x.yml](#section-181089-windows-remote-shell---cis_181089xyml)
      - [Section 18.10.90 Windows Sandbox - cis\_18.10.90.x.yml](#section-181090-windows-sandbox---cis_181090xyml)
      - [Section 18.10.91 Windows Security - cis\_18.10.91.x.yml](#section-181091-windows-security---cis_181091xyml)
      - [Section 18.10.92 Windows Update cis\_18.10.92.x.yml](#section-181092-windows-update-cis_181092xyml)
    - [Section 18 main.yml](#section-18-mainyml)
  - [Section 19 - Administrative Templates (User)](#section-19---administrative-templates-user)
    - [Section 19.5](#section-195)
      - [Section 19.5.1 Notifications - cis\_19.5.1.x.yml](#section-1951-notifications---cis_1951xyml)
    - [Section 19.6](#section-196)
      - [Section 19.6.6 Internet Communication Management - cis\_19.6.6.x.yml](#section-1966-internet-communication-management---cis_1966xyml)
    - [Section 19.7](#section-197)
      - [Section 19.7.5 Attachment Manager - cis\_19.7.5.x.yml](#section-1975-attachment-manager---cis_1975xyml)
      - [Section 19.7.8 Cloud Content - cis\_19.7.8.x.yml](#section-1978-cloud-content---cis_1978xyml)
      - [Section 19.7.26 Network Sharing - cis\_19.7.26.x.yml](#section-19726-network-sharing---cis_19726xyml)
      - [Section 19.7.38 Windows Copilot - cis\_19.7.38.x.yml](#section-19738-windows-copilot---cis_19738xyml)
      - [Section 19.7.42 Windows Installer - cis\_19.7.42.x.yml](#section-19742-windows-installer---cis_19742xyml)
      - [Section 19.7.44 Windows Media Player - cis\_19.7.44.2.x.yml](#section-19744-windows-media-player---cis_197442xyml)
    - [Section 19 main.yml](#section-19-mainyml)

## Section 1 - Account Policies

### Section 1.1

#### Section 1.1 Password Policy - cis_1.1.x.yml

- "1.1.1 | PATCH | Ensure Enforce password history is set to 24 or more passwords."
- "1.1.2 | PATCH | Ensure Maximum password age is set to 365 or fewer days but not 0."
- "1.1.3 | PATCH | Ensure Minimum password age is set to 1 or more days."
- "1.1.4 | PATCH | Ensure Minimum password length is set to 14 or more characters."
- "1.1.5 | PATCH | Ensure Password must meet complexity requirements is set to Enabled."
- "1.1.6 | PATCH | Ensure Relax minimum password length limits is set to Enabled."
- "1.1.7 | PATCH | Ensure Store passwords using reversible encryption is set to Disabled."

### Section 1.2

#### Section 1.2 Account Lockout Policy - cis_1.2.x.yml

- "1.2.2 | PATCH | Ensure Account lockout threshold is set to 5 or fewer invalid logon attempt(s), but not 0."
- "1.2.4 | PATCH | Ensure Reset account lockout counter after is set to 15 or more minutes."
- "1.2.1 | PATCH | Ensure Account lockout duration is set to 15 or more minutes."
- "1.2.3 | PATCH | Ensure Allow Administrator account lockout is set to Enabled."

#### Section 1.2 Account Lockout Policy (for cloud systems) - cis_1.2_cloud_lockout_order.yml

- "1.2.2 | PATCH | Ensure Account lockout threshold is set to 5 or fewer invalid logon attempt(s), but not 0."
- "1.2.1 | PATCH | Ensure Account lockout duration is set to 15 or more minutes."
- "1.2.4 | PATCH | Ensure Reset account lockout counter after is set to 15 or more minutes."

### Section 1 main.yml

- "SECTION | 1.1 | Password Policy"
- "SECTION | 1.2 | Account Lockout Policy"

## Section 2 - Local Policies

### Section 2.2

#### Section 2.2 User Right Assignment - cis_2.2.x.yml

- "2.2.1 | PATCH | Ensure Access Credential Manager as a trusted caller is set to No One."
- "2.2.2 | PATCH | Ensure Access this computer from the network is set to Administrators, Remote Desktop Users."
- "2.2.3 | PATCH | Ensure Act as part of the operating system is set to No One."
- "2.2.4 | PATCH | Ensure Adjust memory quotas for a process is set to Administrators, LOCAL SERVICE, NETWORK SERVICE."
- "2.2.5 | PATCH | Ensure Allow log on locally is set to Administrators, Users."
- "2.2.6 | PATCH | Ensure Allow log on through Remote Desktop Services is set to Administrators, Remote Desktop Users."
- "2.2.7 | PATCH | Ensure Back up files and directories is set to Administrators."
- "2.2.8 | PATCH | Ensure Change the system time is set to Administrators, LOCAL SERVICE."
- "2.2.9 | PATCH | Ensure Change the time zone is set to Administrators, LOCAL SERVICE, Users."
- "2.2.10 | PATCH | Ensure Create a pagefile is set to Administrators."
- "2.2.11 | PATCH | Ensure Create a token object is set to No One."
- "2.2.12 | PATCH | Ensure Create global objects is set to Administrators, LOCAL SERVICE, NETWORK SERVICE, SERVICE."
- "2.2.13 | PATCH | Ensure Create permanent shared objects is set to No One."
- "2.2.14 | PATCH | Configure Create symbolic links is set to Administrators Or Add NT VIRTUAL MACHINE when Hyper-V Installed."
- "2.2.15 | PATCH | Ensure Debug programs is set to Administrators."
- "2.2.16 | PATCH | Ensure Deny access to this computer from the network to include Guests."
- "2.2.17 | PATCH | Ensure Deny log on as a batch job to include Guests."
- "2.2.18 | PATCH | Ensure Deny log on as a service to include Guests."
- "2.2.19 | PATCH | Ensure Deny log on locally to include Guests."
- "2.2.20 | PATCH | Ensure Deny log on through Remote Desktop Services to include Guests."
- "2.2.21 | PATCH | Ensure Enable computer and user accounts to be trusted for delegation is set to No One."
- "2.2.22 | PATCH | Ensure Force shutdown from a remote system is set to Administrators."
- "2.2.23 | PATCH | Ensure Generate security audits is set to LOCAL SERVICE, NETWORK SERVICE."
- "2.2.24 | PATCH | Ensure Impersonate a client after authentication is set to Administrators, LOCAL SERVICE, NETWORK SERVICE, SERVICE, and when the Web Server IIS Role with Web Services Role Service is installed IIS IUSRS."
- "2.2.25 | PATCH | Ensure Increase scheduling priority is set to Administrators, Window Manager/Window Manager Group."
- "2.2.26 | PATCH | Ensure Load and unload device drivers is set to Administrators."
- "2.2.27 | PATCH | Ensure Lock pages in memory is set to No One."
- "2.2.28 | PATCH | Ensure Log on as a batch job is set to Administrators."
- "2.2.29 | PATCH | Configure Log on as a service."
- "2.2.30 | PATCH | Ensure Manage auditing and security log is set to Administrators."
- "2.2.31 | PATCH | Ensure Modify an object label is set to No One."
- "2.2.32 | PATCH | Ensure Modify firmware environment values is set to Administrators."
- "2.2.33 | PATCH | Ensure Perform volume maintenance tasks is set to Administrators."
- "2.2.34 | PATCH | Ensure Profile single process is set to Administrators."
- "2.2.35 | PATCH | Ensure Profile system performance is set to Administrators, NT SERVICE\\WdiServiceHost."
- "2.2.36 | PATCH | Ensure Replace a process level token is set to LOCAL SERVICE, NETWORK SERVICE."
- "2.2.37 | PATCH | Ensure Restore files and directories is set to Administrators."
- "2.2.38 | PATCH | Ensure Shut down the system is set to Administrators, Users."
- "2.2.39 | PATCH | Ensure Take ownership of files or other objects is set to Administrators"

### Section 2.3

#### Section 2.3.1 Accounts - cis_2.3.1.x.yml

- "2.3.1.1 | PATCH | Ensure Accounts Block Microsoft accounts is set to Users cant add or log on with Microsoft accounts."
- "2.3.1.2 | PATCH | Ensure Accounts Guest account status is set to Disabled."
- "2.3.1.3 | PATCH | Ensure Accounts Limit local account use of blank passwords to console logon only is set to Enabled."
- "2.3.1.4 | PATCH | Configure Accounts Rename administrator account."
- "2.3.1.5 | PATCH | Configure Accounts Rename guest account."

#### Section 2.3.2 Audit - cis_2.3.2.x.yml

- "2.3.2.1 | PATCH | Ensure Audit Force audit policy subcategory settings Windows Vista or later to override audit policy category settings is set to Enabled"
- "2.3.2.2 | PATCH | Ensure Audit Shut down system immediately if unable to log security audits is set to Disabled"

#### Section 2.3.4 Devices - cis_2.3.4.x.yml

- "2.3.4.1 | PATCH | Ensure Devices Prevent users from installing printer drivers is set to Enabled"

#### Section 2.3.6 Domain Member - cis_2.3.6.x.yml

- "2.3.6.1 | PATCH | Ensure Domain member Digitally encrypt or sign secure channel data always is set to Enabled"
- "2.3.6.2 | PATCH | Ensure Domain member Digitally encrypt secure channel data when possible is set to Enabled"
- "2.3.6.3 | PATCH | Ensure Domain member Digitally sign secure channel data when possible is set to Enabled"
- "2.3.6.4 | PATCH | Ensure Domain member Disable machine account password changes is set to Disabled"
- "2.3.6.5 | PATCH | Ensure Domain member Maximum machine account password age is set to 30 or fewer days but not 0"
- "2.3.6.6 | PATCH | Ensure Domain member Require strong Windows 2000 or later session key is set to Enabled"

#### Section 2.3.7 Interactive Logon - cis_2.3.7.x.yml

- "2.3.7.1 | PATCH | Ensure Interactive logon Do not require CTRL-ALT-DEL is set to Disabled."
- "2.3.7.2 | PATCH | Ensure Interactive logon Dont display last signed-in is set to Enabled."
- "2.3.7.3 | PATCH | Ensure Interactive logon: Machine account lockout threshold is set to 10 or fewer invalid logon attempts, but not 0."
- "2.3.7.4 | PATCH | Ensure Interactive logon Machine inactivity limit is set to 900 or fewer seconds but not 0"
- "2.3.7.5 | PATCH | Configure Interactive logon Message title for users attempting to log on."
- "2.3.7.6 | PATCH | Configure Interactive logon Message title for users attempting to log on."
- "2.3.7.7 | PATCH | Ensure 'Interactive logon: Number of previous logons to cache (in case domain controller is not available)' is set to '4 or fewer logon(s)'"
- "2.3.7.8 | PATCH | Ensure Interactive logon Prompt user to change password before expiration is set to between 5 and 14 days"
- "2.3.7.9 | PATCH | Ensure Interactive logon Smart card removal behavior is set to Lock Workstation or higher."

#### Section 2.3.8 Microsoft Network Client - cis_2.3.8.x.yml

- "2.3.8.1 | PATCH | Ensure Microsoft network client Digitally sign communications always is set to Enabled."
- "2.3.8.2 | PATCH | Ensure Microsoft network client Digitally sign communications if server agrees is set to Enabled"
- "2.3.8.3 | PATCH | Ensure Microsoft network client Send unencrypted password to third-party SMB servers is set to Disabled"

#### Section 2.3.9 Microsoft Network Server - cis_2.3.9.x.yml

- "2.3.9.1 | PATCH | Ensure Microsoft network server Amount of idle time required before suspending session is set to 15 or fewer minutes"
- "2.3.9.2 | PATCH | Ensure Microsoft network server Digitally sign communications always is set to Enabled."
- "2.3.9.3 | PATCH | Ensure Microsoft network server Digitally sign communications if client agrees is set to Enabled."
- "2.3.9.4 | PATCH | Ensure Microsoft network server Disconnect clients when logon hours expire is set to Enabled."
- "2.3.9.5 | PATCH | Ensure Microsoft network server Server SPN target name validation level is set to Accept if provided by client or higher."

#### Section 2.3.10 Network Access - cis_2.3.10.x.yml

- "2.3.10.1 | PATCH | Ensure Network access Allow anonymous SID Name translation is set to Disabled."
- "2.3.10.2 | PATCH | Ensure Network access Do not allow anonymous enumeration of SAM accounts is set to Enabled."
- "2.3.10.3 | PATCH | Ensure Network access Do not allow anonymous enumeration of SAM accounts and shares is set to Enabled."
- "2.3.10.4 | PATCH | Ensure Network access Do not allow storage of passwords and credentials for network authentication is set to Enabled."
- "2.3.10.5 | PATCH | Ensure Network access Let Everyone permissions apply to anonymous users is set to Disabled."
- "2.3.10.6 | PATCH | Ensure 'Network access: Named Pipes that can be accessed anonymously' is set to 'None'."
- "2.3.10.7 | PATCH | Ensure 'Network access: Remotely accessible registry paths' is configured."
- "2.3.10.8 | PATCH | Configure Network access Remotely accessible registry paths and sub-paths is configured."
- "2.3.10.9 | PATCH | Ensure Network access Restrict anonymous access to Named Pipes and Shares is set to Enabled."
- "2.3.10.10 | PATCH | Ensure Network access Restrict clients allowed to make remote calls to SAM is set to Administrators, Remote Access Allow."
- "2.3.10.11 | PATCH | Ensure Network access Shares that can be accessed anonymously is set to None."
- "2.3.10.12 | PATCH | Ensure Network access Sharing and security model for local accounts is set to Classic - local users authenticate as themselves"

#### Section 2.3.11 Network Security - cis_2.3.11.x.yml

- "2.3.11.1 | PATCH | Ensure Network security Allow Local System to use computer identity for NTLM is set to Enabled."
- "2.3.11.2 | PATCH | Ensure Network security Allow LocalSystem NULL session fallback is set to Disabled."
- "2.3.11.3 | PATCH | Ensure Network Security Allow PKU2U authentication requests to this computer to use online identities is set to Disabled."
- "2.3.11.4 | PATCH | Ensure Network security Configure encryption types allowed for Kerberos is set to AES128 HMAC SHA1 AES256 HMAC SHA1 Future encryption types."
- "2.3.11.5 | PATCH | Ensure Network security Do not store LAN Manager hash value on next password change is set to Enabled."
- "2.3.11.6 | PATCH | Ensure Network security Force logoff when logon hours expire is set to Enabled."
- "2.3.11.7 | PATCH | Ensure Network security LAN Manager authentication level is set to Send NTLMv2 response only. Refuse LM NTLM"
- "2.3.11.8 | PATCH | Ensure Network security LDAP client signing requirements is set to Negotiate signing or higher."
- "2.3.11.9 | PATCH | Ensure Network security Minimum session security for NTLM SSP based including secure RPC clients is set to Require NTLMv2 session security Require 128-bit encryption."
- "2.3.11.10 | PATCH | Ensure Network security Minimum session security for NTLM SSP based including secure RPC servers is set to Require NTLMv2 session security Require 128-bit encryption."
- "2.3.11.11 | PATCH | Ensure 'Network security: Restrict NTLM: Audit Incoming NTLM Traffic' is set to 'Enable auditing for all accounts'"
- "2.3.11.12 | PATCH | Ensure 'Network security: Restrict NTLM: Outgoing NTLM traffic to remote servers' is set to 'Audit all' or higher'"

#### Section 2.3.14 System Cryptography - cis_2.3.14.x.yml

- "2.3.14.1 | PATCH | Ensure 'System cryptography: Force strong key protection for user keys stored on the computer' is set to 'User is prompted when the key is first used' or higher."

#### Section 2.3.15 System Objects - cis_2.3.15.x.yml

- "2.3.15.1 | PATCH | Ensure System objects Require case insensitivity for non-Windows subsystems is set to Enabled."
- "2.3.15.2 | PATCH | Ensure System objects Strengthen default permissions of internal system objects e.g. Symbolic Links is set to Enabled."

#### Section 2.3.17 User Account Control - cis_2.3.17.x.yml

- "2.3.17.1 | PATCH | Ensure User Account Control Admin Approval Mode for the Built-in Administrator account is set to Enabled."
- "2.3.17.2 | PATCH | Ensure 'User Account Control: Behavior of the elevation prompt for administrators in Admin Approval Mode' is set to 'Prompt for consent on the secure desktop' or higher."
- "2.3.17.3 | PATCH | Ensure User Account Control Behavior of the elevation prompt for standard users is set to Automatically deny elevation requests."
- "2.3.17.4 | PATCH | Ensure User Account Control Detect application installations and prompt for elevation is set to Enabled."
- "2.3.17.5 | PATCH | Ensure User Account Control Only elevate UIAccess applications that are installed in secure locations is set to Enabled."
- "2.3.17.6 | PATCH | Ensure User Account Control Run all administrators in Admin Approval Mode is set to Enabled."
- "2.3.17.7 | PATCH | Ensure User Account Control Switch to the secure desktop when prompting for elevation is set to Enabled."
- "2.3.17.8 | PATCH | Ensure User Account Control Virtualize file and registry write failures to per-user locations is set to Enabled"

### Section 2 main.yml

- "SECTION | 2.2 | User Right Assignment"
- "SECTION | 2.3.1 | Accounts"
- "SECTION | 2.3.2 | Audit"
- "SECTION | 2.3.4 | Devices"
- "SECTION | 2.3.6 | Domain Member"
- "SECTION | 2.3.7 | Interactive Logon"
- "SECTION | 2.3.8 | Microsoft Network Client"
- "SECTION | 2.3.9 | Microsoft Network Server"
- "SECTION | 2.3.10 | Network Access"
- "SECTION | 2.3.11 | Network Security"
- "SECTION | 2.3.14 | System Cryptography"
- "SECTION | 2.3.15 | System Objects"
- "SECTION | 2.3.17 | User Account Control"

## Section 5 - System Services

### Section 5 System Services - cis_5.x.yml

- "5.1 | PATCH | Ensure 'Bluetooth Audio Gateway Service (BTAGService)' is set to 'Disabled'."
- "5.2 | PATCH | Ensure 'Bluetooth Support Service (bthserv) is set to Disabled."
- "5.3 | PATCH | Ensure 'Computer Browser (Browser)' is set to 'Disabled' or 'Not Installed'."
- "5.4 | PATCH | Ensure 'Downloaded Maps Manager (MapsBroker)' is set to 'Disabled'."
- "5.5 | PATCH | Ensure 'Geolocation Service (lfsvc)' is set to 'Disabled'."
- "5.6 | PATCH | Ensure 'IIS Admin Service (IISADMIN)' is set to 'Disabled' or 'Not Installed'."
- "5.7 | PATCH | Ensure 'Infrared monitor service (irmon)' is set to 'Disabled' or 'Not Installed'."
- "5.8 | PATCH | Ensure 'Link-Layer Topology Discovery Mapper (lltdsvc)' is set to 'Disabled'."
- "5.9 | PATCH | Ensure 'LxssManager (LxssManager)' is set to 'Disabled' or 'Not Installed'."
- "5.10 | PATCH | Ensure 'Microsoft FTP Service (FTPSVC)' is set to 'Disabled' or 'Not Installed'."
- "5.11 | PATCH | Ensure 'Microsoft iSCSI Initiator Service (MSiSCSI)' is set to 'Disabled' (Automated)."
- "5.12 | PATCH | Ensure 'OpenSSH SSH Server (sshd)' is set to 'Disabled' or 'Not Installed'."
- "5.13 | PATCH | Ensure 'Peer Name Resolution Protocol (PNRPsvc)' is set to 'Disabled' (Automated)."
- "5.14 | PATCH | Ensure 'Peer Networking Grouping (p2psvc)' is set to 'Disabled'."
- "5.15 | PATCH | Ensure 'Peer Networking Identity Manager (p2pimsvc)' is set to 'Disabled'."
- "5.16 | PATCH | Ensure 'PNRP Machine Name Publication Service (PNRPAutoReg)' is set to 'Disabled'."
- "5.17 | PATCH | Ensure 'Print Spooler (Spooler)' is set to 'Disabled'."
- "5.18 | PATCH | Ensure 'Problem Reports and Solutions Control Panel Support (wercplsupport)' is set to 'Disabled'."
- "5.19 | PATCH | Ensure 'Remote Access Auto Connection Manager (RasAuto)' is set to 'Disabled'."
- "5.20 | PATCH | Ensure 'Remote Desktop Configuration (SessionEnv)' is set to 'Disabled'."
- "5.21 | PATCH | Ensure 'Remote Desktop Services (TermService)' is set to 'Disabled'."
- "5.22 | PATCH | Ensure 'Remote Desktop Services UserMode Port Redirector (UmRdpService)' is set to 'Disabled'."
- "5.23 | PATCH | Ensure 'Remote Procedure Call (RPC) Locator (RpcLocator)' is set to 'Disabled'."
- "5.24 | PATCH | Ensure 'Remote Registry (RemoteRegistry)' is set to 'Disabled'."
- "5.25 | PATCH | Ensure 'Routing and Remote Access (RemoteAccess)' is set to 'Disabled'."
- "5.26 | PATCH | Ensure 'Server (LanmanServer)' is set to 'Disabled'."
- "5.27 | PATCH | Ensure 'Simple TCP/IP Services (simptcp)' is set to 'Disabled' or 'Not Installed'."
- "5.28 | PATCH | Ensure 'SNMP Service (SNMP)' is set to 'Disabled' or 'Not Installed'."
- "5.29 | PATCH | Ensure 'Special Administration Console Helper (sacsvr)' is set to 'Disabled' or 'Not Installed'."
- "5.30 | PATCH | Ensure 'SSDP Discovery (SSDPSRV)' is set to 'Disabled'."
- "5.31 | PATCH | Ensure 'UPnP Device Host (upnphost)' is set to 'Disabled'."
- "5.32 | PATCH | Ensure 'Web Management Service (WMSvc)' is set to 'Disabled' or 'Not Installed'."
- "5.33 | PATCH | Ensure 'Windows Error Reporting Service (WerSvc)' is set to 'Disabled'."
- "5.34 | PATCH | Ensure 'Windows Event Collector (Wecsvc)' is set to 'Disabled' (Automated)."
- "5.35 | PATCH | Ensure 'Windows Media Player Network Sharing Service (WMPNetworkSvc)' is set to 'Disabled' or 'Not Installed'."
- "5.36 | PATCH | Ensure 'Windows Mobile Hotspot Service (icssvc)' is set to 'Disabled'."
- "5.37 | PATCH | Ensure 'Windows Push Notifications System Service (WpnService)' is set to 'Disabled'."
- "5.38 | PATCH | Ensure 'Windows PushToInstall Service (PushToInstall)' is set to 'Disabled'."
- "5.39 | PATCH | Ensure 'Windows Remote Management (WS-Management) (WinRM)' is set to 'Disabled'."
- "5.40 | PATCH | Ensure 'World Wide Web Publishing Service (W3SVC)' is set to 'Disabled' or 'Not Installed."
- "5.41 | PATCH | Ensure 'Xbox Accessory Management Service (XboxGipSvc)' is set to 'Disabled'"
- "5.42 | PATCH | Ensure 'Xbox Live Auth Manager (XblAuthManager)' is set to 'Disabled'"
- "5.43 | PATCH | Ensure 'Xbox Live Game Save (XblGameSave)' is set to 'Disabled'"
- "5.44 | PATCH | Ensure 'Xbox Live Networking Service (XboxNetApiSvc)' is set to 'Disabled'"

### Section 5 main.yml

- "SECTION | 5.x | System Services"

## Section 9 - Windows Firewall

### Section 9.1

#### Section 9.1 Domain Profile - cis_9.1.x.yml

- "9.1.1 | PATCH | Ensure 'Windows Firewall: Domain: Firewall state' is set to 'On (recommended)'"
- "9.1.2 | PATCH | Ensure 'Windows Firewall: Domain: Inbound connections' is set to 'Block (default)'"
- "9.1.3 | PATCH | Ensure 'Windows Firewall: Domain: Settings: Display a notification' is set to 'No'"
- "9.1.4 | PATCH | Ensure 'Windows Firewall: Domain: Logging: Name' is set to '%SystemRoot%/System32/logfiles/firewall/domainfw.log'"
- "9.1.5 | PATCH | Ensure 'Windows Firewall: Domain: Logging: Size limit (KB)' is set to '16,384 KB or greater'"
- "9.1.6 | PATCH | Ensure 'Windows Firewall: Domain: Logging: Log dropped packets' is set to 'Yes'"
- "9.1.7 | PATCH | Ensure 'Windows Firewall: Domain: Logging: Log successful connections' is set to 'Yes'"

### Section 9.2

#### Section 9.2  Private Profile - cis_9.2.x.yml

- "9.2.1 | PATCH | Ensure 'Windows Firewall: Private: Firewall state' is set to 'On (recommended)'"
- "9.2.2 | PATCH | Ensure 'Windows Firewall: Private: Inbound connections' is set to 'Block (default)'"
- "9.2.3 | PATCH | Ensure 'Windows Firewall: Private: Settings: Display a notification' is set to 'No'"
- "9.2.4 | PATCH | Ensure 'Windows Firewall: Private: Logging: Name' is set to '%SystemRoot%/System32/logfiles/firewall/privatefw.log'"
- "9.2.5 | PATCH | Ensure 'Windows Firewall: Private: Logging: Size limit (KB)' is set to '16,384 KB or greater'"
- "9.2.6 | PATCH | Ensure 'Windows Firewall: Private: Logging: Log dropped packets' is set to 'Yes'"
- "9.2.7 | PATCH | Ensure 'Windows Firewall: Private: Logging: Log successful connections' is set to 'Yes'"

### Section 9.3

#### Section 9.3 Public Profile - cis_9.3.x.yml

- "9.3.1 | PATCH | Ensure 'Windows Firewall: Public: Firewall state' is set to 'On (recommended)'"
- "9.3.2 | PATCH | Ensure 'Windows Firewall: Public: Inbound connections' is set to 'Block (default)'"
- "9.3.3 | PATCH | Ensure 'Windows Firewall: Public: Settings: Display a notification' is set to 'No'"
- "9.3.4 | PATCH | Ensure 'Windows Firewall: Public: Settings: Apply local firewall rules' is set to 'No'"
- "9.3.5 | PATCH | Ensure 'Windows Firewall: Public: Settings: Apply local connection security rules' is set to 'No'"
- "9.3.6 | PATCH | Ensure 'Windows Firewall: Public: Logging: Name' is set to '%SystemRoot%/System32/logfiles/firewall/publicfw.log'"
- "9.3.7 | PATCH | Ensure 'Windows Firewall: Public: Logging: Size limit (KB)' is set to '16,384 KB or greater'"
- "9.3.8 | PATCH | Ensure 'Windows Firewall: Public: Logging: Log dropped packets' is set to 'Yes'"
- "9.3.9 | PATCH | Ensure 'Windows Firewall: Public: Logging: Log successful connections' is set to 'Yes'"

### Section 9 main.yml

- "SECTION | 9.1 | Domain Profile"
- "SECTION | 9.2 | Private Profile"
- "SECTION | 9.3 | Public Profile"

## Section 17 - Advanced Audit Policy

### Section 17.1

#### Section 17.1 Account Logon - cis_17.1.x.yml

- "17.1.1 | PATCH | Ensure Audit Credential Validation is set to Success and Failure"

### Section 17.2

#### Section 17.2 Account Management - cis_17.2.x.yml

- "17.2.1 | PATCH | Ensure Audit Application Group Management is set to Success and Failure"
- "17.2.2 | PATCH | Ensure Audit Security Group Management is set to include Success"
- "17.2.3 | PATCH | Ensure Audit User Account Management is set to Success and Failure"

### Section 17.3

#### Section 17.3 Detail Tracking - cis_17.3.x.yml

- "17.3.1 | PATCH | Ensure Audit PNP Activity is set to include Success"
- "17.3.2 | PATCH | Ensure Audit Process Creation is set to include Success"

### Section 17.5

#### Section 17.5 Logon/Logoff - cis_17.5.x.yml

- "17.5.1 | PATCH | Ensure Audit Account Lockout is set to include Failure"
- "17.5.2 | PATCH | Ensure Audit Group Membership is set to include Success"
- "17.5.3 | PATCH | Ensure Audit Logoff is set to include Success"
- "17.5.4 | PATCH | Ensure Audit Logon is set to Success and Failure"
- "17.5.5 | PATCH | Ensure Audit Other LogonLogoff Events is set to Success and Failure"
- "17.5.6 | PATCH | Ensure Audit Special Logon is set to include Success"

### Section 17.6

#### Section 17.6 Object Access - cis_17.6.x.yml

- "17.6.1 | PATCH | Ensure Audit Detailed File Share is set to include Failure"
- "17.6.2 | PATCH | Ensure Audit File Share is set to Success and Failure"
- "17.6.3 | PATCH | Ensure Audit Other Object Access Events is set to Success and Failure"
- "17.6.4 | PATCH | Ensure Audit Removable Storage is set to Success and Failure"

### Section 17.7

#### Section 17.7 Policy Change - cis_17.7.x.yml

- "17.7.1 | PATCH | Ensure Audit Audit Policy Change is set to include Success"
- "17.7.2 | PATCH | Ensure Audit Authentication Policy Change is set to include Success"
- "17.7.3 | PATCH | Ensure Audit Authorization Policy Change is set to include Success"
- "17.7.4 | PATCH | Ensure Audit MPSSVC Rule-Level Policy Change is set to Success and Failure"
- "17.7.5 | PATCH | Ensure Audit Other Policy Change Events is set to include Failure"

### Section 17.8

#### Section 17.8 Privilege Use - cis_17.8.x.yml

- "17.8.1 | PATCH | Ensure Audit Sensitive Privilege Use is set to Success and Failure"

### Section 17.9

#### Section 17.9 System - cis_17.9.x.yml

- "17.9.1 | PATCH | Ensure Audit IPsec Driver is set to Success and Failure"
- "17.9.2 | PATCH | Ensure Audit Other System Events is set to Success and Failure"
- "17.9.3 | PATCH | Ensure Audit Security State Change is set to include Success"
- "17.9.4 | PATCH | Ensure Audit Security System Extension is set to include Success"
- "17.9.5 | PATCH | Ensure Audit System Integrity is set to Success and Failure"

### Section 17 main.yml

- "SECTION | 17.1 | Account Logon"
- "SECTION | 17.2 | Account Management"
- "SECTION | 17.3 | Detail Tracking"
- "SECTION | 17.5 | Logon/Logoff"
- "SECTION | 17.6 | Object Access"
- "SECTION | 17.7 | Policy Change"
- "SECTION | 17.8 | Privilege Use"
- "SECTION | 17.9 | System"

## Section 18 - Administrative Templates (Computers)

### Section 18.1

#### Section 18.1.1 Personalization - cis_18.1.1.x.yml

- "18.1.1.1 | PATCH | Ensure Prevent enabling lock screen camera is set to Enabled"
- "18.1.1.2 | PATCH | Ensure Prevent enabling lock screen slide show is set to Enabled"

#### Section 18.1.2 Regional and Language Options - cis_18.1.2.x.yml

- "18.1.2.2 | PATCH | Ensure Allow users to enable online speech recognition services is set to Disabled"

#### Section 18.1.3 Online Tips - cis_18.1.3.x.yml

- "18.1.3 | PATCH | Ensure Allow Online Tips is set to Disabled"

### Section 18.4

#### Section 18.4 MS Security Guide - cis_18.4.x.yml

- "18.4.1 | PATCH | Ensure Apply UAC restrictions to local accounts on network logons is set to Enabled."
- "18.4.2 | PATCH | 18.4.2 | Ensure 'Configure RPC packet level privacy setting for incoming connections' is set to 'Enabled'"
- "18.4.3 | PATCH | Ensure Configure SMB v1 client driver is set to Enabled Disable driver recommended"
- "18.4.4 | PATCH | Ensure Configure SMB v1 server is set to Disabled"
- "18.4.5 | PATCH | Ensure 'Enable Certificate Padding' is set to 'Enabled'"
- "18.4.6 | PATCH | Ensure Enable Structured Exception Handling Overwrite Protection SEHOP is set to Enabled"
- "18.4.7 | PATCH | Ensure 'NetBT NodeType configuration' is set to 'Enabled: P-node recommended'"
- "18.4.8 | PATCH | Ensure WDigest Authentication is set to Disabled"

### Section 18.5

#### Section 18.5 MSS (Legacy) - cis_18.5.x.yml

- "18.5.1 | PATCH | Ensure MSS AutoAdminLogon Enable Automatic Logon not recommended is set to Disabled"
- "18.5.2 | PATCH | Ensure 'MSS: (DisableIPSourceRouting IPv6) IP source routing protection level' is set to 'Enabled: Highest protection, source routing is completely disabled'"
- "18.5.3 | PATCH | Ensure 'MSS: (DisableIPSourceRouting) IP source routing protection level' is set to 'Enabled: Highest protection, source routing is completely disabled'"
- "18.5.4 | PATCH | Ensure 'MSS: (DisableSavePassword) Prevent the dial-up password from being saved' is set to 'Enabled'"
- "18.5.5 | PATCH | Ensure MSS EnableICMPRedirect Allow ICMP redirects to override OSPF generated routes is set to Disabled"
- "18.5.6 | PATCH | Ensure MSS KeepAliveTime How often keep-alive packets are sent in milliseconds is set to Enabled 300000 or 5 minutes recommended"
- "18.5.7 | PATCH | Ensure MSS NoNameReleaseOnDemand Allow the computer to ignore NetBIOS name release requests except from WINS servers is set to Enabled"
- "18.5.8 | PATCH | Ensure 'MSS: (PerformRouterDiscovery) Allow IRDP to detect and configure Default Gateway addresses' is set to 'Disabled'"
- "18.5.9 | PATCH | Ensure MSS SafeDllSearchMode Enable Safe DLL search mode recommended is set to Enabled"
- "18.5.10 | PATCH | Ensure MSS ScreenSaverGracePeriod The time in seconds before the screen saver grace period expires 0 recommended is set to Enabled 5 or fewer seconds"
- "18.5.11 | PATCH | Ensure MSS TcpMaxDataRetransmissions IPv6 How many times unacknowledged data is retransmitted is set to Enabled 3"
- "18.5.12 | PATCH | Ensure MSS TcpMaxDataRetransmissions How many times unacknowledged data is retransmitted is set to Enabled 3"
- "18.5.13 | PATCH | Ensure MSS WarningLevel Percentage threshold for the security event log at which the system will generate a warning is set to Enabled 90 or less"

### Section 18.6

#### Section 18.6.4 DNS Client - cis_18.6.4.x.yml

- "18.6.4.1 | PATCH | Ensure Configure DNS over HTTPS (DoH) name resolution is set to Enabled: Allow DoH or higher"
- "18.6.4.2 | PATCH | Ensure 'Configure NetBIOS settings' is set to 'Enabled: Disable NetBIOS name resolution on public networks'"
- "18.6.4.3 | PATCH | Ensure Turn off multicast name resolution is set to Enabled."

#### Section 18.6.5 Fonts - cis_18.6.5.x.yml

- "18.6.5.1 | PATCH | Ensure Enable Font Providers is set to Disabled"

#### Section 18.6.8 Lanman Workstation - cis_18.6.8.x.yml

- "18.6.8.1 | PATCH | Ensure Enable insecure guest logons is set to Disabled"

#### Section 18.6.9 Link-Layer Topology Discovery - cis_18.6.9.x.yml

- "18.6.9.1 | PATCH | Ensure Turn on Mapper IO LLTDIO driver is set to Disabled"
- "18.6.9.2 | PATCH | Ensure Turn on Responder RSPNDR driver is set to Disabled"

#### Section 18.6.10 Microsoft Peer-to-Peer Networking Services - cis_18.6.10.x.yml

- "18.6.10.2 | PATCH | Ensure Turn off Microsoft Peer-to-Peer Networking Services is set to Enabled"

#### Section 18.6.11 Network Connections - cis_18.6.11.x.yml

- "18.6.11.2 | PATCH | Ensure Prohibit installation and configuration of Network Bridge on your DNS domain network is set to Enabled"
- "18.6.11.3 | PATCH | Ensure Prohibit use of Internet Connection Sharing on your DNS domain network is set to Enabled"
- "18.6.11.4 | PATCH | Ensure Require domain users to elevate when setting a networks location is set to Enabled"

#### Section 18.6.14 Network Provider - cis_18.6.14.x.yml

- "18.6.14.1 | PATCH | Ensure Hardened UNC Paths is set to Enabled with Require Mutual Authentication and Require Integrity set for all NETLOGON and SYSVOL shares"

#### Section 18.6.19 TCP/IP Settings - cis_18.6.19.2.x.yml

- "18.6.19.2.1 | PATCH | Disable IPv6 Ensure TCPIP6 Parameter DisabledComponents is set to 0xff 255"

#### Section 18.6.20 Windows Connect Now - cis_18.6.20.x.yml

- "18.6.20.1 | PATCH | Ensure Configuration of wireless settings using Windows Connect Now is set to Disabled"
- "18.6.20.2 | PATCH | Ensure Prohibit access of the Windows Connect Now wizards is set to Enabled"

#### Section 18.6.21 Windows Connnection Manager - cis_18.6.21.x.yml

- "18.6.21.1 | PATCH | Ensure 'Minimize the number of simultaneous connections to the Internet or a Windows Domain' is set to 'Enabled: 3 = Prevent Wi-Fi when on Ethernet'"
- "18.6.21.2 | PATCH | Ensure 'Prohibit connection to non-domain networks when connected to domain authenticated network' is set to 'Enabled'"

#### Section 18.6.23 WLAN Service - cis_18.6.23.2.x.yml

- "18.6.23.2.1 | PATCH | Ensure 'Allow Windows to automatically connect to suggested open hotspots, to networks shared by contacts, and to hotspots offering paid services' is set to 'Disabled'"

### Section 18.7

#### Section 18.7 Printers - cis_18.7.x.yml

- "18.7.1 | PATCH | Ensure Allow Print Spooler to accept client connections is set to Disabled"
- "18.7.2 | PATCH | Ensure 'Configure Redirection Guard' is set to 'Enabled: Redirection Guard Enabled'"
- "18.7.3 | PATCH | Ensure 'Configure RPC connection settings: Protocol to use for outgoing RPC connections' is set to 'Enabled: RPC over TCP'."
- "18.7.4 | PATCH | Ensure 'Configure RPC connection settings: Use authentication for outgoing RPC connections' is set to 'Enabled: Default'."
- "18.7.5 | PATCH | Ensure 'Configure RPC listener settings: Protocols to allow for incoming RPC connections' is set to 'Enabled: RPC over TCP'."
- "18.7.6 | PATCH | Ensure 'Configure RPC listener settings: Authentication protocol to use for incoming RPC connections:' is set to 'Enabled: Negotiate' or higher."
- "18.7.7 | PATCH | Ensure 'Configure RPC over TCP port' is set to 'Enabled: 0'."
- "18.7.8 | PATCH | Ensure 'Limits print driver installation to Administrators' is set to 'Enabled'"
- "18.7.9 | PATCH | Ensure 'Manage processing of Queue-specific files' is set to 'Enabled: Limit Queue-specific files to Color profiles'"
- "18.7.10 | PATCH | Ensure Point and Print Restrictions: When installing drivers for a new connection is set to Enabled: Show warning and elevation prompt"
- "18.7.11 | PATCH | Ensure Point and Print Restrictions: When updating drivers for an existing connection is set to Enabled: Show warning and elevation prompt"

### Section 18.8

#### Section 18.8.1 Notification - cis_18.8.1.x.yml

- "18.8.1.1 | PATCH | Ensure Turn off notifications network usage is set to Enabled"

### Section 18.9

#### Section 18.9.3 Audit Process Creation - cis_18.9.3.x.yml

- "18.9.3.1 | PATCH | Ensure Include command line in process creation events is set to Enabled."

#### Section 18.9.4 Credentials Delegation - cis_18.9.4.x.yml

- "18.9.4.1 | PATCH | Ensure Encryption Oracle Remediation is set to Enabled Force Updated Clients"
- "18.9.4.2 | PATCH | Ensure Remote host allows delegation of non-exportable credentials is set to Enabled"

#### Section 18.9.5 Device Guard - cis_18.9.5.x.yml

- "18.9.5.1 | PATCH | Ensure Turn On Virtualization Based Security is set to Enabled"
- "18.9.5.2 | PATCH | Ensure 'Turn On Virtualization Based Security: Select Platform Security Level' is set to 'Secure Boot' or higher"
- "18.9.5.3 | PATCH | Ensure Turn On Virtualization Based Security Virtualization Based Protection of Code Integrity is set to Enabled with UEFI lock"
- "18.9.5.4 | PATCH | Ensure Turn On Virtualization Based Security Require UEFI Memory Attributes Table is set to True checked"
- "18.9.5.5 | PATCH | Ensure Turn On Virtualization Based Security Credential Guard Configuration is set to Enabled with UEFI lock"
- "18.9.5.6 | PATCH | Ensure Turn On Virtualization Based Security Secure Launch Configuration is set to Enabled"
- "18.9.5.7 | PATCH | Ensure 'Turn On Virtualization Based Security: Kernel-mode Hardware-enforced Stack Protection' is set to 'Enabled: Enabled in enforcement mode'"

#### Section 18.9.7 Device Installation - cis_18.9.7.x.yml

- "18.9.7.1.1 | PATCH | Ensure 'Prevent installation of devices that match any of these device IDs' is set to 'Enabled'"
- "18.9.7.1.2 | PATCH | Ensure 'Prevent installation of devices that match any of these device IDs: Prevent installation of devices that match any of these device IDs' is set to 'PCI\\CC_0C0A'"
- "18.9.7.1.3 | PATCH | Ensure 'Prevent installation of devices that match any of these device IDs: Also apply to matching devices that are already installed.' is set to 'True'"
- "18.9.7.1.4 | PATCH | Ensure 'Prevent installation of devices using drivers that match these device setup classes' is set to 'Enabled'"
- "18.9.7.1.5 | PATCH | Ensure 'Prevent installation of devices using drivers that match these device setup classes' is set to 'Enabled'"
- "18.9.7.1.6 | PATCH | Ensure 'Prevent installation of devices using drivers that match these device setup classes: Also apply to matching devices that are already installed.' is set to 'True'"
- "18.9.7.2 | PATCH | Ensure Prevent device metadata retrieval from the Internet is set to Enabled"

#### Section 18.9.13 Early Launch Antimalware - cis_18.9.13.x.yml

- "18.9.13.1 | PATCH | Ensure Boot-Start Driver Initialization Policy is set to Enabled Good unknown and bad but critical"

#### Section 18.9.19 Group Policy - cis_18.9.19.x.yml

- "18.9.19.2 | PATCH | Ensure Configure registry policy processing Do not apply during periodic background processing is set to Enabled FALSE"
- "18.9.19.3 | PATCH | Ensure Configure registry policy processing Process even if the Group Policy objects have not changed is set to Enabled TRUE"
- "18.9.19.4 | PATCH | Ensure 'Configure security policy processing: Do not apply during periodic background processing' is set to 'Enabled: FALSE'"
- "18.9.19.5 | PATCH | Ensure 'Configure security policy processing: Process even if the Group Policy objects have not changed' is set to 'Enabled: TRUE'"
- "18.9.19.6 | PATCH | Ensure Continue experiences on this device is set to Disabled"
- "18.9.19.7 | PATCH | Ensure Turn off background refresh of Group Policy is set to Disabled"

#### Section 18.9.20 Internet Connection Mangement - cis_18.9.20.x.yml

- "18.9.20.1.1 | PATCH | Ensure 'Turn off access to the Store' is set to 'Enabled'"
- "18.9.20.1.2 | PATCH | Ensure Turn off downloading of print drivers over HTTP is set to Enabled"
- "18.9.20.1.3 | PATCH | Ensure Turn off handwriting personalization data sharing is set to Enabled"
- "18.9.20.1.4 | PATCH | Ensure Turn off handwriting recognition error reporting is set to Enabled"
- "18.9.20.1.5 | PATCH | Ensure Turn off Internet Connection Wizard if URL connection is referring to Microsoft.com is set to Enabled"
- "18.9.20.1.6 | PATCH | Ensure Turn off Internet download for Web publishing and online ordering wizards is set to Enabled"
- "18.9.20.1.7 | PATCH | Ensure Turn off printing over HTTP is set to Enabled"
- "18.9.20.1.8 | PATCH | Ensure Turn off Registration if URL connection is referring to Microsoft.com is set to Enabled"
- "18.9.20.1.9 | PATCH | Ensure Turn off Search Companion content file updates is set to Enabled"
- "18.9.20.1.10 | PATCH | Ensure Turn off the Order Prints picture task is set to Enabled"
- "18.9.20.1.11 | PATCH | Ensure Turn off the Publish to Web task for files and folders is set to Enabled"
- "18.9.20.1.12 | PATCH | Ensure Turn off the Windows Messenger Customer Experience Improvement Program is set to Enabled"
- "18.9.20.1.13 | PATCH | Ensure Turn off Windows Customer Experience Improvement Program is set to Enabled"
- "18.9.20.1.14 | PATCH | Ensure Turn off Windows Error Reporting is set to Enabled"

#### Section 18.9.23 Kerberos - cis_18.9.23.x.yml

- "18.9.23.1 | PATCH | Ensure Support device authentication using certificate is set to Enabled Automatic"

#### Section 18.9.24 Kernel DMA Protection - cis_18.9.24.x.yml

- "18.9.24.1 | PATCH | Ensure Enumeration policy for external devices incompatible with Kernel DMA Protection is set to Enabled Block All"

#### Section 18.9.25 LAPS - cis_18.9.25.x.yml

- "18.9.25.1 | PATCH | Ensure 'Configure password backup directory' is set to 'Enabled: Active Directory' or 'Enabled: Azure Active Directory'"
- "18.9.25.2 | PATCH | Ensure 'Do not allow password expiration time longer than required by policy' is set to 'Enabled'."
- "18.9.25.3 | PATCH | Ensure 'Enable password encryption' is set to 'Enabled'"
- "18.9.25.4 | PATCH | Ensure 'Password Settings: Password Complexity' is set to 'Enabled: Large letters + small letters + numbers + special characters'"
- "18.9.25.5 | PATCH | Ensure 'Password Settings: Password Length' is set to 'Enabled: 15 or more'"
- "18.9.25.6 | PATCH | Ensure 'Password Settings: Password Age (Days)' is set to 'Enabled: 30 or fewer' "
- "18.9.25.7 | PATCH | Ensure 'Post-authentication actions: Grace period (hours)' is set to 'Enabled: 8 or fewer hours, but not 0'"
- "18.9.25.8 | PATCH | Ensure 'Post-authentication actions: Actions' is set to 'Enabled: Reset the password and logoff the managed account' or higher '"

#### Section 18.9.26 Local Security Authority - cis_18.9.26.x.yml

- "18.9.26.1 | PATCH | Ensure 'Allow Custom SSPs and APs to be loaded into LSASS' is set to 'Disabled'"
- "18.9.26.2 | PATCH | Ensure 'Configures LSASS to run as a protected process' is set to 'Enabled: Enabled with UEFI Lock'"

#### Section 18.9.27 Local Services - cis_18.9.27.x.yml

- "18.9.27.1 | PATCH | Ensure Disallow copying of user input methods to the system account for sign-in is set to Enabled"

#### Section 18.9.28 Logon - cis_18.9.28.x.yml

- "18.9.28.1 | PATCH | Ensure Block user from showing account details on sign-in is set to Enabled"
- "18.9.28.2 | PATCH | Ensure Do not display network selection UI is set to Enabled"
- "18.9.28.3 | PATCH | Ensure Do not enumerate connected users on domain-joined computers is set to Enabled"
- "18.9.28.4 | PATCH | Ensure Enumerate local users on domain-joined computers is set to Disabled"
- "18.9.28.5 | PATCH | Ensure Turn off app notifications on the lock screen is set to Enabled"
- "18.9.28.6 | PATCH | Ensure Turn off picture password sign-in is set to Enabled"
- "18.9.28.7 | PATCH | Ensure Turn on convenience PIN sign-in is set to Disabled"

#### Section 18.9.31 OS Policies - cis_18.9.31.x.yml

- "18.9.31.1 | PATCH | Ensure Allow Clipboard synchronization across devices is set to Disabled"
- "18.9.31.2 | PATCH | Ensure Allow upload of User Activities is set to Disabled"

#### Section 18.9.33 Power Mangement - cis_18.9.33.x.yml

- "18.9.33.6.1 | PATCH | Ensure Allow network connectivity during connected-standby on battery is set to Disabled"
- "18.9.33.6.2 | PATCH | Ensure Allow network connectivity during connected-standby plugged in is set to Disabled"
- "18.9.33.6.3 | PATCH | Ensure 'Allow standby states (S1-S3) when sleeping (on battery)' is set to 'Disabled'"
- "18.9.33.6.4 | PATCH | Ensure 'Allow standby states (S1-S3) when sleeping (plugged in)' is set to 'Disabled'"
- "18.9.33.6.5 | PATCH | Ensure Require a password when a computer wakes on battery is set to Enabled"
- "18.9.33.6.6 | PATCH | Ensure Require a password when a computer wakes plugged in is set to Enabled"

#### Section 18.9.35 Remote Assistance - cis_18.9.35.x.yml

- "18.9.35.1 | PATCH | Ensure Configure Offer Remote Assistance is set to Disabled"
- "18.9.35.2 | PATCH | Ensure Configure Solicited Remote Assistance is set to Disabled"

#### Section 18.9.36 Remote Procedure Call - cis_18.9.36.x.yml

- "18.9.36.1 | PATCH | Ensure Enable RPC Endpoint Mapper Client Authentication is set to Enabled."
- "18.9.36.2 | PATCH | Ensure Restrict Unauthenticated RPC clients is set to Enabled Authenticated."

#### Section 18.9.47 Troubleshooting and Diagnostics - cis_18.9.47.x.yml

- "18.9.47.5.1 | PATCH | Ensure Microsoft Support Diagnostic Tool Turn on MSDT interactive communication with support provider is set to Disabled"
- "18.9.47.11.1 | PATCH | Ensure EnableDisable PerfTrack is set to Disabled"

#### Section 18.9.49 User Profiles - cis_18.9.49.x.yml

- "18.9.49.1 | PATCH | Ensure Turn off the advertising ID is set to Enabled"

#### Section 18.9.51 Windows Time Service - cis_18.9.51.x.yml

- "18.9.51.1.1 | PATCH | Ensure Enable Windows NTP Client is set to Enabled"
- "18.9.51.1.2 | PATCH | Ensure Enable Windows NTP Server is set to Disabled."

### Section 18.10

#### Section 18.10.3 App Package Deployment - cis_18.10.3.x.yml

- "18.10.3.1 | PATCH | Ensure Allow a Windows app to share application data between users is set to Disabled"
- "18.10.3.2 | PATCH | Ensure 'Prevent non-admin users from installing packaged Windows apps' is set to 'Enabled'"

#### Section 18.10.4 App Privacy - cis_18.10.4.x.yml

- "18.10.4.1 | PATCH | Ensure 'Let Windows apps activate with voice while the system is locked' is set to 'Enabled: Force Deny'"

#### Section 18.10.5 App Runtime - cis_18.10.5.x.yml

- "18.10.5.1 | PATCH | Ensure Allow Microsoft accounts to be optional is set to Enabled"
- "18.10.5.2 | PATCH | Ensure 'Block launching Universal Windows apps with Windows Runtime API access from hosted content.' is set to 'Enabled'"

#### Section 18.10.7 Autoplay Policies cis_18.10.7.x.yml

- "18.10.7.1 | PATCH | Ensure Disallow Autoplay for non-volume devices is set to Enabled"
- "18.10.7.2 | PATCH | Ensure Set the default behavior for AutoRun is set to Enabled Do not execute any autorun commands"
- "18.10.7.3 | PATCH | Ensure Turn off Autoplay is set to Enabled All drives"

#### Section 18.10.8 Biometrics - cis_18.10.8.x.yml

- "18.10.8.1.1 | PATCH | Ensure Configure enhanced anti-spoofing is set to Enabled"

#### Section 18.10.9 Bitlocker Drive Encryption - cis_18.10.9.x.yml

- "18.10.9.1.1 | PATCH | Ensure 'Allow access to BitLocker-protected fixed data drives from earlier versions of Windows' is set to 'Disabled'"
- "18.10.9.1.2 | PATCH | Ensure 'Choose how BitLocker-protected fixed drives can be recovered' is set to 'Enabled'"
- "18.10.9.1.3 | PATCH | Ensure 'Choose how BitLocker-protected fixed drives can be recovered: Allow data recovery agent' is set to 'Enabled: True'"
- "18.10.9.1.4 | PATCH | Ensure 'Choose how BitLocker-protected fixed drives can be recovered: Recovery Password' is set to 'Enabled: Allow 48-digit recovery password' or higher"
- "18.10.9.1.5 | PATCH | Ensure 'Choose how BitLocker-protected fixed drives can be recovered: Recovery Key' is set to 'Enabled: Allow 256-bit recovery key' or higher'"
- "18.10.9.1.6 | PATCH | Ensure 'Choose how BitLocker-protected fixed drives can be recovered: Omit recovery options from the BitLocker setup wizard' is set to 'Enabled: True''"
- "18.10.9.1.7 | PATCH | Ensure 'Choose how BitLocker-protected fixed drives can be recovered: Save BitLocker recovery information to AD DS for fixed data drives' is set to 'Enabled: False'"
- "18.10.9.1.8 | PATCH | Ensure 'Choose how BitLocker-protected fixed drives can be recovered: Configure storage of BitLocker recovery information to AD DS' is set to 'Enabled: Backup recovery passwords and key packages'"
- "18.10.9.1.9 | PATCH | Ensure 'Choose how BitLocker-protected fixed drives can be recovered: Do not enable BitLocker until recovery information is stored to AD DS for fixed data drives' is set to 'Enabled: False'"
- "18.10.9.1.10 | PATCH | Ensure 'Configure use of hardware-based encryption for fixed data drives' is set to 'Disabled'"
- "18.10.9.1.11 | PATCH | Ensure 'Configure use of passwords for fixed data drives' is set to 'Disabled'"
- "18.10.9.1.12 | PATCH | Ensure 'Configure use of smart cards on fixed data drives' is set to 'Enabled'"
- "18.10.9.1.13 | PATCH | Ensure 'Configure use of smart cards on fixed data drives: Require use of smart cards on fixed data drives' is set to 'Enabled: True'"
- "18.10.9.2.1 | PATCH | Ensure 'Allow enhanced PINs for startup' is set to 'Enabled'"
- "18.10.9.2.2 | PATCH | Ensure 'Allow Secure Boot for integrity validation' is set to 'Enabled'"
- "18.10.9.2.3 | PATCH | Ensure 'Choose how BitLocker-protected operating system drives can be recovered' is set to 'Enabled'"
- "18.10.9.2.4 | PATCH | Ensure 'Choose how BitLocker-protected operating system drives can be recovered: Allow data recovery agent' is set to 'Enabled: False'"
- "18.10.9.2.5 | PATCH | Ensure 'Choose how BitLocker-protected operating system drives can be recovered: Recovery Password' is set to 'Enabled: Require 48-digit recovery password'"
- "18.10.9.2.6 | PATCH | Ensure 'Choose how BitLocker-protected operating system drives can be recovered: Recovery Key' is set to 'Enabled: Do not allow 256-bit recovery key'"
- "18.10.9.2.7 | PATCH | Ensure 'Choose how BitLocker-protected operating system drives can be recovered: Omit recovery options from the BitLocker setup wizard' is set to 'Enabled: True'"
- "18.10.9.2.8 | PATCH | Ensure 'Choose how BitLocker-protected operating system drives can be recovered: Save BitLocker recovery information to AD DS for operating system drives' is set to 'Enabled: True'"
- "18.10.9.2.9 | PATCH | Ensure 'Choose how BitLocker-protected operating system drives can be recovered: Configure storage of BitLocker recovery information to AD DS:' is set to 'Enabled: Store recovery passwords and key packages'"
- "18.10.9.2.10 | PATCH | Ensure 'Choose how BitLocker-protected operating system drives can be recovered: Do not enable BitLocker until recovery information is stored to AD DS for operating system drives' is set to 'Enabled: True'"
- "18.10.9.2.11 | PATCH | Ensure 'Configure use of hardware-based encryption for operating system drives' is set to 'Disabled'"
- "18.10.9.2.12 | PATCH | Ensure 'Configure use of passwords for operating system drives' is set to 'Disabled'"
- "18.10.9.2.13 | PATCH | Ensure 'Require additional authentication at startup' is set to 'Enabled'"
- "18.10.9.2.14 | PATCH | Ensure 'Require additional authentication at startup: Allow BitLocker without a compatible TPM' is set to 'Enabled: False'"
- "18.10.9.2.15 | PATCH | Ensure 'Require additional authentication at startup: Configure TPM startup:' is set to 'Enabled: Do not allow TPM'"
- "18.10.9.2.16 | PATCH | Ensure 'Require additional authentication at startup: Configure TPM startup PIN:' is set to 'Enabled: Require startup PIN with TPM'"
- "18.10.9.2.17 | PATCH | Ensure 'Require additional authentication at startup: Configure TPM startup key:' is set to 'Enabled: Do not allow startup key with TPM'"
- "18.10.9.2.18 | PATCH | Ensure 'Require additional authentication at startup: Configure TPM startup key and PIN:' is set to 'Enabled: Do not allow startup key and PIN with TPM'"
- "18.10.9.3.1 | PATCH | Ensure 'Allow access to BitLocker-protected removable data drives from earlier versions of Windows' is set to 'Disabled'"
- "18.10.9.3.2 | PATCH | Ensure 'Choose how BitLocker-protected removable drives can be recovered' is set to 'Enabled'"
- "18.10.9.3.3 | PATCH | Ensure 'Choose how BitLocker-protected removable drives can be recovered: Allow data recovery agent' is set to 'Enabled: True'"
- "18.10.9.3.4 | PATCH | Ensure 'Choose how BitLocker-protected removable drives can be recovered: Recovery Password' is set to 'Enabled: Do not allow 48-digit recovery password'"
- "18.10.9.3.5 | PATCH | Ensure 'Choose how BitLocker-protected removable drives can be recovered: Recovery Key' is set to 'Enabled: Do not allow 256-bit recovery key'"
- "18.10.9.3.6 | PATCH | Ensure 'Choose how BitLocker-protected removable drives can be recovered: Omit recovery options from the BitLocker setup wizard' is set to 'Enabled: True'"
- "18.10.9.3.7 | PATCH | Ensure 'Choose how BitLocker-protected removable drives can be recovered: Save BitLocker recovery information to AD DS for removable data drives' is set to 'Enabled: False'"
- "18.10.9.3.8 | PATCH | Ensure 'Choose how BitLocker-protected removable drives can be recovered: Configure storage of BitLocker recovery information to AD DS:' is set to 'Enabled: Backup recovery passwords and key packages'"
- "18.10.9.3.9 | PATCH | Ensure 'Choose how BitLocker-protected removable drives can be recovered: Do not enable BitLocker until recovery information is stored to AD DS for removable data drives' is set to 'Enabled: False'"
- "18.10.9.3.10 | PATCH | Ensure 'Configure use of hardware-based encryption for removable data drives' is set to 'Disabled'"
- "18.10.9.3.11 | PATCH | Ensure 'Configure use of passwords for removable data drives' is set to 'Disabled'"
- "18.10.9.3.12 | PATCH | Ensure 'Configure use of smart cards on removable data drives' is set to 'Enabled'"
- "18.10.9.3.13 | PATCH | Ensure 'Configure use of smart cards on removable data drives: Require use of smart cards on removable data drives' is set to 'Enabled: True' "
- "18.10.9.3.14 | PATCH | Ensure 'Deny write access to removable drives not protected by BitLocker' is set to 'Enabled'"
- "18.10.9.3.15 | PATCH | Ensure 'Deny write access to removable drives not protected by BitLocker: Do not allow write access to devices configured in another organization' is set to 'Enabled: False'"
- "18.10.9.4 | PATCH | Ensure 'Disable new DMA devices when this computer is locked' is set to 'Enabled'"

#### Section 18.10.10 Camera - cis_18.10.10.x.yml

- "18.10.10.1 | PATCH | Ensure 'Allow Use of Camera' is set to 'Disabled'"

#### Section 18.10.12 Cloud Content - cis_18.10.12.x.yml

- "18.10.12.1 | PATCH | Ensure Turn off cloud consumer account state content is set to Enabled"
- "18.10.12.2 | PATCH | Ensure 'Turn off cloud optimized content' is set to 'Enabled'"
- "18.10.12.3 | PATCH | Ensure 'Turn off Microsoft consumer experiences' is set to 'Enabled'"

#### Section 18.10.13 Connect - cis_18.10.13.x.yml

- "18.10.13.1 | PATCH | Ensure Require pin for pairing is set to Enabled First Time OR Enabled Always"

#### Section 18.10.14 Credential User Interface - cis_18.10.14.x.yml

- "18.10.14.1 | PATCH | Ensure Do not display the password reveal button is set to Enabled"
- "18.10.14.2 | PATCH | Ensure Enumerate administrator accounts on elevation is set to Disabled"
- "18.10.14.3 | PATCH | Ensure 'Prevent the use of security questions for local accounts' is set to 'Enabled'"

#### Section 18.10.15 Data Collection and Preview Builds - cis_18.10.15.x.yml

- "18.10.15.1 | PATCH | Ensure Allow Diagnostic Data is set to Enabled: Diagnostic data off (not recommended) or Enabled: Send required diagnostic data"
- "18.10.15.2 | PATCH | Ensure Configure Authenticated Proxy usage for the Connected User Experience and Telemetry service is set to Enabled Disable Authenticated Proxy usage"
- "18.10.15.3 | PATCH | Ensure Disable OneSettings Downloads is set to Enabled"
- "18.10.15.4 | PATCH | Ensure Do not show feedback notifications is set to Enabled"
- "18.10.15.5 | PATCH | Ensure Enable OneSettings Auditing' is set to Enabled"
- "18.10.15.6 | PATCH | Ensure Limit Diagnostic Log Collection is set to Enabled"
- "18.10.15.7 | PATCH | Ensure Limit Dump Collection is set to Enabled"
- "18.10.15.8 | PATCH | Ensure Toggle user control over Insider builds is set to Disabled"

#### Section 18.10.16 Delivery Optimization - cis_18.10.16.x.yml

- "18.10.16.1 | PATCH | Ensure 'Download Mode' is NOT set to 'Enabled: Internet'"

#### Section 18.10.17 Desktop app installer - cis_18.10.17.x.yml

- "18.10.17.1 | PATCH | Ensure 'Enable App Installer' is set to 'Disabled'"
- "18.10.17.2 | PATCH | Ensure 'Enable App Installer Experimental Features' is set to 'Disabled'"
- "18.10.17.3 | PATCH | Ensure 'Enable App Installer Hash Override' is set to 'Disabled'"
- "18.10.17.4 | PATCH | Ensure 'Enable App Installer ms-appinstaller protocol' is set to 'Disabled'"

#### Section 18.10.25 Event Log Service - cis_18.10.25.x.yml

- "18.10.25.1.1 | PATCH | Ensure Application Control Event Log behavior when the log file reaches its maximum size is set to Disabled"
- "18.10.25.1.2 | PATCH | Ensure Application Specify the maximum log file size KB is set to Enabled 32768 or greater"
- "18.10.25.2.1 | PATCH | Ensure Security Control Event Log behavior when the log file reaches its maximum size is set to Disabled"
- "18.10.25.2.2 | PATCH | Ensure Security Specify the maximum log file size KB is set to Enabled 196608 or greater"
- "18.10.25.3.1 | PATCH | Ensure Setup Control Event Log behavior when the log file reaches its maximum size is set to Disabled"
- "18.10.25.3.2 | PATCH | Ensure Setup Specify the maximum log file size KB is set to Enabled 32768 or greater"
- "18.10.25.4.1 | PATCH | Ensure System Control Event Log behavior when the log file reaches its maximum size is set to Disabled"
- "18.10.25.4.2 | PATCH | Ensure System Specify the maximum log file size KB is set to Enabled 32768 or greater"

#### Section 18.10.28 File Explorer - cis_18.10.28.x.yml

- "18.10.28.2 | PATCH | Ensure 'Turn off account-based insights, recent, favorite, and recommended files in File Explorer' is set to 'Enabled'"
- "18.10.28.3 | PATCH | Ensure Turn off Data Execution Prevention for Explorer is set to Disabled"
- "18.10.28.4 | PATCH | Ensure Turn off heap termination on corruption is set to Disabled"
- "18.10.28.5 | PATCH | Ensure Turn off shell protocol protected mode is set to Disabled"

#### Section 18.10.36 Location and Sensors - cis_18.10.36.x.yml

- "18.10.36.1 | PATCH | Ensure Turn off location is set to Enabled"

#### Section 18.10.40 Messaging - cis_18.10.40.x.yml

- "18.10.40.1 | PATCH | Ensure Allow Message Service Cloud Sync is set to Disabled"

#### Section 18.10.41 Microsoft Accouint - cis_18.10.41.x.yml

- "18.10.41.1 | PATCH | Ensure Block all consumer Microsoft account user authentication is set to Enabled"

#### Section 18.10.42 Microsoft Defender Antivirus - cis_18.10.42.x.yml

- "18.10.42.5.1 | PATCH | Ensure Configure local setting override for reporting to Microsoft MAPS is set to Disabled"
- "18.10.42.5.2 | PATCH | Ensure Join Microsoft MAPS is set to Disabled"
- "18.10.42.6.1.1  | PATCH | Ensure Configure Attack Surface Reduction rules is set to Enabled"
- "18.10.42.6.1.2 | PATCH | Ensure Configure Attack Surface Reduction rules Set the state for each ASR rule is configured"
- "18.10.42.6.3.1 | PATCH | Ensure Prevent users and apps from accessing dangerous websites is set to Enabled Block"
- "18.10.42.7.1 | PATCH | (L2) Ensure 'Enable file hash computation feature' is set to 'Enabled'"
- "18.10.42.10.1 | PATCH | Ensure Scan all downloaded files and attachments is set to Enabled"
- "18.10.42.10.2 | PATCH | Ensure 'Turn off real-time protection' is set to 'Disabled'"
- "18.10.42.10.3 | PATCH | Ensure Turn on behavior monitoring is set to Enabled"
- "18.10.42.10.4 | PATCH | Ensure 'Turn on script scanning' is set to 'Enabled'"
- "18.10.42.12.1 | PATCH | Ensure Configure Watson events is set to Disabled"
- "18.10.42.13.1 | PATCH | Ensure 'Scan packed executables' is set to 'Enabled'"
- "18.10.42.13.2 | PATCH | Ensure Scan removable drives is set to Enabled"
- "18.10.42.13.3 | PATCH | Ensure Turn on e-mail scanning is set to Enabled"
- "18.10.42.16 | PATCH | Ensure Configure detection for potentially unwanted applications is set to Enabled Block"
- "18.10.42.17 | PATCH | Ensure Turn off Windows Defender AntiVirus is set to Disabled"

#### Section 18.10.43 Microsoft Defender Application Guard - cis_18.10.43.x.yml

- "18.10.43.1 | PATCH | Ensure 'Allow auditing events in Microsoft Defender Application Guard' is set to 'Enabled'"
- "18.10.43.2 | PATCH | Ensure 'Allow camera and microphone access in Microsoft Defender Application Guard' is set to 'Disabled'"
- "18.10.43.3 | PATCH | Ensure 'Allow data persistence for Microsoft Defender Application Guard' is set to 'Disabled'"
- "18.10.43.4 | PATCH | Ensure 'Allow files to download and save to the host operating system from Microsoft Defender Application Guard' is set to 'Disabled'"
- "18.10.43.5 | PATCH | Ensure 'Configure Microsoft Defender Application Guard clipboard settings: Clipboard behavior setting' is set to 'Enabled: Enable clipboard operation from an isolated session to the host'"
- "18.10.43.6 | PATCH | Ensure 'Turn on Microsoft Defender Application Guard in Managed Mode' is set to 'Enabled: 1'"

#### Section 18.10.49 News and Interests - cis_18.10.49.x.yml

- "18.10.49.1 | PATCH | Ensure 'Enable news and interests on the taskbar' is set to 'Disabled'"

#### Section 18.10.50 OneDrive - cis_18.10.50.x.yml

- "18.10.50.1 | PATCH | Ensure Prevent the usage of OneDrive for file storage is set to Enabled"

#### Section 18.10.55 Push To Install - cis_18.10.55.x.yml

- "18.10.55.1 | PATCH | (L2) Ensure 'Turn off Push To Install service' is set to 'Enabled'"

#### Section 18.10.56 Remote Desktop Services cis_18.10.56.x.yml

- "18.10.56.2.2 | PATCH | Ensure 'Disable Cloud Clipboard integration for server-to-client data transfer' is set to 'Enabled'"
- "18.10.56.2.3 | PATCH | Ensure Do not allow passwords to be saved is set to Enabled"
- "18.10.56.3.2.1 | PATCH | Ensure 'Allow users to connect remotely by using Remote Desktop Services' is set to 'Disabled'"
- "18.10.56.3.3.1 | PATCH | Ensure 'Allow UI Automation redirection' is set to 'Disabled'"
- "18.10.56.3.3.2 | PATCH | Ensure Do not allow COM port redirection is set to Enabled"
- "18.10.56.3.3.3 | PATCH | Ensure Do not allow drive redirection is set to Enabled"
- "18.10.56.3.3.4 | PATCH | Ensure 'Do not allow location redirection' is set to 'Enabled'"
- "18.10.56.3.3.5 | PATCH | Ensure 'Do not allow LPT port redirection' is set to 'Enabled'"
- "18.10.56.3.3.6 | PATCH | Ensure 'Do not allow supported Plug and Play device redirection' is set to 'Enabled'"
- "18.10.56.3.3.7 | PATCH | Ensure 'Do not allow WebAuthn redirection' is set to 'Enabled'"
- "18.10.56.3.9.1 | PATCH | Ensure Always prompt for password upon connection is set to Enabled"
- "18.10.56.3.9.2 | PATCH | Ensure Require secure RPC communication is set to Enabled"
- "18.10.56.3.9.3 | PATCH | Ensure Require use of specific security layer for remote RDP connections is set to Enabled SSL"
- "18.10.56.3.9.4 | PATCH | Ensure Require user authentication for remote connections by using Network Level Authentication is set to Enabled"
- "18.10.56.3.9.5 | PATCH | Ensure Set client connection encryption level is set to Enabled High Level"
- "18.10.56.3.10.1 | PATCH | Ensure Set time limit for active but idle Remote Desktop Services sessions is set to Enabled 15 minutes or less, but not Never (0)"
- "18.10.56.3.10.2 | PATCH | Ensure Set time limit for disconnected sessions is set to Enabled 1 minute"
- "18.10.56.3.11.1 | PATCH | Ensure Do not delete temp folders upon exit is set to Disabled"

#### Section 18.10.57 RSS Feeds - cis_18.10.57.x.yml

- "18.10.57.1 | PATCH | Ensure Prevent downloading of enclosures is set to Enabled"

#### Section 18.10.58 Search - cis_18.10.58.x.yml

- "18.10.58.2 | PATCH | Ensure Allow Cloud Search is set to Enabled Disable Cloud Search"
- "18.10.58.3 | PATCH | Ensure 'Allow Cortana' is set to 'Disabled'"
- "18.10.58.4 | PATCH | Ensure 'Allow Cortana above lock screen' is set to 'Disabled'"
- "18.10.58.5 | PATCH | Ensure Allow indexing of encrypted files is set to Disabled"
- "18.10.58.6 | PATCH | Ensure 'Allow search and Cortana to use location' is set to 'Disabled'"
- "18.10.58.7 | PATCH | Ensure 'Allow search highlights' is set to 'Disabled'"

#### Section 18.10.62 Software Protection Platform - cis_18.10.62.x.yml

- "18.10.62.1 | PATCH | Ensure Turn off KMS Client Online AVS Validation is set to Enabled"

#### Section 18.10.65 Store - cis_18.10.65.x.yml

- "18.10.65.1 | PATCH | Ensure 'Disable all apps from Microsoft Store' is set to 'Disabled'"
- "18.10.65.2 | PATCH | Ensure 'Only display the private store within the Microsoft Store' is set to 'Enabled'"
- "18.10.65.3 | PATCH | Ensure 'Turn off Automatic Download and Install of updates' is set to 'Disabled'"
- "18.10.65.4 | PATCH | Ensure 'Turn off the offer to update to the latest version of Windows' is set to 'Enabled'"
- "18.10.65.5 | PATCH | Ensure 'Turn off the Store application' is set to 'Enabled'"

#### Section 18.10.71 Widgets - cis_18.10.71.x.yml

- "18.10.71.1 | PATCH | Ensure 'Allow widgets' is set to 'Disabled'"

#### Section 18.10.75 Windows Defender SmartScreen - cis_18.10.75.x.yml

- "18.10.75.1.1 | PATCH | Ensure 'Automatic Data Collection' is set to 'Enabled'"
- "18.10.75.1.2 | PATCH | Ensure 'Notify Malicious' is set to 'Enabled'"
- "18.10.75.1.3 | PATCH | Ensure 'Notify Password Reuse' is set to 'Enabled'"
- "18.10.75.1.4 | PATCH | Ensure 'Notify Unsafe App' is set to 'Enabled'"
- "18.10.75.1.5 | PATCH | Ensure 'Service Enabled' is set to 'Enabled'"
- "18.10.75.2.1 | PATCH | Ensure 'Configure Windows Defender SmartScreen' is set to 'Enabled: Warn and prevent bypass'"

#### Section 18.10.77 Windows Game Recording and Broadcasting - cis_18.10.77.x.yml

- "18.10.77.1 | PATCH | Ensure 'Enables or disables Windows Game Recording and Broadcasting' is set to 'Disabled'"

#### Section 18.10.78 Windwos Hello for Business - cis_18.10.78.x.yml

- "18.10.78.1 | PATCH | Ensure 'Enable ESS with Supported Peripherals' is set to 'Enabled: 1'"

#### Section 18.10.79 Windows Ink Workspace - cis_18.10.79.x.yml

- "18.10.79.1 | PATCH | Ensure 'Allow suggested apps in Windows Ink Workspace' is set to 'Disabled'"
- "18.10.79.2 | PATCH | Ensure 'Allow Windows Ink Workspace' is set to 'Enabled: On, but disallow access above lock' OR 'Enabled: Disabled'"

#### Section 18.10.80 Windows Installer - cis_18.10.80.x.yml

- "18.10.80.1 | PATCH | Ensure 'Allow user control over installs' is set to 'Disabled'"
- "18.10.80.2 | PATCH | Ensure Always install with elevated privileges is set to Disabled"
- "18.10.80.3 | PATCH | Ensure Prevent Internet Explorer security prompt for Windows Installer scripts is set to Disabled"

#### Section 18.10.81 Windows Logon Options - cis_18.10.81.x.yml

- "18.10.81.1 | PATCH | Ensure 'Enable MPR notifications for the system' is set to 'Disabled'"
- "18.10.81.2 | PATCH | Ensure 'Sign-in and lock last interactive user automatically after a restart' is set to 'Disabled'"

#### Section 18.10.86 Windows PowerShell - cis_18.10.86.x.yml

- "18.10.86.1 | PATCH | Ensure 'Turn on PowerShell Script Block Logging' is set to 'Enabled'"
- "18.10.86.2 | PATCH | Ensure 'Turn on PowerShell Transcription' is set to 'Enabled'"

#### Section 18.10.88 Windows Remote Management (WinRM) - cis_18.10.88.x.yml

- "18.10.88.1.1 | PATCH | Ensure Allow Basic authentication is set to Disabled"
- "18.10.88.1.2 | PATCH | Ensure Allow unencrypted traffic is set to Disabled"
- "18.10.88.1.3 | PATCH | Ensure Disallow Digest authentication is set to Enabled"
- "18.10.88.2.1 | PATCH | Ensure Allow Basic authentication is set to Disabled"
- "18.10.88.2.2 | PATCH | Ensure Allow remote server management through WinRM is set to Disabled"
- "18.10.88.2.3 | PATCH | Ensure Allow unencrypted traffic is set to Disabled"
- "18.10.88.2.4 | PATCH | Ensure Disallow WinRM from storing RunAs credentials is set to Enabled"

#### Section 18.10.89 Windows Remote Shell - cis_18.10.89.x.yml

- "18.10.89.1 | PATCH | Ensure Allow Remote Shell Access is set to Disabled"

#### Section 18.10.90 Windows Sandbox - cis_18.10.90.x.yml

- "18.10.90.1 | PATCH | Ensure 'Allow clipboard sharing with Windows Sandbox' is set to 'Disabled'"
- "18.10.90.2 | PATCH | Ensure 'Allow networking in Windows Sandbox' is set to 'Disabled'"

#### Section 18.10.91 Windows Security - cis_18.10.91.x.yml

- "18.10.91.2.1 | PATCH | Ensure Prevent users from modifying settings is set to Enabled"

#### Section 18.10.92 Windows Update cis_18.10.92.x.yml

- "18.10.92.1.1 | PATCH | Ensure No auto-restart with logged on users for scheduled automatic updates installations is set to Disabled"
- "18.10.92.2.1 | PATCH | Ensure Configure Automatic Updates is set to Enabled"
- "18.10.92.2.2 | PATCH | Ensure 'Configure Automatic Updates: Scheduled install day' is set to '0 - Every day' "
- "18.10.92.2.3 | PATCH | Ensure 'Enable features introduced via servicing that are off by default' is set to 'Disabled'"
- "18.10.92.2.4 | PATCH | Ensure 'Remove access to “Pause updates” feature' is set to 'Enabled'"
- "18.10.92.4.1 | PATCH | Ensure 'Manage preview builds' is set to 'Disabled'"
- "18.10.92.4.2 | PATCH | Ensure 'Select when Preview Builds and Feature Updates are received' is set to 'Enabled: 180 or more days'"
- "18.10.92.4.3 | PATCH | Ensure Select when Quality Updates are received is set to Enabled 0 days"

### Section 18 main.yml

- "SECTION | 18.1 | Control Panel"
- "SECTION | 18.1.1 | Personalization"
- "SECTION | 18.1.2 | Regional And Language Options"
- "SECTION | 18.1.3 | Online Tips"
- "SECTION | 18.4 | MS Security Guide"
- "SECTION | 18.5 | MSS (Legacy)"
- "SECTION | 18.6 | Network"
- "SECTION | 18.6.4 | DNS Client"
- "SECTION | 18.6.5 | Fonts"
- "SECTION | 18.6.8 | Lanman Workstation"
- "SECTION | 18.6.9 | Link-Layer Topology Discovery"
- "SECTION | 18.6.10 | Microsoft Peer-to-Peer Networking Services"
- "SECTION | 18.6.11 | Network Connections"
- "SECTION | 18.6.14 | Network Provider"
- "SECTION | 18.6.19.2 | TCP/IP Settings"
- "SECTION | 18.6.20 | Windows Connect Now"
- "SECTION | 18.6.21 | Windows Connection Manager"
- "SECTION | 18.6.23.2 | WLAN Service"
- "SECTION | 18.7 | Printers"
- "SECTION | 18.8 | Start Menu & Task Bar"
- "SECTION | 18.9 | System"
- "SECTION | 18.9.3 | Audit Process Creation"
- "SECTION | 18.9.4 | Credentials Delegation"
- "SECTION | 18.9.5 | Device Guard"
- "SECTION | 18.9.7 | Device Installation"
- "SECTION | 18.9.13 | Early Launch Antimalware"
- "SECTION | 18.9.19 | Group Policy"
- "SECTION | 18.9.20 | Internet Conection Management"
- "SECTION | 18.9.23 | Kerberos"
- "SECTION | 18.9.24 | Kernel DMA Protection"
- "SECTION | 18.9.25 | LAPS"
- "SECTION | 18.9.26 | Local Security Authority"
- "SECTION | 18.9.27 | Locale Services"
- "SECTION | 18.9.28 | Logon"
- "SECTION | 18.9.31 | OS Policies"
- "SECTION | 18.9.33 | Power Management"
- "SECTION | 18.9.35 | Remote Assistance"
- "SECTION | 18.9.36 | Remote Procedure Call"
- "SECTION | 18.9.47 | Troubleshooting And Diagnostics"
- "SECTION | 18.9.49 | User Profiles"
- "SECTION | 18.9.51 | Windows Time Service"
- "SECTION | 18.8.1 | Notifications"
- "SECTION | 18.10 | Windows Components"
- "SECTION | 18.10.3 | App Package Deployment"
- "SECTION | 18.10.4 | App Privacy"
- "SECTION | 18.10.5 | App Runtime"
- "SECTION | 18.10.7 | Autoplay Policies"
- "SECTION | 18.10.8 | Biometrics"
- "SECTION | 18.10.9 | Bitlocker Drive Encryption"
- "SECTION | 18.10.10 | Camera"
- "SECTION | 18.10.12 | Cloud Content"
- "SECTION | 18.10.13 | Connect"
- "SECTION | 18.10.14 | Credential User Interface"
- "SECTION | 18.10.15 | Data Collection And Preview Builds"
- "SECTION | 18.10.16 | Delivery Optimization"
- "SECTION | 18.10.17 | Desktop App Installer"
- "SECTION | 18.10.25 | Event Log Service"
- "SECTION | 18.10.28 | File Explorer (Formerly Windows Explorer)"
- "SECTION | 18.10.36 | Location And Sensors"
- "SECTION | 18.10.40 | Messaging"
- "SECTION | 18.10.41 | Microsoft Account"
- "SECTION | 18.10.42 | Microsoft Defender Antivirus (formerly Windows Defender and Windows Defender Antivirus)"
- "SECTION | 18.10.43 | Microsoft Defender Application Guard (formerly Windows Defender Application Guard)"
- "SECTION | 18.10.49 | News And Interests"
- "SECTION | 18.10.50 | OneDrive (Formerly SkyDrive)"
- "SECTION | 18.10.55 | Push To Install"
- "SECTION | 18.10.56 | Remote Desktop Services (formerly Terminal Services)"
- "SECTION | 18.10.57 | RSS Feeds"
- "SECTION | 18.10.58 | Search"
- "SECTION | 18.10.62 | Software Protection Platform"
- "SECTION | 18.10.65 | Store"
- "SECTION | 18.10.71 | Widgets"
- "SECTION | 18.10.75 | Windows Defender SmartScreen"
- "SECTION | 18.10.77 | Windows Game Recording and Broadcasting"
- "SECTION | 18.10.78 | Windows Hello for Business (formerly Microsoft Passport for Work)"
- "SECTION | 18.10.79 | Windows Ink Workspace"
- "SECTION | 18.10.80 | Windows Installer"
- "SECTION | 18.10.81 | Windows Logon Options"
- "SECTION | 18.10.86 | Windows Powershell"
- "SECTION | 18.10.88 | Windows Remote Management (WinRM)"
- "SECTION | 18.10.89 | Windows Remote Shell"
- "SECTION | 18.10.90 | Windows Sandbox"
- "SECTION | 18.10.91 | Windows Security (formerly Windows Defender Security Center)"
- "SECTION | 18.10.92 | Windows Update"

## Section 19 - Administrative Templates (User)

### Section 19.5

#### Section 19.5.1 Notifications - cis_19.5.1.x.yml

- "19.5.1.1 | PATCH | Ensure Turn off toast notifications on the lock screen is set to Enabled"

### Section 19.6

#### Section 19.6.6 Internet Communication Management - cis_19.6.6.x.yml

- "19.6.6.1.1 | PATCH | Ensure Turn off Help Experience Improvement Program is set to Enabled"

### Section 19.7

#### Section 19.7.5 Attachment Manager - cis_19.7.5.x.yml

- "19.7.5.1 | PATCH | Ensure Do not preserve zone information in file attachments is set to Disabled"
- "19.7.5.2 | PATCH | Ensure Notify antivirus programs when opening attachments is set to Enabled"

#### Section 19.7.8 Cloud Content - cis_19.7.8.x.yml

- "19.7.8.1 | PATCH | Ensure Configure Windows spotlight on lock screen is set to Disabled"
- "19.7.8.2 | PATCH | Ensure Do not suggest third-party content in Windows spotlight is set to Enabled"
- "19.7.8.3 | PATCH | Ensure Do not use diagnostic data for tailored experiences is set to Enabled"
- "19.7.8.4 | PATCH | Ensure Turn off all Windows spotlight features is set to Enabled"
- "19.7.8.5 | PATCH | Ensure Turn off Spotlight collection on Desktop is set to Enabled"

#### Section 19.7.26 Network Sharing - cis_19.7.26.x.yml

- "19.7.26.1 | PATCH | Ensure Prevent users from sharing files within their profile. is set to Enabled"

#### Section 19.7.38 Windows Copilot - cis_19.7.38.x.yml

- "19.7.38.1 | PATCH | Ensure 'Turn off Windows Copilot' is set to 'Enabled'"

#### Section 19.7.42 Windows Installer - cis_19.7.42.x.yml

- "19.7.42.1 | PATCH | Ensure Always install with elevated privileges is set to Disabled"

#### Section 19.7.44 Windows Media Player - cis_19.7.44.2.x.yml

- "19.7.44.2.1 | PATCH | Ensure Prevent Codec Download is set to Enabled"

### Section 19 main.yml

- "SECTION | 19.5.1 | Notifications"
- "SECTION | 19.6.6 | Internet Communication Management"
- "SECTION | 19.7.5 | Attachment Manager"
- "SECTION | 19.7.8 | Cloud Content"
- "SECTION | 19.7.26 | Network Sharing"
- "SECTION | 19.7.38 | Windows Copilot"
- "SECTION | 19.7.42 | Windows Installer"
- "SECTION | 19.7.44 | Windows Media Player"
