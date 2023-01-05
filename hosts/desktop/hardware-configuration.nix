{ config, lib, pkgs, modulesPath, ... }:

{
    imports =
        [ (modulesPath + "/installer/scan/not-detected.nix")
        ];
    
    boot = {
        kernelModules = [ "kvm-intel" ];
        extraModulePackages = with config.boot.kernelPackages; [ ];

        initrd = {
            availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "uas" "sd_mod" "sr_mod "];
            kernelModules = [ ];
        };
    };

    fileSystems."/" = {
        device = "/dev/disk/by-label/nixos";
        fsType = "ext4";
    };

    fileSystems."/boot" = {
        device = "/dev/disk/by-label/boot";
        fsType = "vfat";
    };

    swapDevices = [ ];

    powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

    networking = {
        useDHCP = lib.mkDefault true;
        hostName = "desktop";
        networkmanager.enable = true;
    };
}