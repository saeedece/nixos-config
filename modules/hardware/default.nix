{ config, lib, ... }:
{
  imports = [
    ./bluetooth.nix
    ./nvidia.nix
    ./pipewire.nix
    ./touchpad.nix
    ./xkb.nix
  ];
}
