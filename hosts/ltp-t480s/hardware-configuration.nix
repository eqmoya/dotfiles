{
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.hardware.nixosModules.lenovo-thinkpad-t480s
    inputs.disko.nixosModules.disko
    ./disk-config.nix
  ];

  boot = {
    tmp.cleanOnBoot = true;
    initrd = {
      availableKernelModules = ["xhci_pci" "nvme" "usb_storage" "usbhid" "sd_mod"];
      kernelModules = ["kvm-intel"];
    };
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware = {
    cpu.intel.updateMicrocode = true;
    enableAllFirmware = true;
  };
}
