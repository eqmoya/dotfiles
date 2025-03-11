{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.services.waybar;
in {
  options.modules.services.waybar.enable = mkEnableOption "waybar";
  config = mkIf cfg.enable {
    home-manager.users.${config.user.name} = {
      systemd.user.services.waybar = {
        Unit.StartLimitBurst = 30;
      };

      programs.waybar = {
        enable = true;
        systemd.enable = true;
        settings = {
          default = {
            layer = "top";
            margin-top = 0;
            margin-bottom = 0;
            margin-left = 0;
            margin-right = 0;
            spacing = 0;
            start_hidden = true;

            modules-left = [
              # "custom/appmenu"
              "group/links"
              "group/settings"
              # "wlr/taskbar"
              "group/quicklinks"
              "hyprland/window"
              # "custom/empty"
            ];

            modules-center = [
              "hyprland/workspaces"
            ];

            modules-right = [
              # "custom/updates"
              "pulseaudio"
              "bluetooth"
              "battery"
              "network"
              "group/hardware"
              # "custom/cliphist"
              # "custom/hypridle"
              # "custom/hyprshade"
              "tray"
              # "custom/exit"
              # "custom/ml4w-welcome"
              "clock"
            ];
          };
        };

        style =
          ''
            @define-color background #282828;
            @define-color foreground #ebdbb2;
            @define-color main-color #83a598;
            @define-color color5 #d65d0e;
          ''
          + builtins.readFile ./style.css;
      };
    };
  };
}
