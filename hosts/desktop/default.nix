{ pkgs, lib, ... }:

{
    imports =
        [(import ./hardware-configuration.nix)] ++
        [(import ../../modules/desktop/awesome/default.nix)] ++
        [(import ../../modules/desktop/gnome/default.nix)];

    boot = {
        kernelPackages = pkgs.linuxPackages_latest;

        loader = {
            systemd-boot = {
                enable = true;
                configurationLimit = 10;
            };

            efi.canTouchEfiVariables = true;
            timeout = 15;
        };
    };
}