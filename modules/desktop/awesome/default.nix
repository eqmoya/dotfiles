{
    programs.dconf.enable = true;

    services.xserver = {
        enable = true;

        layout = "us";
        xkbVariant = "altgr-intl";

        displayManager = {
            gdm = {
                enable = true;
            };

            defaultSession = "none+awesome";
        };

        windowManager = {
            awesome = {
                enable = true;
            };
        };
    };
}