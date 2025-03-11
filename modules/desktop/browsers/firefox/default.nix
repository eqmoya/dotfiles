{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.desktop.browsers;
in {
  options.modules.desktop.browsers.firefox.enable = mkEnableOption "firefox";
  config = mkIf (cfg.firefox.enable || (cfg.default == "firefox")) {
    # home.file."shyfox" = {
    #   target = ".mozilla/firefox/default/chrome/shyfox";
    #   source = inputs.shyfox;
    # };

    home-manager.users.${config.user.name}.programs.firefox = {
      enable = true;
      profiles.default = {
        name = "Default";
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          bitwarden
          darkreader
          languagetool
          sidebery
          vimium
        ];
        settings = {
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "svg.context-properties.content.enabled" = true;
          "layout.css.has-selector.enabled" = true;
          "widget.gtk.rounded-bottom-corners.enabled" = true;
          "widget.gtk.ignore-bogus-leave-notify" = 1;
          "browser.urlbar.suggest.calculator" = true;
          "browser.urlbar.unitConversion.enabled" = true;
          "browser.urlbar.trimHttps" = false;
          "browser.urlbar.trimURLs" = false;
          "extensions.pocket.enabled" = false;
          "browser.startup.page" = 3;
          "browser.sessionstore.resume_from_crash" = true;
          "browser.newtabpage.enabled" = false;
          "signon.rememberSignons" = false;
          "intl.accept_languages" = "en-us,en,es";

          "font.default.x-western" = "sans-serif";
          "font.name.serif.x-western" = concatStringsSep ", " config.fonts.fontconfig.defaultFonts.serif;
          "font.name.sans-serif.x-western" = concatStringsSep ", " config.fonts.fontconfig.defaultFonts.sansSerif;
          "font.name.monospace.x-western" = concatStringsSep ", " config.fonts.fontconfig.defaultFonts.monospace;
        };
        userChrome = ''
          :root{
            --uc-autohide-toolbox-delay: 200ms; /* Wait 0.1s before hiding toolbars */
            --uc-toolbox-rotation: 82deg;  /* This may need to be lower on mac - like 75 or so */
          }

          :root[sizemode="maximized"]{
            --uc-toolbox-rotation: 88.5deg;
          }

          @media  (-moz-platform: windows){
            :root:not([lwtheme]) #navigator-toolbox{ background-color: -moz-dialog !important; }
          }

          :root[sizemode="fullscreen"],
          :root[sizemode="fullscreen"] #navigator-toolbox{ margin-top: 0 !important; }

          #navigator-toolbox{
            position: fixed !important;
            display: block;
            background-color: var(--lwt-accent-color,black) !important;
            transition: transform 82ms linear, opacity 82ms linear !important;
            transition-delay: var(--uc-autohide-toolbox-delay) !important;
            transform-origin: top;
            transform: rotateX(var(--uc-toolbox-rotation));
            opacity: 0;
            line-height: 0;
            z-index: 1;
            pointer-events: none;
          }

          #navigator-toolbox:hover,
          #navigator-toolbox:focus-within{
            transition-delay: 33ms !important;
            transform: rotateX(0);
            opacity: 1;
          }
          /* This ruleset is separate, because not having :has support breaks other selectors as well */
          #mainPopupSet:has(> #appMenu-popup:hover) ~ toolbox{
            transition-delay: 33ms !important;
            transform: rotateX(0);
            opacity: 1;
          }

          #navigator-toolbox > *{ line-height: normal; pointer-events: auto }

          #navigator-toolbox,
          #navigator-toolbox > *{
            width: 100vw;
            -moz-appearance: none !important;
          }

          /* These two exist for oneliner compatibility */
          #nav-bar{ width: var(--uc-navigationbar-width,100vw) }
          #TabsToolbar{ width: calc(100vw - var(--uc-navigationbar-width,0px)) }

          /* Don't apply transform before window has been fully created */
          :root:not([sessionrestored]) #navigator-toolbox{ transform:none !important }

          :root[customizing] #navigator-toolbox{
            position: relative !important;
            transform: none !important;
            opacity: 1 !important;
          }

          #navigator-toolbox[inFullscreen] > #PersonalToolbar,
          #PersonalToolbar[collapsed="true"]{ display: none }

          /* Uncomment this if tabs toolbar is hidden with hide_tabs_toolbar.css */
           /*#titlebar{ margin-bottom: -9px }*/

          /* Uncomment the following for compatibility with tabs_on_bottom.css - this isn't well tested though */
          /*
          #navigator-toolbox{ flex-direction: column; display: flex; }
          #titlebar{ order: 2 }
          */
        '';
        # userContent = ''
        #   @import "shyfox/chrome/userContent.css";
        # '';
      };
    };
  };
}
