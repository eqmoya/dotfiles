{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.system.hardware.bluetooth;
in {
  options.modules.system.hardware.bluetooth.enable = mkEnableOption "bluetooth";
  config = mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings.General.Experimental = true;
    };
  };
}
