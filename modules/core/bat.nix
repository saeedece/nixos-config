{ config, lib, ... }:
{
  home-manager.sharedModules = [
    {
      programs.bat = {
        enable = true;
        config.theme = "ansi";
      };
    }
  ];
}
