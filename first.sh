mount /dev/sda1 /mnt
cd ~
mkdir windisk
mount /dev/sda2 windisk
grub-install –root-directory=/mnt /dev/sda
cd /mnt/boot/grub
