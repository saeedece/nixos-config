{ config, lib, ... }:
{
  home-manager.sharedModules = [
    {
      manual.manpages.enable = true;
      services.mpris-proxy.enable = true;
      systemd.user.startServices = "sd-switch";
      xdg = {
        enable = true;
        mime.enable = true;
        userDirs = {
          enable = true;
          createDirectories = true;
        };
      };
    }
  ];
}
