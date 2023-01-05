{ config, lib, pkgs, inputs, user, location, ... }:

{
    imports =
        ( import ../modules/shell );

    users.users.${user} = {
        isNormalUser = true;
        initialPassword = "password";
        extraGroups = [ "wheel" "networkmanager" "video" "audio" "lp" "scanner" "kvm" "libvirtd" ];
        shell = pkgs.zsh;
    };

    time.timeZone = "Europe/Madrid";
    i18n = {
        defaultLocale = "en_US.UTF-8";
        extraLocaleSettings = {
            # LC_ADDRESS = "es_ES.UTF-8";
            # LC_IDENTIFICATION = "es_ES.UTF-8";
            LC_MEASUREMENT = "es_ES.UTF-8";
            LC_MONETARY = "es_ES.UTF-8";
            # LC_NAME = "es_ES.UTF-8";
            # LC_NUMERIC = "es_ES.UTF-8";
            # LC_PAPER = "es_ES.UTF-8";
            # LC_TELEPHONE = "es_ES.UTF-8";
            # LC_TIME = "es_ES.UTF-8";
        };
    };

    console = {
        font = "Lat2-Terminus16";
        keyMap = "us";
    };

    security.rtkit.enable = true;

    fonts = {
        fonts = with pkgs; [
            roboto
            roboto-slab
            jetbrains-mono
            font-awesome
            corefonts
            (nerdfonts.override {
                fonts = [
                    "JetBrainsMono"
                ];
            })
        ];

        fontconfig = {
            defaultFonts = {
                monospace = [
                    "JetBrains Mono"
                    "JetBrainsMono Nerd Font"
                ];

                sansSerif = [
                    "Roboto"
                ];

                serif = [
                    "Roboto Slab"
                ];
            };
        };
    };

    environment = {
        variables = {
            TERMINAL = "alacritty";
            EDITOR = "nvim";
            VISUAL = "nvim";
        };

        systemPackages = with pkgs; [
            killall
            nano
            pciutils
            usbutils
            wget
        ];
    };

    services = {
        pipewire = {
            enable = true;
            alsa = {
                enable = true;
                support32Bit = true;
            };

            pulse.enable = true;
            jack.enable = true;
        };

        flatpak.enable = true;
    };

    nix = {
        settings = {
            auto-optimise-store = true;
        };

        gc = {
            automatic = true;
            dates = "weekly";
            options = "--delete-older-than 2d";
        };

        package = pkgs.nixVersions.unstable;
        registry.nixpkgs.flake = inputs.nixpkgs;
        extraOptions = ''
            experimental-features = nix-command flakes
            keep-outputs = true
            keep-derivations = true
        '';
    };

    nixpkgs.config.allowUnfree = true;

    system = {
        autoUpgrade = {
            enable = true;
            channel = "https://nixos.org/channels/nixos-unstable";
        };

        stateVersion = "23.05";
    };
}