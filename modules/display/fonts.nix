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
    libertine-g
    noto-fonts
    noto-fonts-cjk-sans
    nerd-fonts.iosevka
    nerd-fonts.jetbrains-mono
  ];
}
