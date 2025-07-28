{
  config,
  lib,
  pkgs,
  ...
}:
{
  environment.variables."EDITOR" = "hx";
  home-manager.sharedModules = [
    {
      programs.helix = {
        enable = true;
        settings = {
          theme = "modus_operandi";
          editor = {
            auto-completion = false;
            color-modes = true;
            cursorline = true;
            end-of-line-diagnostics = "disable";
            indent-guides.render = true;
            inline-diagnostics.cursor-line = "disable";
            line-number = "relative";
            lsp.snippets = false;
            soft-wrap.enable = true;
            true-color = true;
            cursor-shape = {
              insert = "bar";
              normal = "block";
              select = "underline";
            };
            file-picker = {
              hidden = false;
              ignore = true;
              git-ignore = true;
              git-exclude = false;
            };
          };
        };

        languages = {
          language = [
            {
              name = "nix";
              formatter.command = "nixfmt";
              auto-format = true;
            }

            {
              name = "python";
              language-servers = [
                "basedpyright"
                "ty"
              ];
              formatter = {
                command = "ruff";
                args = [
                  "format"
                  "--quiet"
                  "-"
                ];
              };
              auto-format = true;
            }

            {
              name = "typst";
              formatter = {
                command = "typstyle";
                args = [ "-i" ];
              };
              auto-format = true;
            }
          ];

          language-server.ty = {
            command = "ty";
            args = [ "server" ];
          };
        };
      };
    }
  ];
}
