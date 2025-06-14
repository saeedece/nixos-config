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
      basedpyright
      clang
      curl
      fd
      fzf
      nil
      nixfmt-rfc-style
      ripgrep
      rsync
      ruff
      sops
      tinymist
      tokei
      tree
      typst
      typstyle
      uv
    ]
    ++ (lib.optional (dev.hasSound) pavucontrol)
    ++ (lib.optionals (dev.type == "laptop" || dev.type == "desktop") [
      discord
      drawio
      foliate
      keepassxc
      kdePackages.kolourpaint
      mgba
      obsidian
    ]);
}
