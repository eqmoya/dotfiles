{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.user;
in {
  options.user = with types; {
    name = mkOption {type = str;};
  };

  config = {
    users.users.${cfg.name} = {
      isNormalUser = true;
      initialPassword = "password";
      extraGroups = ["wheel"];
    };
  };
}
