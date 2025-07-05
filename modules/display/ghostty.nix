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
  home-manager.sharedModules = [
    {
      programs.ghostty = {
        enable = true;
        settings = {
          theme = "modus_vivendi";
          command = lib.getExe pkgs.nushell;
          font-size = 11;
          font-feature = "-calt";
          shell-integration-features = "no-cursor";
          window-theme = "ghostty";
          window-decoration = "auto";
        };
        themes = {
          "modus_operandi" = {
            background = "#ffffff";
            cursor-color = "#000000";
            foreground = "#000000";
            palette = [
              "0=#000000"
              "1=#a60000"
              "2=#006800"
              "3=#6f5500"
              "4=#0031a9"
              "5=#721045"
              "6=#00538b"
              "7=#c4c4c4"
              "8=#585858"
              "9=#972500"
              "10=#316500"
              "11=#884900"
              "12=#354fcf"
              "13=#531ab6"
              "14=#005a5f"
              "15=#595959"
            ];
            selection-background = "#bcbcbc";
            selection-foreground = "#000000";
          };
          "modus_vivendi" = {
            background = "#000000";
            foreground = "#ffffff";
            selection-background = "#5a5a5a";
            selection-foreground = "#ffffff";
            cursor-color = "#ffffff";

            palette = [
              "0=#1e1e1e"
              "1=#ff5f59"
              "2=#44bc44"
              "3=#d0bc00"
              "4=#2fafff"
              "5=#feacd0"
              "6=#00d3d0"
              "7=#ffffff"
              "8=#535353"
              "9=#ff7f9f"
              "10=#00c06f"
              "11=#dfaf7a"
              "12=#00bcff"
              "13=#b6a0ff"
              "14=#6ae4b9"
              "15=#989898"
            ];
          };
        };
      };
    }
  ];
}
