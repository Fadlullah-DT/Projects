# INterview

- JazakAllah for the interview opportunity

## Experience and things that I have done

### Service canada internship

- Setting up/installing/configuring windows 11 laptops and computers
- setting up laptops and desktops for new users and new classrooms
- life cycling old laptop (removing the hard drive, removing the device from the list of active devices and from under the users assigned devices from the system, then putting the device in the lifecycle pile in the storage room)
- recovering laptops from retiring employees or employees that changed departments
- troubleshooting network connectivity issues where a user did not have access to the internet while others around them had access, when they connected their laptop to another ethernet port they had internet, the problem turned out to be an issue with the wall port that they were connecting to so i have to make a ticket to the networking team to fix

### Internship with dimension tech

- Setting up/configuring storage on a HP Proliant(server)
- Setting up (Proof of concept)POC for DC(data center) automation using arista switches and ansible
- Configuring switches manual and through ansible
- utilizing arista avd collection to fully automate 1 single data center EVPN topology
  - (learned basic of data center routing)
  - EVPN uses BGP(border gateway protocol) to share where each MAC addresses and IP are located
  - build a tunnle (using VXLAN) to carry the frames across the IP network
  - that way there is no need to flood the network with broadcast because EVPN knows where devices are
- basic CCNA training
  - Layer 7: Application Layer:
  - Layer 6: Presentation Layer: data formatting, translation, and encryption
  - Layer 5: Session Layer: Manages sessions between devices, establishing, maintaining, and terminating connections
  - Layer 4: Transport Layer: Ensures reliable or unreliable end-to-end data delivery uses protocols like TCP and UDP.
  - Layer 3: Network Layer: Handles IP addresses and routing
  - Layer 2: Data Layer: Manages physical addressing (MAC addresses)
  - Layer 1: Physical Layer: send the raw bits over the network medium. includes physical components like cables, and network interface cards, and handles electrical signals, light pulses, or radio waves. 
- ansible level 1 training
- level 1 azure admin training
- proxmox VE advanced training

### work related to Th/Azure under Waqas Sb

- Proxmox distributed storage setup
- Proxmox windows vm template setup
- Windows 11/Server 2022 Hardening through ansible

## possible topics of discussion

- basic CCNA training
  - Layer 7: Application Layer:
  - Layer 6: Presentation Layer: data formatting, translation, and encryption
  - Layer 5: Session Layer: Manages sessions between devices, establishing, maintaining, and terminating connections
  - Layer 4: Transport Layer: Ensures reliable or unreliable end-to-end data delivery uses protocols like TCP and UDP.
  - Layer 3: Network Layer: Handles IP addresses and routing
  - Layer 2: Data Layer: Manages physical addressing (MAC addresses)
  - Layer 1: Physical Layer: send the raw bits over the network medium. includes physical components like cables, and network interface cards, and handles electrical signals, light pulses, or radio waves.

- Linux permissions
  - 3 sets of permission
    - Owner permission, Group permission and Others
    - r(4) - read, w(2) - write(modify), x(1) - execute
  - Ls -l will display the file and directory permission
  - modify file permissions using chmod (chmod u+x/chmod 754)
  - change the file owner use chown

- linux directory structure
  - / root directory
    - every other directory is under the root directory
    - /bin
    - /etc - system configurations
    - /home home directory contains the users directory is
    - /tmp where temporary files are stored
    - /usr contains user related programs
    - /var contain log files
  - cd to change directories
    - Absolute path where ever you are if you cd with the full path of the directory you want to go to stating from the root directory
    - relative path cd with the path relative to you current directory
    - cd goes back to home directory
    - pwd give the full path of your current directory
    - ls gives a list of what is in the current directory
    - ls -l gives a more detailed list with size, permission and ownership
    - ls -a shows all files including hidden files

- Windows Remote Desktop Service/Terminal Services for thick apps
  - Thick apps
    - Thick app is a locally installed app that does its own processing on the computer
  - RDS/Terminal services
    - RDS is a microsoft feature that lets users remotely run applications on a server so they don’t need to install or process them locally.
  - so with tick apps the application would be hosted on the server and Users just get a remote window that shows what’s happening on the server.
    - its kind of like a video stream that sends back keyboard inputs
  - it allows for centralized management/security/updates
  - Thick app is a locally installed app that does its own processing on the computer.

- AVD
  - lets people use a Windows desktop and apps that live in the cloud instead of on their own PCs.
  - host pool - group of vms where the users connect
    - personal - each session host is assigned to an individual user
    - pooled - multiple users on a single session host at the same time
  - Session hosts - VM that provides remote desktop. applications to the users
  - Application groups - a set of apps that you allow the users access to

- aws VPC/azure vnet, vnet peering, purpose of gateway subnet in azure vnet
  - Azure VNets let resources communicate with each other and the internet
    - VNet Peering - connects 2 VNets together allowing the resources in each VNet to communicate with each other like they are in the same network
    - NSGs(network security groups) - control inbound and outbound traffic
    - A gateway subnet is a dedicated subnet used to house VNet Gateways to connect my network to other networks, it contains the IP addresses for Gateway VMs and services and routes traffic
  - AWS VPC 


- azure AD(entra ID) vs  Microsoft AD
  - azure AD(entra ID ) - cloud based Identity and access management service for cloud based applications and services
  - Microsoft AD is on-premise directory service for local networks

- Software deployment using Windows GPO
  - requires a .msi installer file placed in a shared network folder that is assigned to the target computers
  - requires a gpo that is linked the target OU
    - assign the .msi file from the shared folder as a new package in the software installation section under computer configuration in gpo management editor
    - gpupdate /force to update the policy

- Revise IP addressing
You are given the network:
192.168.10.0(/26)

this is (/26) as binary (11111111).(11111111).(11111111).(11000000)

to figure out the subnet mask - each sequence has 8 bits that all add up to 255 (128-64-32-16-8-4-2-1)
to figure out the subnet mask count the on bits and add them according to (128-64-32-16-8-4-2-1) so for this example that has the first 2 bits turned on you add 128+64=192 so the subnet mask for /26 is 255.255.255.192

to figure out how many host you need to borrow use this formula 2^n=h, h is the number of subnets you need and n is the borrowed hosts so say we need 4 subnets 2^n=4 -> 2^2=4 so we need 2 borrowed hosts.  
figuring out usable host 2^(32−26) − 2 = 62` hosts

 * 192.168.10.0 → Range: 192.168.10.1 – 192.168.10.62 (Broadcast: 192.168.10.63)
   * 192.168.10.64 → Range: 192.168.10.65 – 192.168.10.126 (Broadcast: 192.168.10.127)
   * 192.168.10.128 → Range: 192.168.10.129 – 192.168.10.190 (Broadcast: 192.168.10.191)
   * 192.168.10.192 → Range: 192.168.10.193 – 192.168.10.254 (Broadcast: 192.168.10.255)

  

172.16.0.0/20
 2^3 = 8, so borrow 3 bits.
 New prefix = /20 + 3 = /23
 
2^(32−23) − 2 = 510
 2^(9)-2 = 510
 512 -2 =510


- IPSec vpn
  - a private network that uses the IPsec protocol to create secure connections ove the internet
    - operates at layer 3
    - uses authentication and encryption for secure communication
    - establishes secure tunnel for key exchange uses the keys to encrypt data being sent