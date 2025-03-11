{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  workspaces = builtins.concatLists (builtins.genList (
      x: let
        ws = let
          c = (x + 1) / 10;
        in
          builtins.toString (x + 1 - (c * 10));
      in [
        "$mod, ${ws}, workspace, ${toString (x + 1)}"
        "$mod SHIFT, ${ws}, movetoworkspacesilent, ${toString (x + 1)}"
      ]
    )
    10);

  directions = rec {
    left = "l";
    right = "r";
    up = "u";
    down = "d";
    h = left;
    l = right;
    k = up;
    j = down;
  };

  grimblast = getExe pkgs.grimblast;
  tesseract = getExe pkgs.tesseract;
  anyrun = getExe pkgs.anyrun;
  notify-send = getExe' pkgs.libnotify "notify-send";
  terminal = config.environment.sessionVariables.TERMINAL;
in {
  home-manager.users.${config.user.name}.wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";

    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
      "$mod ALT, mouse:272, resizewindow"
    ];

    "$kw" = "dwindle:no_gaps_when_only";

    bind =
      [
        "$mod, Space, exec, wofi -S run"
        # "$mod, SUPER_L, exec, hyprctl keyword $kw $(($(hyprctl getoption $kw -j | jaq -r '.int') ^ 1))"
        "$mod, B, exec, pkill -SIGUSR1 waybar"
        "$mod, Return, exec, ${terminal} -1" # TODO: kitty (-1)
        "$mod, Escape, exec, wlogout -p layer-shell"
        "$mod, L, exec, pgrep hyprlock || hyprlock"
        "$mod, I, exec, pgrep hyprlock || hyprlock"
        "$mod, O, exec, ${grimblast} --freeze save area - | ${tesseract} - - | wl-copy && ${notify-send} -t 3000 'OCR result copied to buffer'"
        ", XF86Calculator, exec, gnome-calculator"
        "$mod, G, exec, XDG_CURRENT_DESKTOP=gnome gnome-control-center"
        ", Print, exec, ${grimblast} --notify --freeze copysave area"
        "$mod, P, exec, ${grimblast} --notify --freeze copysave area"
        "CTRL, Print, exec, ${grimblast} --notify --freeze copysave output"
        "$mod CTRL, P, exec, ${grimblast} --notify --freeze copysave output"
        "SHIFT, Print, exec, ${grimblast} --notify --freeze copysave screen"
        "$mod SHIFT, P, exec, ${grimblast} --notify --freeze copysave screen"
        "$mod SHIFT, E, exec, pkill Hyprland"
        "$mod, Q, killactive,"
        "$mod, F, fullscreen, 1"
        "$mod, T, togglefloating,"
        "$mod, grave, workspace, previous"
        "$mod SHIFT, grave, workspace, next"
        "$mod, apostrophe, workspace, previous"
        "$mod SHIFT, apostrophe, workspace, next"
        "$mod SHIFT, u, movetoworkspacesilent, special"
        "$mod, u, togglespecialworkspace"
      ]
      ++ workspaces
      ++ (mapAttrsToList (
          key: direction: "$mod, ${key}, movefocus, ${direction}"
        )
        directions)
      ++ (mapAttrsToList (
          key: direction: "$mod SHIFT, ${key}, swapwindow, ${direction}"
        )
        directions)
      ++ (mapAttrsToList (
          key: direction: "$mod CONTROL, ${key}, movewindoworgroup, ${direction}"
        )
        directions)
      ++ (mapAttrsToList (
          key: direction: "$mod ALT, ${key}, focusmonitor, ${direction}"
        )
        directions)
      ++ (mapAttrsToList (
          key: direction: "$mod ALT SHIFT, ${key}, movecurrentworkspacetomonitor, ${direction}"
        )
        directions);

    bindl = [
      ", XF86AudioPlay, exec, playerctl play-pause"
      ", XF86AudioPrev, exec, playerctl previous"
      ", XF86AudioNext, exec, playerctl next"
      ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      "$mod, v, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ 0"
    ];

    bindlr = [
      "$mod, v, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ 1"
    ];

    bindle = [
      ", XF86AudioRaiseVolume, exec, wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 6%+"
      ", XF86AudioLowerVolume, exec, wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 6%-"
      ", XF86MonBrightnessUp, exec, brillo -q -u 300000 -A 5"
      ", XF86MonBrightnessDown, exec, brillo -q -u 300000 -U 5"
    ];
  };
}
