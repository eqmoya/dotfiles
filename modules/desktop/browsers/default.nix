{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.desktop.browsers;
in {
  options.modules.desktop.browsers = with types; {
    default = mkOption {
      type = nullOr str;
      default = null;
    };
  };

  config = mkIf (cfg.default != null) {
    environment.sessionVariables.BROWSER = cfg.default;
  };
}
