{ config, lib, ... }:
let
  dev = config.device;
in
lib.mkIf ((dev.type == "desktop") || (dev.type == "laptop")) {
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = false;
    dedicatedServer.openFirewall = true;
  };
}
