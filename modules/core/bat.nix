{ config, lib, ... }:
{
  home-manager.sharedModules = [
    {
      programs.bat = {
        enable = true;
      };
    }
  ];
}
