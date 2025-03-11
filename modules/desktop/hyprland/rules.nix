{config, ...}: {
  home-manager.users.${config.user.name}.wayland.windowManager.hyprland.settings = {
    windowrule = [
    ];
    windowrulev2 = [
      "rounding 10, floating:1"
      "bordersize 1, floating:1"
      "noshadow, floating:0"
    ];
    layerrule = [
      "blur, wofi"
      "ignorezero, wofi"
    ];
  };
}
