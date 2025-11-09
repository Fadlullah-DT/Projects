
Scope notes

- This repository is a CIS Windows 11 hardening role. The playbooks under tasks/ enforce Group Policy/registry settings, services, and policies mapped to CIS controls. Exact changes applied depend on variables in defaults/main.yml and vars/main.yml, and which section task files are included by tasks/main.yml and site.yml.

High-level outcome on the target Windows 11 device

- System will be configured to CIS Benchmarks for Windows 11, including:
  - Account policies, audit policies, and security options
  - Services configuration and feature restrictions
  - Defender, Firewall, SmartScreen, BitLocker and Device Guard controls (as applicable)
  - Microsoft Edge/Internet Explorer legacy and privacy settings
  - Telemetry and data collection reductions
  - Remote Desktop, SMB, and legacy protocol hardening
  - PowerShell, Script, and Macro execution restrictions
  - User experience/privacy settings per CIS

Task list by CIS section implemented in this repo
Note: This list is derived from the task files present. Each bullet corresponds to a task file that typically contains multiple Ansible tasks to enforce several sub-controls in that section.

- Section 1: Account Policies and Local Policies
  - tasks/section_1/cis_1.1.x.yml: Enforce account lockout and password policies (min length, history, max/min age, complexity, lockout threshold/duration, lockout reset).
  - tasks/section_1/cis_1.2.x.yml: Local policy/security options baseline (guest account, rename admin/guest, shutdown without logon, Ctrl+Alt+Del, etc.).
  - tasks/section_1/cis_1.2_cloud_lockout_order.yml: Cloud/Azure AD lockout order alignment (if joined).

- Section 2: Local Policies – Security Options
  - tasks/section_2/cis_2.2.x.yml: Services configuration baseline (start/stop/disable specific Windows services per CIS 2.2).
  - tasks/section_2/cis_2.3.1.x.yml: Accounts policies (e.g., Administrator account status/rename, Guest account status/rename).
  - tasks/section_2/cis_2.3.2.x.yml: Audit policies and settings.
  - tasks/section_2/cis_2.3.4.x.yml: Devices options (e.g., prevent installation of removable storage, unsigned drivers).
  - tasks/section_2/cis_2.3.6.x.yml: Interactive logon options (banner text/title, last username display, Ctrl+Alt+Del requirement, smart card behavior).
  - tasks/section_2/cis_2.3.7.x.yml: Microsoft network client/server settings (SMB signing, LAN Manager auth levels).
  - tasks/section_2/cis_2.3.8.x.yml: Network access restrictions (anonymous access, shares, named pipes).
  - tasks/section_2/cis_2.3.9.x.yml: Network security options (NTLM restrictions, LDAP signing, Kerberos settings).
  - tasks/section_2/cis_2.3.10.x.yml: Recovery console/Shutdown and security-related options.
  - tasks/section_2/cis_2.3.11.x.yml: System objects settings (permissions default, driver load behavior).
  - tasks/section_2/cis_2.3.14.x.yml: User Account Control (UAC) policies.
  - tasks/section_2/cis_2.3.15.x.yml: Windows Components policies (various).
  - tasks/section_2/cis_2.3.17.x.yml: System cryptography/Smart card policies.

- Section 5: System Services
  - tasks/section_5/cis_5.x.yml: Enable/disable and set startup types for Windows services per CIS (e.g., disable Xbox services, Remote Registry, UPnP, etc.), may include Windows Features.

- Section 9: Windows Defender Firewall
  - tasks/section_9/cis_9.1.x.yml: Domain profile configuration (state on, block inbound, notification settings).
  - tasks/section_9/cis_9.2.x.yml: Private profile configuration.
  - tasks/section_9/cis_9.3.x.yml: Public profile configuration.

- Section 17: Advanced Audit Policy Configuration
  - tasks/section_17/cis_17.1.x.yml through cis_17.9.x.yml: Granular audit policy categories:
    - 17.1: Account Logon
    - 17.2: Account Management
    - 17.3: DS Access
    - 17.5: Logon/Logoff
    - 17.6: Object Access
    - 17.7: Policy Change
    - 17.8: Privilege Use
    - 17.9: System
    - Each file enforces success/failure auditing per subcategory per CIS.

