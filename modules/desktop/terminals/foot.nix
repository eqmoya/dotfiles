{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.desktop.terminals;
  theme = config.modules.theme;
in {
  options.modules.desktop.terminals.foot.enable = mkEnableOption "foot";
  config = mkIf (cfg.foot.enable || (cfg.default == "foot")) {
    home-manager.users.${config.user.name} = {
      programs.foot.enable = true;

      xdg.configFile = with theme.colorScheme; {
        # TODO: Hardcoded path /home/enrique/...
        "foot/foot.ini".text = ''
          include=/home/enrique/.config/foot/extra.ini
          font=monospace:size=${toString (theme.fonts.mono.size - 1)}

          [colors]
          background=${bg}
          foreground=${fg}
          # flash=7f7f00

          ## Normal/regular colors (color palette 0-7)
          regular0=${bgDark}  # black
          regular1=${red}  # red
          regular2=${green}  # green
          regular3=${yellow}  # yellow
          regular4=${blue}  # blue
          regular5=${magenta}  # magenta
          regular6=${cyan}  # cyan
          regular7=${fgDark}  # white

          ## Bright colors (color palette 8-15)
          bright0=${grayLight}   # bright black
          bright1=${redLight}   # bright red
          bright2=${greenLight}   # bright green
          bright3=${yellowLight}   # bright yellow
          bright4=${blueLight}   # bright blue
          bright5=${magentaLight}   # bright magenta
          bright6=${cyanLight}   # bright cyan
          bright7=${fgLight}   # bright white

          ## Misc colors
          selection-background=${fgLight}
          selection-foreground=${bgDark}
          # jump-labels=<regular0> <regular3>          # black-on-yellow
          # scrollback-indicator=<regular0> <bright4>  # black-on-bright-blue
          # search-box-no-match=<regular0> <regular1>  # black-on-red
          # search-box-match=<regular0> <regular3>     # black-on-yellow
          # urls=<regular3>
        '';
        "foot/extra.ini".source = ../../../config/foot/foot.ini;
      };
    };
  };
}
