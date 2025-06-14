{
  inputs,
  config,
  lib,
  ...
}:
let
  dev = config.device;
in
{
  nixpkgs.config = {
    allowUnfree = true;
    cudaSupport = ((dev.gpu == "nvidia") || (dev.gpu == "hybrid-nv"));
  };
  environment.etc.nixpkgs.source = inputs.nixpkgs;
}