- Section 18: Administrative Templates (Computer)
  - 18.1.x: Control Panel and Personalization settings (wallpaper, lock screen, display, etc.).
    - tasks/section_18/section_18.1/cis_18.1.1.x.yml, cis_18.1.2.x.yml, cis_18.1.3.x.yml
  - 18.4.x: Microsoft Defender Antivirus (real-time monitoring, PUA protection, cloud-delivered protection, scans).
  - 18.5.x: Microsoft Defender Firewall with Advanced Security settings (domain/private/public rules behavior, IPSec).
  - 18.6.x: Microsoft Defender SmartScreen, Exploit Guard, Application Control, Credential Guard, Device Guard, ASR rules, etc. (files include cis_18.6.4/5/8/9/10/11/14/19.2/20/21/23.2).
  - 18.7.x: Microsoft Edge policies (updates, SmartScreen, extensions, password manager, home page, privacy).
  - 18.8.1.x: Power Management settings (sleep, hibernate, lid close, battery thresholds).
  - 18.9.x: System components and Windows Update/Delivery Optimization/Telemetry:
    - 18.9.3/4/5/7/13/19/20/23/24/25/26/27/28/31/33/35/36/47/49/51: Includes OneDrive, Cortana, Search, Maps, Advertising ID, App privacy, Bluetooth, Remote Assistance, Error reporting, Windows Update deferal and reboot behavior, Delivery Optimization limits, Windows Ink/Work folders, etc.
  - 18.10.x: Other Windows Components and policies (a large set):
    - Includes Defender features overlap, Windows Hello for Business, BitLocker, WDAC, Windows Installer, Scripted diagnostics, Windows Store policies, Xbox services, Remote Desktop Services client settings, SMB settings, TLS/SSL hardening, Printing restrictions, Cloud content, News/Interests, Widgets, Suggested apps, etc.
    - Numerous files present: cis_18.10.3.x.yml, 4.x, 5.x, 7.x, 8.x, 9.x, 10.x, 12.x, 13.x, 14.x, 15.x, 16.x, 17.x, 25.x, 28.x, 36.x, 40.x, 41.x, 42.x, 43.x, 49.x, 50.x, 55.x, 56.x, 57.x, 58.x, 62.x, 65.x, 71.x, 75.x, 77.x, 78.x, 79.x, 80.x, 81.x, 86.x, 88.x, 89.x, 90.x, 91.x, 92.x.

- Section 19: Administrative Templates (User)
  - tasks/section_19/*.yml: User-side policies like Start menu/taskbar, Microsoft Edge user restrictions, notifications, cloud content, privacy UX, etc.
    - cis_19.5.1.x.yml, 19.6.6.x.yml, 19.7.5/8/26/38/42/44.2.x.yml.

Other role-level tasks

- prelim.yml: Pre-checks, fact gathering, OS/version validation, prerequisite modules, and enabling WinRM connection details required for Windows.
- warning_facts.yml: Sets role warnings about disruptive settings or items requiring reboots.
- post.yml: Post-run steps, potential reboots, and reporting.
- tasks/main.yml and tasks/section_*/main.yml: Include logic that decides which CIS sections to execute based on variables.

Behavioral details likely to occur on the device

- Group Policy and Registry edits applied under HKLM/HKCU per CIS. Some settings may override local user preferences.
- Services disabled or startup type changed. Potentially stops selected services immediately.
- Windows Defender/Firewall policies enforced and existing rules adjusted.
- Advanced Audit Policy updated; starts generating more event logs.
- Potential reboots if required for certain features (e.g., Device Guard/Credential Guard, BitLocker policy staging).
- Reduction of consumer experiences, suggestions, cloud content, and telemetry.
- Tightening of network protocols (SMB signing, NTLM, LDAP, TLS), which can affect legacy systems interoperability.
- UI changes: login banner, UAC prompts behavior, lock screen, start menu limitations.

Deliverable: concise checklist for change review

- Account/Password/Lockout policies set to CIS values.
- Local Security Options (2.3.*) hardened: accounts, network access, network security, devices, interactive logon, system objects, UAC, cryptography.
- System services baseline (2.2.*) applied; non-essential/at-risk services disabled.
- Windows Defender Antivirus configured to CIS; SmartScreen and Exploit Guard hardened.
- Windows Defender Firewall configured across Domain/Private/Public profiles; advanced settings aligned.
- Advanced Audit Policy enabled across all subcategories with CIS success/failure flags.
- Administrative Templates (Computer) extensively hardened for Windows Components, Privacy, Telemetry, Windows Update/Delivery Optimization, Edge, Maps, Cortana, OneDrive, Cloud content, Widgets, Xbox.
- Administrative Templates (User) restrictions for UX, privacy, Edge user settings, Start/Taskbar.
- Remote Desktop, SMB, legacy protocols hardened; anonymous access restricted.
- Login banner text applied from templates/banner.txt.
- Potential reboots triggered; post-run report generated.
- Settings gated by variables in defaults/main.yml/vars/main.yml; only enabled sections will run.

Notes for execution impact

- Some settings can disrupt apps relying on consumer experiences, legacy protocols, or relaxed UAC.
- Audit policy increases log volume; ensure SIEM/log storage sized appropriately.
- Service changes can impact features like Xbox Game Bar, Remote Registry, or Bluetooth scenarios depending on CIS profile level.

This list is tailored to the files present in your repo and represents what will happen when you run the provided playbooks with defaults from this role.
