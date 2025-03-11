{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.cli.git;
in {
  options.modules.cli.git = with types;{
    enable = mkEnableOption "git";
    userName = mkOption {type = str;};
    userEmail = mkOption {type = str;};
  };

  config = mkIf cfg.enable {
    home-manager.users.${config.user.name}.programs.git = {
      enable = true;
      userName = cfg.userName;
      userEmail = cfg.userEmail;
      extraConfig = {
        core.editor = config.environment.sessionVariables.EDITOR;
        credential.helper = "store";
      };
    };
  };
}