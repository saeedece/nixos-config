{
  config,
  lib,
  pkgs,
  ...
}:
{
  nixpkgs.overlays = [
    (self: super: {
      opam = super.opam.overrideAttrs (_: rec {
        version = "2.4.0-alpha1";
        src = self.fetchurl {
          url = "https://github.com/ocaml/opam/releases/download/${version}/opam-full-${version}.tar.gz";
          sha256 = "sha256-kRGh8K5sMvmbJtSAEEPIOsim8uUUhrw11I+vVd/nnx4=";
        };
        patches = [ ./opam-shebangs.patch ];
      });
    })
  ];
  environment.systemPackages = [ pkgs.opam ];
}
