#!/bin/bash

# Variables
DISK="/dev/vdb"
PARTITION="${DISK}1"
MOUNT_POINT="/mnt/myfilesystem"

# Ensure the script is run as root
if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root" >&2
    exit 1
fi

# Step 1: Partition the Disk
echo "Partitioning the disk..."
(
echo n # Add a new partition
echo p # Primary partition
echo 1 # Partition number
echo   # First sector (Accept default: 1)
echo   # Last sector (Accept default: varies)
echo w # Write changes
) | fdisk $DISK

# Step 2: Create the File System
echo "Creating the file system..."
mkfs.ext4 $PARTITION

# Step 3: Create a Mount Point
echo "Creating mount point..."
mkdir -p $MOUNT_POINT

# Step 4: Mount the File System
echo "Mounting the file system..."
mount $PARTITION $MOUNT_POINT

# Step 5: Update /etc/fstab for automatic mounting
echo "Updating /etc/fstab..."
echo "$PARTITION $MOUNT_POINT ext4 defaults 0 2" >> /etc/fstab

# Confirm the file system is mounted
echo "File system mounted at $MOUNT_POINT"
df -h $MOUNT_POINT

# Done
echo "File system setup complete."

