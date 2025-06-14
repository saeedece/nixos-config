{ config, lib, ... }:
let
  dev = config.device;
in
lib.mkIf (dev.hasSound) {
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
