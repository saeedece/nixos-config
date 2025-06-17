{
  config,
  lib,
  pkgs,
  ...
}:
let
  dev = config.device;
in
lib.mkIf ((dev.type == "desktop") || (dev.type == "laptop")) {
  fonts.packages = with pkgs; [
    dejavu_fonts
    libertinus
    noto-fonts
    noto-fonts-cjk-sans
    nerd-fonts.jetbrains-mono
  ];
}
