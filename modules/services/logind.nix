{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.services.logind;
in {
  options.modules.services.logind.enable = mkEnableOption "logind";
  config = mkIf cfg.enable {
    services.logind = {
      powerKey = "lock";
      powerKeyLongPress = "poweroff";
      lidSwitch = "suspend";
      lidSwitchExternalPower = "lock";
      lidSwitchDocked = "ignore";
    };
  };
}
