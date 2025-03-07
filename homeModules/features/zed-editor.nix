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
    home.packages = with pkgs; [
      python3 # Needed for JDTLS
      #cargo
      #rustc
      #rust-analyzer
      #rustfmt
      gcc # For rustup
    ];
    # https://mynixos.com/home-manager/options/programs.zed-editor
    # https://github.com/nathansbradshaw/zed-angular
    programs.zed-editor = {
      enable = true;
      extensions = [
        "nix"
        "catppuccin"
        "catppuccin-icons"
        "java"
        "html"
        "scss"
        "toml"
        "git-firefly"
      ];
      userKeymaps = [
        {
          context = "Workspace";
          bindings = {
            "shift shift" = "file_finder::Toggle";
          };
        }
      ];

      #https://zed.dev/docs/configuring-zed#direnv-integration
      userSettings = {
        load_direnv = "shell_hook";
        assistant = {
          version = "2";
          enabled = true;
          default_model = {
            provider = "openai";
            model = "gpt-4o-mini";
          };
        };
        features = {
          copilot = true;
        };
        telemetry = {
          metrics = false;
        };
        theme = lib.mkForce "Catppuccin Mocha";
        icon_theme = {
          mode = "system";
          light = "Catppuccin Latte";
          dark = "Catppuccin Mocha";
        };

        vim_mode = false;
        #ui_font_size = 16;
        #buffer_font_size = 16;
        # https://github.com/zed-extensions/nix

        languages = {
          TypeScript = {
            language_servers = [
              "angular"
              "..."
            ];
          };
          HTML = {
            language_servers = [
              "angular"
              "..."
            ];
          };
          Nix = {
            language_servers = [
              "nixd"
              "!nil"
            ];
          };
          Java = {
            language_servers = [
              "jdtls"
            ];
            initialization_options = {
              bundles = [ ];
              #workspaceFolders = [ "file:///home/snjeza/Project" ];
              settings = {
                java = {
                  #home = "/usr/local/jdk-9.0.1";
                  errors = {
                    incompleteClasspath = {
                      severity = "warning";
                    };
                  };
                  configuration = {
                    updateBuildConfiguration = "interactive";
                    maven = {
                      userSettings = null;
                    };
                  };
                  trace = {
                    server = "verbose";
                  };
                  import = {
                    gradle = {
                      enabled = true;
                    };
                    maven = {
                      enabled = true;
                    };
                    exclusions = [
                      "**/node_modules/**"
                      "**/.metadata/**"
                      "**/archetype-resources/**"
                      "**/META-INF/maven/**"
                      "/**/test/**"
                    ];
                  };
                  jdt = {
                    ls = {
                      lombokSupport = {
                        enabled = false; # Change to true to enable Lombok support
                      };
                    };
                  };
                  referencesCodeLens = {
                    enabled = false;
                  };
                  signatureHelp = {
                    enabled = true;
                  };
                  implementationsCodeLens = {
                    enabled = false;
                  };
                  format = {
                    enabled = true;
                  };
                  saveActions = {
                    organizeImports = false;
                  };
                  contentProvider = {
                    preferred = null;
                  };
                  autobuild = {
                    enabled = false;
                  };
                  completion = {
                    favoriteStaticMembers = [
                      "org.junit.Assert.*"
                      "org.junit.Assume.*"
                      "org.junit.jupiter.api.Assertions.*"
                      "org.junit.jupiter.api.Assumptions.*"
                      "org.junit.jupiter.api.DynamicContainer.*"
                      "org.junit.jupiter.api.DynamicTest.*"
                    ];
                    importOrder = [
                      "java"
                      "javax"
                      "com"
                      "org"
                    ];
                  };
                };
              };
            };
          };
        };

        lsp = {
          nixd = {
            settings = {
              diagnostic = {
                suppress = [ "sema-extra-with" ];
              };

              nixpkgs = {
                expr = "import <nixpkgs> { }";
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

            initialization_options = {
              formatting = {
                command = [ "nixfmt" ];
              };

            };
          };

        };
      };

    };
  };
}
