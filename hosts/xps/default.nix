lib:
lib.nixosSystem (
  {
    config,
    lib,
    pkgs,
    ...
  }:
  {
    imports = [ ./hardware.nix ];

    device = {
      type = "desktop";
      gpu = "nvidia";
      hasBluetooth = true;
      hasSound = true;
    };

    networking.hostName = "xps";
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.extraModprobeConfig = ''
      options snd_hda_intel index=0 model=auto
    '';
    hardware.graphics.enable = true;

    users.users = {
      jan = {
        isNormalUser = true;
        description = "jan";
        extraGroups = [
          "wheel"
          "networkmanager"
        ];
      };
    };

    system.stateVersion = "25.05";
    home-manager = {
      useUserPackages = true;
      useGlobalPkgs = true;
      users = {
        jan = { };
      };
      sharedModules = [
        {
          home.stateVersion = "25.05";
        }
      ];
    };
  }
)
