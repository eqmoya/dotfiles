{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.system.hardware.thunderbolt;
in {
  options.modules.system.hardware.thunderbolt.enable = mkEnableOption "thunderbolt";
  config = mkIf cfg.enable {
    services.hardware.bolt.enable = true;
  };
}
