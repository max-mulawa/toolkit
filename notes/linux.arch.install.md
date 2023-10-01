---
id: jdwy5cl1o1hnfixbeiqj20y
title: Install
desc: ''
updated: 1676453696590
created: 1676453696590
---
Source:
- https://linuxiac.com/arch-linux-install/
- https://wiki.archlinux.org/title/installation_guide
- https://wiki.archlinux.org/title/VirtualBox/Install_Arch_Linux_as_a_guest

### Download and verify image

Download: https://archlinux.org/download/

Download Iso
```
wget http://ftp.icm.edu.pl/pub/Linux/dist/archlinux/iso/2022.02.01/archlinux-2022.02.01-x86_64.iso
```
Download signature PGP signature
```
wget https://archlinux.org/iso/2022.02.01/archlinux-2022.02.01-x86_64.iso.sig
```
Install gpg util to verify signature
```
apt-get install gpg
```

Import public key used to generate signature
```
gpg --auto-key-locate clear,wkd -v --locate-external-key pierre@archlinux.de
```

Verify image with downloaded PGP signature 
```
gpg --verify archlinux-2022.02.01-x86_64.iso.sig ./archlinux-2022.02.01-x86_64.iso
```
## Enable UEFI support as per in VirtualBox machine
https://linuxiac.com/arch-linux-install/
(follow instruction)
or 
```
VBoxManage modifyvm "Virtual machine name" --firmware efi
```

Load polish keyboard mapping
```
loadkeys pl
```

Check if system booted in UEFI mode, Displays multiple files -> Correct
```
ls /sys/firmware/efi/efivards 
```

Check if network interfaces are setup
```
ip link
```

If connect to WIFI use iwctl tool
https://wiki.archlinux.org/title/Iwd#iwctl

Sync system clock
```
datetimectl status 
datetimectl set-ntp true
```

### Disk / partitions setup

- Check disks/partitions/mounts
```
fdisk -l #https://wiki.archlinux.org/title/Fdisk#Create_new_table
findmnt #check mount points
```

fdisk tutorial https://phoenixnap.com/kb/linux-create-partition
- With fdisk create 3 partitions:
```
fdisk
'n' (new partition) 
# 1G for boot uefi partiion (changet type from Linux to Uefi with 't' command)
# 500M partision for swap 
# rest for Linux partition 
'w' # to write all changes
```
- format all 3 partitions
```
mkfs.fat -F 32 /dev/sda1 #for UEFI
mkswap /dev/sda2 # for swap
mkfs.ext4 /dev/sda3 #for root / folder
```
- mount all partitions and create mounting points (directories) when needed
```
mount all partitions
mount /dev/sda3 /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot
swapon /dev/sda2
```


### Install packages:
```
pacstrap /mnt base linux linux-firmware sudo vi
```

###  Generate fstab to pesist on new system with UUIDs 
```
genfstab -U /mnt >> /mnt/etc/fstab
```

```
arch-chroot /mnt
```

```
ln -sf /usr/share/zoneinfo/Europe/Warsaw /etc/localtime
```

### Generate /etc/adjtime
```
hwclock --systohc
```

### install something new with pacman (https://wiki.archlinux.org/title/pacman#Installing_packages)
```
pacman -Syy #sync repositories
packman -S vi
packaman -S sudo
```

### Edit /etc/locale.gen and uncomment en_US.UTF-8 UTF-8
```
vi /etc/locale.gen 
```

### Generate locale for uncommented 
```
locale-gen
```

### add hostname
```
vi /etc/hostname 
```

### Add entries for localhost and hostname
```
vi /etc/hosts
127.0.0.1      localhost
::1            localhost
127.0.1.1      arch-pc
```
### install grub

- EFI paritions (mount points options) https://wiki.archlinux.org/title/EFI_system_partition#Mount_the_partition
- Grub installations parameters https://wiki.archlinux.org/title/GRUB#Installation_2

```
grub-install --target=x86_64-efi --bootloader-id=grub_uefi --efi-directory=/boot
```
### generate grub configuration
```
grub-mkconfig -o /boot/grub/grub.cfg
```
### 
```
exit
umount -R /mnt
reboot
```

### Enable X-server
Install x-server
```
pacman -S xorg-server xorg-apps
```
Search graphic cards avaibale
```
lspci | grep -i "VGA"
```
Search drivers 
```
pacman -Ss xf86-video
```
Install matching driver
```
pacman -S xf86-video-vmware
```

```
pacman -S gnome gnome-extra networkmanager
```
Stopped, as problem with missing libgweather gnome library, trying to resolve by manual install 
```
pacman -Syu libgweather
```

After installing gnome, enable networkmanager (it's already on) and gdm 
```
systemctl enable gdm
systemctl enable NetworkManager
```



## Troubleshooting

### Network connectivity problems

- check network interface status and if systemd-netword network manager is enabled
```
ip link #check if interface en is up 
systemctl status systemd-networkd.service
```
- Configure systemd-networkd.service to enable network interface
```
/etc/systemd/network/20-wired.network
[Match]
Name=enp0s3

[Network]
DHCP=yes
```
- Configure DNS resolution for cloudflare DNS
```
/etc/resolv.conf
nameserver 1.1.1.1
```
- enable systemd-netword service
```
systemctl enable systemd-networkd.service
systemctl start systemd-networkd.service
```

```
ping 1.1.1.1 
ping wp.pl
```

### booting from grub2
- first partition is efi - /dev/sda1 or (hd0,1)
- root filesystem is on /dev/sda1 or (hd0,3)
https://www.linux.com/training-tutorials/how-rescue-non-booting-grub-2-linux/
#list partiotions
```
grub> ls
```
#list files in partition
```
grub> ls (hd0,1)/ #list content of the partition
grub> set root=(hd0,1)
grub> linux /vmlinuz-... root=/dev/sda3
grub> initrd /init.....img
grub> boot
```














