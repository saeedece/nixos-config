{ config, lib, ... }:
{
  imports = [
    ./firefox.nix
    ./fonts.nix
    ./ghostty.nix
    ./kde.nix
    ./steam.nix
  ];
}
