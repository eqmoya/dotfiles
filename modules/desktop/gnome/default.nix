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
        };

        desktopManager = {
            gnome = {
                enable = true;
            };
        };
    };

    hardware.pulseaudio.enable = false;
}