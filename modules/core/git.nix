{
  config,
  lib,
  ...
}:
{
  programs.git.enable = true;
  home-manager.sharedModules = [
    {
      programs.git = {
        enable = true;
        userName = "saeed";
        userEmail = "git@saeedc.com";
        extraConfig = {
          init.defaultBranch = "main";
          column.ui = "auto";
          commit.verbose = 1;
          commit.gpgSign = true;

          gpg.format = "ssh";
          user.signingKey = "~/.ssh/id_ed25519.pub";
        };
      };

      programs.gh = {
        enable = true;
        settings.git_protocol = "ssh";
        hosts = {
          user = "saeedece";
        };
      };
    }
  ];
}
