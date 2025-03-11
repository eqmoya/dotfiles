{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.editors;
in {
  options.modules.editors = with types; {
    default = mkOption {
      type = nullOr str;
      default = null;
    };
  };

  config = mkIf (cfg.default != null) {
    environment.sessionVariables = {
      EDITOR = cfg.default;
      VISUAL = cfg.default;
    };

    environment.systemPackages = with pkgs; [
      nixd
      alejandra
      curl
      wget
      cargo
      # tree-sitter
      # lua-language-server
      # stylua
    ];
  };
}
