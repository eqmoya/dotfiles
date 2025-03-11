{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.desktop.hyprland;
in {
  imports = [
    ./settings.nix
    ./keybinds.nix
    ./rules.nix
    ./startup_apps.nix
    ./style.nix
  ];

  options.modules.desktop.hyprland = {
    enable = mkEnableOption "hyprland";
    extraConfig = mkOption {
      type = types.str;
    };
  };

  config = mkIf cfg.enable {
    users.users.${config.user.name}.extraGroups = ["video"];
    environment.sessionVariables.NIXOS_OZONE_WL = "1"; # Hint electron apps to use wayland.
    environment.systemPackages = with pkgs; [
      swww
      jaq
      grimblast
    ];

    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
      ];
    };

    programs.hyprland.enable = true;

    home-manager.users.${config.user.name}.wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = true;
      xwayland.enable = true;
      extraConfig = cfg.extraConfig;
      plugins = [
      ];
    };
  };
}
