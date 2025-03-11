{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.cli.tmux;
in {
  options.modules.cli.tmux.enable = mkEnableOption "tmux";
  config = mkIf cfg.enable {
    home-manager.users.${config.user.name} = {
      programs.tmux = {
        enable = true;
        sensibleOnTop = false;
        extraConfig = "source-file ~/.config/tmux/options.conf";
        plugins = with pkgs.tmuxPlugins; [
          vim-tmux-navigator
          yank
          resurrect
          continuum
        ];
      };
      xdg.configFile = {
        "tmux" = {
          source = ../../config/tmux;
          recursive = true;
        };
      };
    };
  };
}
