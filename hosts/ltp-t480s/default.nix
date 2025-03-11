{pkgs, ...}: {
  imports = [
    ../.
    ./hardware-configuration.nix
    ./locale.nix

    ./tmp.nix
  ];

  user.name = "enrique";

  modules = {
    editors.default = "nvim";
    theme.dark = true;

    system = {
      networking.hostName = "ltp-t480s";
      hardware = {
        audio.enable = true;
        bluetooth.enable = true;
        thunderbolt.enable = true;
      };
    };

    services = {
      logind.enable = true;
      waybar.enable = true;
      greetd = {
        enable = true;
        session_cmd = "hyprland";
      };
    };

    cli = {
      starship.enable = true;
      tmux.enable = true;
      git = {
        enable = true;
        userName = "Enrique Moya";
        userEmail = "enriquemoygar@gmail.com";
      };

      shells = {
        default = pkgs.zsh;
        shellAliases = {
          # ...
        };
      };
    };

    desktop = {
      terminals.default = "kitty";
      browsers.default = "firefox";
      hyprland = {
        enable = true;
        extraConfig = ''
          monitor = eDP-1, preferred, -2000x-2000, 1.25
          workspace = 1, monitor:eDP-1
          exec-once = [workspace 2 silent] firefox
        '';
      };
    };
  };
}
