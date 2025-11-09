🔹 Networking (CCNA Level)

Q: Can you explain the OSI model briefly?
A: Sure — it’s a 7-layer model that describes how data moves through a network.
Layer 1 is the Physical Layer (cables, signals),
Layer 2 is Data Link (MAC addressing),
Layer 3 is Network (IP addressing and routing),
Layer 4 is Transport (TCP/UDP data delivery),
Layer 5 is Session,
Layer 6 is Presentation (formatting, encryption),
Layer 7 is Application (user interfaces).
It helps us understand where issues might occur — like whether a problem is physical, network, or application-related.

Follow-up Q: Which layers would you troubleshoot first if a user can’t access a web page?
A: I’d start from the bottom — check physical connectivity (Layer 1–2), IP configuration (Layer 3), and then move up to DNS and browser/application layers.

🔹 Linux Permissions

Q: How do file permissions work in Linux?
A: Permissions are split into three groups — owner, group, and others — and use the letters r, w, and x (read, write, execute). You can modify permissions using commands like chmod or change ownership with chown.
For example, chmod 754 file gives full access to the owner, read-execute to the group, and read-only to others.

Follow-up Q: How would you find all hidden files in a directory?
A: By using ls -a. It lists all files, including hidden ones starting with a dot.

🔹 Linux Directory Structure

Q: What’s the purpose of /etc and /var directories?
A: /etc contains system configuration files — things like network and service configs — while /var stores variable data such as logs, spool files, and caches.

Follow-up Q: How would you quickly navigate back to your home directory?
A: By running cd with no arguments, or cd ~.

🔹 Windows Remote Desktop Services (Thick Apps)

Q: What’s the difference between a thick client and RDS-hosted application?
A: A thick app is installed locally and uses the client’s resources. With RDS (Remote Desktop Services), the app runs on a server — users only see a remote window showing what’s happening on the server. It’s like streaming the app interface while keeping data and processing centralized for easier updates and management.

🔹 Azure Virtual Desktop (AVD)

Q: Can you explain what Azure Virtual Desktop is?
A: It’s a cloud-based desktop virtualization service from Microsoft that lets users access Windows desktops and apps hosted in Azure.
You set up host pools (groups of VMs), define whether they’re personal or pooled, assign application groups, and connect users remotely. It’s useful for secure, centralized desktop management — especially for remote teams.

🔹 Azure Networking

Q: What’s the purpose of a gateway subnet in Azure?
A: A gateway subnet hosts the Azure VPN gateway — the service that connects your virtual network (VNet) to on-prem or other VNets. Is a  dedicated subnet for routing traffic between networks.

Follow-up Q: How does VNet peering work?
A: VNet peering links two VNets, allowing resources in each to communicate privately as if they were in the same network.

🔹 Azure AD vs Microsoft AD

Q: What’s the difference between Microsoft AD and Azure AD (Entra ID)?
A: Microsoft AD is on-premises, managing local users and devices in a domain environment.
Azure AD, now called Entra ID, is cloud-based, managing identities for cloud apps and services. It’s used for SSO, MFA, and integrating with Microsoft 365 or Azure resources.

🔹 Windows GPO Deployment

Q: How would you deploy software using Group Policy?
A: Place the .msi installer in a shared folder with read access for target computers, create a GPO linked to the target OU, then under Computer Configuration → Software Installation, assign the package.
Finally, run gpupdate /force on the target machines to apply it.

🔹 Subnetting Example

Q: If I give you 192.168.10.0/26, how many usable hosts does that provide?
A: /26 gives 64 total addresses. Subtract 2 (for network and broadcast), so 62 usable hosts.
Subnet mask: 255.255.255.192.
Usable range: 192.168.10.1 – 192.168.10.62.

Follow-up Q: What’s the broadcast address for that subnet?
A: 192.168.10.63.

🔹 IPSec VPN

Q: What is an IPSec VPN and where does it operate in the OSI model?
A: IPSec VPN is a secure network connection that encrypts data between two endpoints over the internet. It operates at Layer 3, providing encryption, authentication, and integrity for IP packets.
