inputs: self: super:
let
  modules = [
    inputs.home-manager.nixosModules.home-manager
    inputs.lix-module.nixosModules.default
    inputs.nix-index-database.nixosModules.nix-index
    ../modules
  ];
  specialArgs = { inherit inputs; };
in
{
  nixosSystem =
    hostModule:
    super.nixosSystem {
      inherit specialArgs;
      modules = [ hostModule ] ++ modules;
    };
}
