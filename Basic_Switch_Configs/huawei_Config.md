# Huawei switch configuration(CE 12800, NE40)

## NE40

### Change device name and add IP

```bash
system-view
sysname Huawei-NE40
interface Ethernet 1/0/0
ip address 192.168.0.203 255.255.255.0
quit
display ip interface brief # to confirm the assigned IP.
```

---

### Enable SSH Access

```bash
aaa
local-user admins password irreversible-cipher Cisco1@3
local-user admins level 3
local-user admins service-type ssh
quit
user-interface vty 0 4
authentication-mode aaa
protocol inbound ssh
quit
stelnet server enable
ssh user admins authentication-type password
ssh user admins service-type stelnet
```

---

## Cloud Engine 12800

### Device name and IP

```bash
system-view
sysname Huawei-CE12800
interface GE 1/0/0
undo portswitch
ip address 192.168.0.204 255.255.255.0
quit
display ip interface brief =
```

---

### SSH

```bash
aaa
local-user admins password irreversible-cipher Cisco1@3
local-user admins level 3
local-user admins service-type ssh
quit
user-interface vty 0 4
authentication-mode aaa
protocol inbound ssh
quit
stelnet server enable
ssh user admins authentication-type password
ssh user admins service-type stelnet
```

---