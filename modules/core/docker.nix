{ config, lib, ... }:
{
  virtualisation = {
    docker = {
      enable = false;
      enableNvidia = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
  };
}
