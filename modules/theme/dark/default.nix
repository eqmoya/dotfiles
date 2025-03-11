{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
  mkIf config.modules.theme.dark {
    modules.theme = with pkgs; {
      wallpaper = ./wallpaper.png;
      colorScheme = {
        bgDark = "242424";
        bg = "282828";
        bgLight = "32302f";

        fgDark = "a89984";
        fg = "ebdbb2";
        fgLight = "f9f5d7";

        gray = "504945";
        grayLight = "665c54";

        red = "cc241d";
        redLight = "fb4934";

        green = "98971a";
        greenLight = "b8bb26";

        yellow = "d79921";
        yellowLight = "fabd2f";

        blue = "458588";
        blueLight = "83a598";

        magenta = "b16286";
        magentaLight = "d3869b";

        cyan = "689d6a";
        cyanLight = "8ec07c";

        accent = "d65d0e";
        accentLight = "fe8019";
      };

      gtk = {
        theme = {
          name = "Adwaita";
          package = gnome.adwaita-icon-theme;
        };

        iconTheme = {
          name = "Adwaita";
          package = gnome.adwaita-icon-theme;
        };

        cursorTheme = {
          name = "Adwaita";
          size = 24;
          package = gnome.adwaita-icon-theme;
        };
      };

      fonts = {
        sans = {
          name = "Fira Sans";
          size = 12;
          package = fira;
        };

        serif = {
          name = "Garamond Libre";
          size = 12;
          package = garamond-libre;
        };

        mono = {
          name = "JetBrainsMonoNL Nerd Font";
          size = 12;
          package = nerdfonts.override {fonts = ["JetBrainsMono"];};
        };
      };
    };
  }

