{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myHome.zed-editor;
in
{
  options.myHome.zed-editor = {
    enable = lib.mkEnableOption "Enable Zed editor";
  };

  config = lib.mkIf cfg.enable {
    # https://mynixos.com/home-manager/options/programs.zed-editor
    programs.zed-editor = {
      enable = true;
      extensions = [
        "nix"
        "catppuccin"
        "catppuccin-icons"
      ];
      userSettings = {
        features = {
          copilot = true;
        };
        telemetry = {
          metrics = false;
        };
        #theme = "Catppuccin Mocha";
        vim_mode = false;
        #ui_font_size = 16;
        #buffer_font_size = 16;
        # https://github.com/zed-extensions/nix

        languages = {
          Nix = {
            language_servers = [
              "nixd"
              "!nil"
            ];
          };
        };

        lsp = {
          nixd = {
            settings = {
              diagnostic = {
                suppress = [ "sema-extra-with" ];
              };
            };

            initialization_options = {
              formatting = {
                command = [ "nixfmt" ];
              };

              options = {
                nixos = {
                  expr = "(builtins.getFlake \"/home/tyron/nixos-config\").nixosConfigurations.yoga.options";
                };
                home-manager = {
                  expr = "(builtins.getFlake \"/home/tyron/nixos-config\").homeConfigurations.\"tyron@yoga\".options";
                };
              };

            };
          };

        };
      };

    };
  };
}
