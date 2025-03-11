{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.services.greetd;
in {
  options.modules.services.greetd = with types; {
    enable = mkEnableOption "greetd";
    session_cmd = mkOption {type = str;};
  };

  config = mkIf cfg.enable {
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --cmd ${cfg.session_cmd}";
          user = "greeter";
        };
      };
    };

    systemd.services.greetd.serviceConfig = {
      Type = "idle";
      StandardInput = "tty";
      StandardOutput = "tty";
      StandardError = "journal";
      TTYReset = true;
      TTYVHangup = true;
      TTYVTDisallocate = true;
    };
  };
}
