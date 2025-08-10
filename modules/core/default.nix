{ config, lib, ... }:
{
  imports = [
    ./bash.nix
    ./bat.nix
    ./btop.nix
    ./codex.nix
    ./docker.nix
    ./git.nix
    ./home.nix
    ./locale.nix
    ./helix.nix
    ./networking.nix
    ./nix.nix
    ./nixpkgs.nix
    ./packages.nix
  ];
}
