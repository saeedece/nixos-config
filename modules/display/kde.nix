{
  config,
  lib,
  pkgs,
  ...
}:
let
  dev = config.device;
in
lib.mkIf ((dev.type == "desktop") || (dev.type == "laptop")) {
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.sddm.settings.General.DisplayServer = "wayland";
  services.desktopManager.plasma6.enable = true;

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
    konsole
  ];
}
