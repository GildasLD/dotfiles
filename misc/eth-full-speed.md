# Full 2500 eth

```sh
\ip link show enp7s0

cat /proc/interrupts | grep enp7s0

lspci -knn

pkgfile -b lshw
lshw -C network

dmesg | grep enp7s0
dmesg | grep igc

ethtool -i enp7s0
ethtool -s enp7s0 speed 2500 duplex full autoneg off
ethtool enp7s0

pacman -S iperf3
pacman -S lshw

ip -color -all -human a

ip addr show enp7s0
ip address help

journalctl -u NetworkManager | grep enp7s0

nmcli con reload
nmcli con show ConnexionFilaire_1

rm /etc/sysctl.d/99-sysctl.conf
systemctl restart NetworkManager.service
wget --bind-address=192.168.1.150 -O /dev/null http://speedtest.tele2.net/1GB.zip
```

```sh
vim /etc/sysctl.conf
sysctl -p /etc/sysctl.conf
diff  99-sysctl.conf /etc/sysctl.conf
12c12
< net.core.netdev_max_backlog = 16384
---
> net.core.netdev_max_backlog = 50000
14c14
< net.core.rmem_default = 1048576
---
> net.core.rmem_default = 16777216
17c17
< net.core.wmem_default = 1048576
---
> net.core.wmem_default = 16777216
40c40
< net.ipv4.tcp_rmem = 4096 1048576 2097152
---
> net.ipv4.tcp_rmem = 4096 87380 16777216
```
