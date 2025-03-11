{
  lib,
  config,
  pkgs,
  ...
}: let
  theme = config.modules.theme;
in
  lib.mkIf config.modules.desktop.hyprland.enable {
    home-manager.users.${config.user.name}.wayland.windowManager.hyprland.settings = with theme.colorScheme; {
      env = with theme.gtk.cursorTheme; [
        "QT_WAYLAND_DISABLE_WINDOWDECORATION, 1"
        "HYPRCURSOR_THEME, ${name}"
        "HYPRCURSOR_SIZE, ${toString size}"
      ];

      general = {
        border_size = 0;
        "col.active_border" = "0xc8${bg} 0xc8${bgDark}";
        "col.inactive_border" = "0xc8${bgDark}";
        gaps_in = 0;
        gaps_out = 0;
      };

      misc = {
        disable_hyprland_logo = true;
        background_color = "0xff${bg}";
      };

      decoration = {
        rounding = 0;

        active_opacity = 1.0;
        inactive_opacity = 0.98;
        fullscreen_opacity = 1.0;

        dim_inactive = true;
        dim_strength = 0.2;
        dim_special = 0.4;

        drop_shadow = true;
        shadow_range = 40;
        shadow_render_power = 4;
        shadow_scale = 0.98;
        shadow_offset = "0 12";
        "col.shadow" = "rgba(00000060)";
        "col.shadow_inactive" = "rgba(00000040)";

        blur = {
          enabled = false;
          new_optimizations = "on";
          popups = true;
          size = 1;
          passes = 1;
          ignore_opacity = true;
        };
      };

      animations = {
        enabled = "yes";
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 2, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "fade, 1, 7, default"
          "workspaces, 1, 4, default"
          "specialWorkspace, 1, 3, default, slidefadevert -80%"
        ];
      };
    };
  }
