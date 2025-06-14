{ config, lib, ... }:
let
  inherit (lib.options) mkOption;
  inherit (lib.types) nullOr enum bool;
in
{
  options.device = {
    type = mkOption {
      type = enum [
        "laptop"
        "desktop"
        "server"
      ];
      default = "desktop";
    };

    gpu = mkOption {
      type = nullOr (enum [
        "amd"
        "nvidia"
        "hybrid-nv"
      ]);
      default = null;
    };

    hasBluetooth = mkOption {
      type = bool;
      default = true;
    };

    hasSound = mkOption {
      type = bool;
      default = true;
    };
  };
}
