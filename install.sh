#!/bin/bash

echo "Starting NixOS installation script..."

while true; do
    echo "Enter the NixOS configuration name:"
    read CONFIG_NAME

    if [ -n "$CONFIG_NAME" ]; then
        break
    else
        echo "NixOS configuration name cannot be empty."
    fi
done

DISK_CONFIG="hosts/$CONFIG_NAME/disk-config.nix"

if [ -f "$DISK_CONFIG" ]; then
    echo "Disko configuration found. Partitioning the disk..."
    sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko $DISK_CONFIG
    if [ $? -ne 0 ]; then
        echo "Error during disko partitioning."
        exit 1
    fi
    echo "Disk partitioning completed."
else
    echo "No disko configuration found at $DISK_CONFIG. Skipping disk partitioning..."
fi

# Execute NixOS installation
echo "Starting NixOS installation..."
sudo nixos-install --no-root-passwd --flake .#$CONFIG_NAME
if [ $? -ne 0 ]; then
    echo "Error during NixOS installation."
    exit 1
fi

echo "NixOS installation completed successfully."
