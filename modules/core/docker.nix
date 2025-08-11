{ config, lib, ... }:
{
  virtualisation = {
    docker = {
      enable = false;
      enableNvidia = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
        daemon.settings = {
          dns = [
            "1.1.1.1"
            "8.8.8.8"
          ];
          registry-mirrors = [ "https://mirror.gcr.io" ];
        };
      };
    };
  };
}
