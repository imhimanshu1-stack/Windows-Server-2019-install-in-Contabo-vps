apt update
sudo apt update -y
sudo apt upgrade -y
sudo su
apt install gparted filezilla grub2 wimtools -y
gparted
gdisk /dev/sda
r

g

p

w

Y
mount /dev/sda1 /mnt
cd ~
mkdir windisk
mount /dev/sda2 windisk
grub-install –root-directory=/mnt /dev/sda
cd /mnt/boot/grub
nano grub.cfg

menuentry “windows installer” {
insmod ntfs
search –set=root –file=/bootmgr
ntldr /bootmgr
boot
}

cd /root/windisk
mkdir winfile
wget -O win10.iso https://rb.gy/baby9w
mount -o loop win10.iso winfile
rsync -avz –progress winfile/* /mnt
umount winfile
wget -O virtio.iso https://shorturl.at/aiy13
mount -o loop virtio.iso winfile
rsync -avz –progress winfile/* /mnt/sources/virtio
mkdir /mnt/sources/virtio
cd /mnt/sources
touch cmd.txt
echo ‘add virtio /virtio_drivers’ >> cmd.txt
wimlib-imagex update boot.wim 2 < cmd.txt
