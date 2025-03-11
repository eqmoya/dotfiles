{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.cli.shells;
  aliases = {
    grep = "grep --color";
    eza = "eza --icons --git";
    l = "eza -l";
    la = "eza -la";
    v = "nvim";
    vi = "nvim";
    vim = "nvim";
    cdf = ''target=$(fd | fzf) && [ -n "$target" ] && if [ -d "$target" ]; then cd "$target"; else cd $(dirname "$target"); fi'';
  };
in {
  options.modules.cli.shells = with types; {
    default = mkOption {
      type = nullOr package;
      default = null;
    };

    shellAliases = mkOption {
      type = attrsOf str;
      default = {};
      apply = v: v // aliases;
    };
  };

  config = mkIf (cfg.default != null) {
    environment.systemPackages = with pkgs; [
      eza
      fzf
    ];

    users.defaultUserShell = cfg.default;
  };
}
