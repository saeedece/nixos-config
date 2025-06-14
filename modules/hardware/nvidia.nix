{
  config,
  lib,
  pkgs,
  ...
}:
let
  dev = config.device;
in
lib.mkIf ((dev.gpu == "nvidia") || (dev.gpu == "hybrid-nv")) {
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
    prime = lib.mkIf (dev.gpu == "hybrid-nv") {
      offload.enable = true;
      offload.enableOffloadCmd = true;
    };
  };
  services.xserver.videoDrivers = [ "nvidia" ];
}
