Perfect 👍 — here’s a clean, professional-style documentation section you can add to your **Windows Hardening / Recovery** notes.
It explains what happened, how to fix it manually, and how to prevent it from happening again in Ansible.

---

## 🧱 **Fixing RDP Access After Enforcing Network Level Authentication (NLA)**

### 🔍 Background

During the Ansible Lockdown run, the following CIS rule was applied:

```yaml
- name: "18.10.56.3.9.4 | PATCH | Ensure Require user authentication for remote connections by using Network Level Authentication is set to Enabled"
  ansible.windows.win_regedit:
      path: HKLM:\Software\Policies\Microsoft\Windows Nt\Terminal Services
      name: UserAuthentication
      data: 1
      type: dword
```

This rule enforces **Network Level Authentication (NLA)** for Remote Desktop connections.
NLA requires users to authenticate before establishing an RDP session.
If your RDP client or credentials are not configured correctly—or if you’re using a **local account**—you may lose RDP access after this rule is applied.

---

### ⚠️ Issue

After enabling this rule, users may encounter:

* RDP refusing connections.
* “Some settings are managed by your organization” message in the Remote Desktop settings.
* Inability to toggle Remote Desktop on/off.
* The setting **“Require user authentication for remote connections by using Network Level Authentication”** not visible in `gpedit.msc`.

This occurs because the lockdown role modifies registry keys directly, bypassing the Local Group Policy Editor.

---

### 🧩 Manual Fix (Inside the Windows VM)

If you still have **console access** (e.g., via Proxmox, Hyper-V, or VMware):

1. **Open PowerShell as Administrator.**

2. Run the following commands:

   ```powershell
   # Disable Network Level Authentication
   Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services' -Name 'UserAuthentication' -Value 0

   # Allow RDP connections (in case it was disabled)
   Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server' -Name 'fDenyTSConnections' -Value 0

   # Ensure Remote Desktop Services are enabled and running
   Set-Service -Name TermService -StartupType Automatic
   Start-Service -Name TermService

   # Enable RDP through the firewall
   Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

   # Apply policy updates
   gpupdate /force
   ```

3. After running these commands, go to:

   ```
   Settings → System → Remote Desktop
   ```

   * The toggle should now be available.
   * Enable **Remote Desktop**.
   * You should be able to reconnect using RDP without NLA.

---

### 🛠️ Prevent Future Lockdown Re-application

To prevent Ansible from re-enabling NLA in future runs, set this rule to **false** in your `vars` or main playbook:

```yaml
win11cis_rule_18_10_56_3_9_4: false
```

This ensures the Lockdown role skips applying the NLA requirement during subsequent playbook executions.

---

### ✅ Summary

| Setting                | Description                         | Default CIS Action | Recommended for Lab |
| ---------------------- | ----------------------------------- | ------------------ | ------------------- |
| **UserAuthentication** | Controls NLA for RDP connections    | Enabled (`1`)      | Disabled (`0`)      |
| **fDenyTSConnections** | Enables or disables RDP connections | Disabled (`1`)     | Enabled (`0`)       |

Disabling NLA is acceptable for **test environments** or **isolated lab networks**, but it should remain **enabled in production** for security.

---

Would you like me to add a short **“Troubleshooting RDP Access”** section right after this, summarizing both NLA and service disablement issues (like TermService being off)? That would make your documentation more complete.


Got it 👍 — from your screenshot, the message **“Some settings are managed by your organization”** means that **Group Policy or a registry policy** (applied by your Ansible lockdown) is currently **forcing RDP to stay off** and likely enforcing **Network Level Authentication (NLA)** as well.

Here’s how to fix it manually inside the Windows VM:

---

### 🧩 Step 1: Remove the RDP Group Policy Lock

1. Press **Win + R**, type:

   ```
   gpedit.msc
   ```

   and press **Enter**.

2. Go to:

   ```
   Computer Configuration → Administrative Templates → Windows Components → Remote Desktop Services → Remote Desktop Session Host → Connections
   ```

3. Double-click **“Allow users to connect remotely by using Remote Desktop Services”**
   → Set it to **Enabled**.

4. Next, go to:

   ```
   Computer Configuration → Administrative Templates → System → Credentials Delegation
   ```

   Look for **“Require user authentication for remote connections by using Network Level Authentication”**
   → Set it to **Disabled**.

5. Click **Apply → OK** for each change.

---

### 🧹 Step 2: Update Group Policy Immediately

Open PowerShell (as Administrator) and run:

```powershell
gpupdate /force
```

---

### 🖥️ Step 3: Re-enable RDP Manually

Now go back to:

```
Settings → System → Remote Desktop
```

You should now be able to toggle **Remote Desktop ON** normally.

---

### 🧰 Optional (if it’s still greyed out)

If the switch is still greyed out, remove the enforced policy key:

1. Open PowerShell (Admin).
2. Run:

   ```powershell
   Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services' -Name 'fDenyTSConnections' -ErrorAction SilentlyContinue
   Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services' -Name 'UserAuthentication' -ErrorAction SilentlyContinue
   Restart-Service TermService -Force
   ```
3. Then retry enabling RDP.

---

Would you like me to give you a **single PowerShell script** that will remove the lockdown restrictions, disable NLA, and re-enable RDP in one go? That can save time if you prefer a quick fix.
