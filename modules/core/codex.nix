{ config, lib, ... }:
{
  home-manager.sharedModules = [
    {
      home.sessionVariables = {
        "CODEX_HOME" = "$HOME/.config/codex";
      };
      programs.codex = {
        enable = true;
      };
    }
  ];
}
