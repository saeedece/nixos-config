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
      type = "laptop";
      gpu = "hybrid-nv";
      hasBluetooth = true;
      hasSound = true;
    };

    networking.hostName = "rbs";
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    hardware.graphics.enable = true;
    hardware.nvidia.prime = {
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:2:0:0";
    };

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

    system.stateVersion = "24.05";
    home-manager = {
      useUserPackages = true;
      useGlobalPkgs = true;
      users = {
        jan = { };
      };
      sharedModules = [
        {
          home.stateVersion = "24.05";
        }
      ];
    };
  }
)
