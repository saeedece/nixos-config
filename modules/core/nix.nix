{
  config,
  lib,
  pkgs,
  ...
}:
{
  nix.channel.enable = false;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    persistent = true;
  };
  nix.nixPath = [ "nixpkgs=/etc/nixpkgs" ];
  nix.optimise.automatic = true;
  nix.settings.substituters = [
    "https://cuda-maintainers.cachix.org"
    "https://nix-community.cachix.org"
  ];
  nix.settings.trusted-public-keys = [
    "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
  ];
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  programs.nix-ld.enable = true;

  environment.systemPackages = with pkgs; [
    nh
    nix-output-monitor
  ];
}
