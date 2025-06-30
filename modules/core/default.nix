{ config, lib, ... }:
{
  imports = [
    ./bat.nix
    ./btop.nix
    ./direnv.nix
    ./git.nix
    ./home.nix
    ./locale.nix
    ./helix.nix
    ./networking.nix
    ./nix.nix
    ./nixpkgs.nix
    ./nushell
    ./packages.nix
  ];
}
