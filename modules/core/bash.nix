{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.bash.completion.enable = true;
  home-manager.sharedModules = [
    {
      programs.bash = {
        enable = true;
        enableCompletion = true;
        bashrcExtra = ''
          PS1='[\u@\h][\W]'
          if [ "$SHLVL" -gt 1 ]; then
              PS1="$PS1[*]"
          fi
          PS1="$PS1\n> "
          export LS_COLORS="$(${lib.getExe pkgs.vivid} generate modus-operandi)"
        '';
      };
    }
  ];
}
