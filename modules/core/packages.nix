{
  config,
  lib,
  pkgs,
  ...
}:
let
  dev = config.device;
in
{
  programs.command-not-found.enable = false;
  environment.systemPackages =
    with pkgs;
    [
      age
      curl
      fd
      fzf
      hyperfine
      nil
      nixfmt-rfc-style
      ripgrep
      rsync
      tokei
      tree
      uv
    ]
    ++ (lib.optional (dev.hasSound) pavucontrol)
    ++ (lib.optionals (dev.type == "laptop" || dev.type == "desktop") [
      discord
      drawio
      foliate
      kdePackages.kolourpaint
      keepassxc
      mgba
    ]);
}
