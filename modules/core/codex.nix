{ config, lib, ... }:
{
  home-manager.sharedModules = [
    {
      programs.codex = {
        enable = true;
      };
    }
  ];
}
