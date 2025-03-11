{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.system.hardware.audio;
in {
  options.modules.system.hardware.audio.enable = mkEnableOption "audio";
  config = mkIf cfg.enable {
    users.users.${config.user.name}.extraGroups = ["audio"];
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    programs.noisetorch.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };
  };
}
