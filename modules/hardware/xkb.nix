{ config, lib, ... }:
{
  services.xserver.xkb = {
    layout = "us";
    variant = "";
    options = "ctrl:nocaps";
  };
  console.useXkbConfig = true;
}
