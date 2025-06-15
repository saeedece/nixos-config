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
    ./ocaml
    ./packages.nix
    ./rust.nix
  ];
}
