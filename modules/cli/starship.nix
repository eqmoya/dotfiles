{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.cli.starship;
in {
  options.modules.cli.starship.enable = mkEnableOption "starship";
  config = mkIf cfg.enable {
    home-manager.users.${config.user.name} = {
      programs.starship = {
        enable = true;
        # settings = {
        #   format = "$username$hostname$directory$git_branch$git_commit$git_state$git_status$cmd_duration$python$line_break$jobs$character";
        #
        #   username = {
        #     format = "[$user]($style)";
        #     show_always = true;
        #   };
        #
        #   hostname = {
        #     format = "[@](bright-black)[$hostname]($style)";
        #     style = "bold green";
        #     ssh_only = false;
        #   };
        #
        #   directory = {
        #     format = "[:](bright-black)[$path]($style)";
        #     style = "bold blue";
        #   };
        #
        #   git_branch = {
        #     format = "[ $symbol$branch](bold bright-black)";
        #     symbol = "";
        #   };
        #
        #   git_status = {
        #     format = "[[(*$conflicted$untracked$modified$staged$renamed$deleted)](bold purple) ($ahead_behind$stashed)]($style)";
        #     style = "cyan";
        #     conflicted = "​";
        #     untracked = "​";
        #     modified = "​";
        #     staged = "​";
        #     renamed = "​";
        #     deleted = "​";
        #     stashed = "≡";
        #   };
        #
        #   cmd_duration = {
        #     format = "[ $duration](bold bright-yellow)";
        #     min_time = 5000;
        #   };
        #
        #   jobs = {
        #     format = "[$symbol](bright-black) [$number]($style) ";
        #     style = "bold white";
        #     symbol = "󰣖";
        #   };
        # };
      };
      xdg.configFile = {
        "starship.toml".source = ../../config/starship/starship.toml;
      };
    };
  };
}
