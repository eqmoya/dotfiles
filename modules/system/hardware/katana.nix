{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.system.hardware.katana;
in {
  options.modules.system.hardware.katana.enable = mkEnableOption "katana";
  config = mkIf cfg.enable {
    services.kanata = {
      enable = true;
      keyboards.default = {
        devices = [];
        extraDefCfg = "process-unmapped-keys yes";
        config = ''
          (defsrc
            esc
            caps s d f j k l
            lalt ralt
          )

          (defvar
            left-hand-keys (
              q w e r t
              a s d f g
              z x c v b
            )

            right-hand-keys (
              y u i o p
              h j k l ;
              n m , . /
            )
          )

          (deflayer base
            caps
            @caps @s @d @f @j @k @l
            lsft rsft
          )

          (deflayer nomods
            caps
            esc s d f j k l
            lsft rsft
          )

          (deflayermap (custom)
            s left
            d up
            f down
            g right

            h left
            j down
            k up
            l right
          )

          (deffakekeys
            to-base (layer-switch base)
          )

          (defalias
            tap (multi
              (layer-switch nomods)
              (on-idle-fakekey to-base tap 20)
            )

            s (tap-hold-release-keys 300 250 (multi s @tap) lalt $left-hand-keys)
            d (tap-hold-release-keys 200 150 (multi d @tap) lmet $left-hand-keys)
            f (tap-hold-release-keys 200 150 (multi f @tap) lctl $left-hand-keys)

            j (tap-hold-release-keys 200 150 (multi j @tap) rctl $right-hand-keys)
            k (tap-hold-release-keys 200 150 (multi k @tap) rmet $right-hand-keys)
            l (tap-hold-release-keys 300 250 (multi l @tap) ralt $right-hand-keys)
            caps           (tap-hold 300 250 esc (layer-while-held custom))
          )
        '';
      };
    };
  };
}
