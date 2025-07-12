{ config, lib, ... }:
{
  home-manager.sharedModules = [
    {
      programs.btop = {
        enable = true;
        settings.vim_keys = true;
        settings.color_theme = "whiteout";
      };
    }
  ];
}
