#!/bin/bash

# Navigate to the windisk directory, or create it if it doesn't exist, and navigate into it
cd /root/windisk || mkdir /root/windisk && cd /root/windisk

# Create a directory named winfile
mkdir -p winfile
echo "Created winfile directory. Press any key to continue..."
read -n 1 -s

# Download Windows 10 ISO
wget -O win10.iso https://rb.gy/baby9w
echo "Downloaded win10.iso. Press any key to continue..."
read -n 1 -s

# Mount the ISO to winfile directory
mount -o loop win10.iso winfile
echo "Mounted win10.iso to winfile. Press any key to continue..."
read -n 1 -s

# Synchronize winfile directory content to /mnt
rsync -avz --progress winfile/* /mnt
echo "Synced winfile content to /mnt. Press any key to continue..."
read -n 1 -s

# Unmount the winfile directory
umount winfile
echo "Unmounted winfile. Press any key to continue..."
read -n 1 -s

# Download VirtIO drivers ISO
wget -O virtio.iso https://shorturl.at/aiy13
echo "Downloaded virtio.iso. Press any key to continue..."
read -n 1 -s

# Mount the VirtIO drivers ISO to winfile directory
mount -o loop virtio.iso winfile
echo "Mounted virtio.iso to winfile. Press any key to continue..."
read -n 1 -s

# Ensure the target directory exists before synchronization
mkdir -p /mnt/sources/virtio
echo "Ensured /mnt/sources/virtio exists. Press any key to continue..."
read -n 1 -s

# Synchronize VirtIO drivers to the specified directory
rsync -avz --progress winfile/* /mnt/sources/virtio
echo "Synced VirtIO drivers. Press any key to continue..."
read -n 1 -s

# Navigate to the sources directory in /mnt
cd /mnt/sources
echo "Navigated to /mnt/sources. Press any key to continue..."
read -n 1 -s

# Create a cmd.txt file and write the specified command into it
echo "add virtio /virtio_drivers" > cmd.txt
echo "Created and wrote to cmd.txt. Press any key to continue..."
read -n 1 -s

# Update the boot.wim file based on the cmd.txt instructions
wimlib-imagex update boot.wim 2 < cmd.txt
echo "Updated boot.wim. Press any key to continue..."
read -n 1 -s
