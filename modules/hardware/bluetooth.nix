{ config, lib, ... }:
let
  dev = config.device;
in
lib.mkIf (dev.hasBluetooth) {
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
}
