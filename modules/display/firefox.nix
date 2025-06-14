{
  config,
  lib,
  ...
}:
let
  dev = config.device;
in
lib.mkIf ((dev.type == "desktop") || (dev.type == "laptop")) {
  home-manager.sharedModules = [
    {
      programs.firefox = {
        enable = true;
        policies = {
          DisableFirefoxStudies = true;
          DisablePocket = true;
          DisableTelemetry = true;
          DontCheckDefaultBrowser = true;
          DisableFeedbackCommands = true;
          DisableFormHistory = true;
        };
      };
    }
  ];
}
