{
  lib,
  config,
  pkgs,
  ...
}:
lib.mkIf config.modules.desktop.hyprland.enable {
  home-manager.users.${config.user.name}.wayland.windowManager.hyprland.settings = {
    exec = [
      "${pkgs.swww}/bin/swww img ${config.modules.theme.wallpaper} --transition-step 255 --transition-fps 60 --transition-type wipe"
    ];

    monitor = [", preferred, auto, 1"];

    general = {
      layout = "dwindle";
    };

    input = {
      kb_layout = "us, us(intl)";
      kb_options = "grp:alt_shift_toggle";
      follow_mouse = 1;
      touchpad = {
        natural_scroll = true;
        disable_while_typing = true;
        drag_lock = true;
      };
      sensitivity = 0;
      float_switch_override_focus = 2;
    };

    dwindle = {
      preserve_split = true;
    };

    gestures = {
      workspace_swipe = true;
      # workspace_swipe_use_r = true; # Keeps adding empty workspaces
    };

    cursor = {
      enable_hyprcursor = true;
      hide_on_key_press = true;
      inactive_timeout = 5;
      zoom_rigid = true;
    };
  };
}
