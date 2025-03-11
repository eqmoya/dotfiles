{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.theme;
in {
  imports = [
    ./dark
    ./light
  ];
  options.modules.theme = with types; {
    dark = mkEnableOption "dark";
    wallpaper = mkOption {type = path;};
    colorScheme = mkOption {type = attrs;};
    gtk = mkOption {
      type = attrs;
      default = {};
    };
    fonts = with pkgs; {
      sans = {
        name = mkOption {type = str;};
        size = mkOption {type = number;};
        package = mkOption {type = package;};
      };

      serif = {
        name = mkOption {type = str;};
        size = mkOption {type = number;};
        package = mkOption {type = package;};
      };

      mono = {
        name = mkOption {type = str;};
        size = mkOption {type = number;};
        package = mkOption {type = package;};
      };

      emoji = {
        name = mkOption {
          type = str;
          default = "Noto Color Emoji";
        };
        size = mkOption {
          type = number;
          default = cfg.fonts.sans.size;
        };
        package = mkOption {
          type = package;
          default = noto-fonts-color-emoji;
        };
      };

      icons = {
        name = mkOption {
          type = str;
          default = "Font Awesome 6 Free";
        };
        size = mkOption {
          type = number;
          default = cfg.fonts.sans.size;
        };
        package = mkOption {
          type = package;
          default = font-awesome;
        };
      };

      symbols = {
        name = mkOption {
          type = str;
          default = "Symbols Nerd Font";
        };
        size = mkOption {
          type = number;
          default = cfg.fonts.sans.size;
        };
        package = mkOption {
          type = package;
          default = nerdfonts.override {fonts = ["NerdFontsSymbolsOnly"];};
        };
      };

      packages = mkOption {
        type = listOf package;
        default = [];
      };
    };
  };

  config = {
    # specialisation = {
    #   dark.configuration.modules.theme.dark = mkForce true;
    #   light.configuration.modules.theme.dark = mkForce false;
    # };

    modules.cli.shells.shellAliases = {
      dark = "sudo /nix/var/nix/profiles/system/specialisation/dark/bin/switch-to-configuration switch";
      light = "sudo /nix/var/nix/profiles/system/specialisation/light/bin/switch-to-configuration switch";
    };

    home-manager.users.${config.user.name} = {
      home.pointerCursor =
        cfg.gtk.cursorTheme
        // {
          gtk.enable = true;
        };

      gtk =
        cfg.gtk
        // {
          enable = true;
        };

      dconf.settings = let
        dconfColorScheme = if cfg.dark then "prefer-dark" else "prefer-light";
      in {
        "org/gnome/desktop/interface".color-scheme = dconfColorScheme;
      };
    };

    fonts = {
      packages =
        [
          cfg.fonts.serif.package
          cfg.fonts.sans.package
          cfg.fonts.mono.package
          cfg.fonts.emoji.package
          cfg.fonts.icons.package
          cfg.fonts.symbols.package
        ]
        ++ cfg.fonts.packages;

      fontconfig.defaultFonts = let
        addAll = builtins.mapAttrs (_: v:
          v
          ++ [cfg.fonts.symbols.name]
          ++ [cfg.fonts.emoji.name]);
      in
        addAll {
          serif = [cfg.fonts.serif.name];
          sansSerif = [cfg.fonts.sans.name];
          monospace = [cfg.fonts.mono.name];
          emoji = [];
        };
    };
  };
}
