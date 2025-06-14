{ config, lib, ... }:
{
  home-manager.sharedModules = [
    {
      programs.btop = {
        enable = true;
        settings.color_theme = "whiteout";
        settings.vim_keys = true;
      };
    }
  ];
}
