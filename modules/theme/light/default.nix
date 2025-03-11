{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
  mkIf (!config.modules.theme.dark) {
    modules.theme = with pkgs; {
      wallpaper = ./wallpaper.png;
      colorScheme = {
        bgDark = "f9f5dc";
        bg = "fbf1c7";
        bgLight = "f2e5bc";

        fgDark = "7c6f64";
        fg = "3c3836";
        fgLight = "242424";

        gray = "ebdbb2";
        grayLight = "d5c4a1";

        red = "cc241d";
        redLight = "9d0006";

        green = "98971a";
        greenLight = "79740e";

        yellow = "d79921";
        yellowLight = "b57614";

        blue = "458588";
        blueLight = "076678";

        magenta = "b16286";
        magentaLight = "8f3f71";

        cyan = "689d6a";
        cyanLight = "427b58";

        accent = "d65d0e";
        accentLight = "af3a03";
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

