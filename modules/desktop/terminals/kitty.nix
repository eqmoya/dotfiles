{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.desktop.terminals;
  colorScheme = config.modules.theme.colorScheme;
in {
  options.modules.desktop.terminals.kitty.enable = mkEnableOption "kitty";
  config = mkIf (cfg.kitty.enable || (cfg.default == "kitty")) {
    home-manager.users.${config.user.name}.programs.kitty = {
      enable = true;
      package = pkgs.unstable.kitty;
      font = {
        name = config.modules.theme.fonts.mono.name;
        size = config.modules.theme.fonts.mono.size - 1;
      };

      keybindings = {
      };

      theme = "Gruvbox Dark";
      settings = with colorScheme; {
        editor = config.environment.sessionVariables.EDITOR;
        text_composition_strategy = "legacy";
        bold_font = "auto";
        italic_font = "auto";
        bold_italic_font = "auto";
        enable_audio_bell = false;
        cursor_blink_interval = 0;
        confirm_os_window_close = 0;
        scrollback_lines = 10000;
        scrollback_pager_history_size = 100000;
        window_margin_width = 0;
        window_padding_width = 0;
        allow_remote_control = "socket-only";
        listen_on = "unix:/tmp/kitty";
      };
    };
  };
}
