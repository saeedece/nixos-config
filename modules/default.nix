{ config, lib, ... }:
{
  imports = [
    ./core
    ./display
    ./hardware
    ./options.nix
  ];
}
