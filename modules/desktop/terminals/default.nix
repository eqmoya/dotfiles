{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.desktop.terminals;
in {
  options.modules.desktop.terminals = with types; {
    default = mkOption {
      type = nullOr str;
      default = null;
    };
  };

  config = mkIf (cfg.default != null) {
    environment.sessionVariables.TERMINAL = cfg.default;
  };
}
