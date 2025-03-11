{
  config,
  pkgs,
  ...
}: {
  home-manager.users.${config.user.name}.wayland.windowManager.hyprland.settings = {
    exec-once = [
      # TODO: Check if newer swww-daemon fixes scaled black monitor. current 0.9.5
      "${pkgs.swww}/bin/swww init"
    ];
  };
}
