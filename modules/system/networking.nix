{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.system.networking;
in {
  options.modules.system.networking = with types; {
    hostName = mkOption {
      type = nullOr str;
      default = null;
    };
  };

  config = mkIf (cfg.hostName != null) {
    users.users.${config.user.name}.extraGroups = ["networkmanager"];
    networking = {
      hostName = cfg.hostName;
      networkmanager.enable = true;
    };
  };
}
