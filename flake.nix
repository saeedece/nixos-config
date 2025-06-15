{
  description = "saeedece's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.93.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      lix-module,
      nix-index-database,
      fenix,
    }:
    let
      lib = nixpkgs.lib.extend (import ./lib inputs);
      hostConfigs = lib.pipe ./hosts [
        (builtins.readDir)
        (lib.mapAttrs (name: lib.const (import ./hosts/${name} lib)))
        (lib.attrsToList)
        (lib.groupBy ({ name, value }: "nixosConfigurations"))
        (lib.mapAttrs (lib.const lib.listToAttrs))
      ];
    in
    hostConfigs;
}
