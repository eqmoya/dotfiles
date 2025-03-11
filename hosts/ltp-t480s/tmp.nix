{
  pkgs,
  config,
  ...
}: {
  home-manager.users.${config.user.name} = {
    programs.wofi = {
      enable = true;
      settings = {
        mode = "drun";
        image_size = 48;
        columns = 3;
        allow_images = true;
        insensitive = true;
        run-always_parse_args = true;
        run-exec_search = true;
        matching = "multi-contains";
      };
      style = ''
        * {
            font-family: "JetBrains Mono";
            background-color: transparent;
            color: white;
        }
        window {
            background-color: black;
            border-radius: 10px;
            border: 2px solid #5074bd;
        }
        #entry:selected {
            background-color: #5074bd;
            color: white;
        }
      '';
    };
  };

  environment = {
    variables = {
      XDG_SCREENSHOTS_DIR = "$HOME/Media/Pictures/Screenshots";
    };
    systemPackages = with pkgs; [
      vscode
      brave
      time
      fastfetch
      btop
      gimp
      obsidian
      docker-compose
      xournalpp
      php82 # Just for lsp
      wev # wayland's event viewer to check key name
      zip
      krita
      discord
      gnome.gnome-control-center
      libreoffice
      gh
      jq
      # Android mirroring
      scrcpy
      android-tools
      usbutils
      mysql-workbench
      brave
      moonlight-qt

      qemu
      virt-manager
      libvirt
      virtiofsd
    ];
  };

  virtualisation = {
    libvirtd.enable = true;

    docker = {
      enable = true;
      enableOnBoot = false;
    };
  };

  services.udev.packages = with pkgs; [virtiofsd];

  services.upower.enable = true; # to show battery % in tmux and ags...

  # programs.dconf.enable = true;

  # Tablet
  services.libinput.enable = true;
  # hardware.opentabletdriver.enable = true;

  # Android mirroring
  services.udev = {
    extraRules = ''
      SUBSYSTEM=="usb", ATTR{idVendor}=="18d1", MODE="0666", GROUP="plugdev"
    '';
  };

  users.users.${config.user.name}.extraGroups = ["docker" "plugdev" "libvirtd" "qemu-libvirtd"];
}
