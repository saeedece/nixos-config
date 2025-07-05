{
  config,
  lib,
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    fish
    zoxide
  ];

  home-manager.sharedModules = [
    {
      xdg.configFile = {
        "nushell/zoxide.nu".source = pkgs.runCommand "zoxide.nu" { } ''
          ${lib.getExe pkgs.zoxide} init nushell --cmd cd > $out
        '';

        "nushell/starship.nu".source = pkgs.runCommand "starship.nu" { } ''
          ${lib.getExe pkgs.starship} init nu > $out
        '';
      };

      programs.starship = {
        enable = true;
        enableNushellIntegration = false;
        settings = {
          command_timeout = 100;
          scan_timeout = 20;
          character.error_symbol = "[➜](bold red)";
          character.success_symbol = "[➜](bold green)";
        };
      };

      programs.nushell = {
        enable = true;
        configFile.text = lib.readFile ./config.nu;
        envFile.text = lib.readFile ./env.nu;
      };
    }
  ];
}
