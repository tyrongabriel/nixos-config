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
      gitlab-ci-ls # Language server for the gitlab ci
      gcc # For rustup
    ];
    # https://mynixos.com/home-manager/options/programs.zed-editor
    # https://github.com/nathansbradshaw/zed-angular
    programs.zed-editor = {
      enable = true;
      extensions = [
        "justfile"
        "ini"
        "nix"
        "dockerfile"
        "ruff"
        "catppuccin"
        "catppuccin-icons"
        "java"
        "log"
        "sql"
        "html"
        "scss"
        "toml"
        "git-firefly"
        "xml"
        "gitlab-ci-ls"
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
            #provider = "openai";
            #model = "gpt-4o-mini";
            provider = "copilot_chat";
            model = "o3-mini";
          };
        };

        language_models = {
          google = {
            available_models = [
              {
                name = "gemini-2.0-flash-latest";
                display_name = "Gemini 2.0 Flash (Latest-Custom)";
                max_tokens = 1000000;
              }
            ];
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
            formatter = {
              external = {
                command = "nixfmt";
              };
            };
          };
        };
        inlay_hints = {
          enabled = true;
        };
        diagnostics = {
          include_warnings = true;
          inline = {
            enabled = true;
            update_debounce_ms = 150;
            padding = 4;
            min_column = 0;
            max_severity = null;
          };
        };
        lsp = {
          jdtls = {
            initialization_options = {
              bundles = [ ];
              settings = {
                java = {
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
                        enabled = false; # Set this to true to enable lombok support
                      };
                    };
                  };
                  referencesCodeLens = {
                    enabled = false;
                  };
                  signatureHelp = {
                    enabled = false;
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
          nixd = {
            settings = {
              diagnostic = {
                suppress = [ "sema-extra-with" ];
              };

              nixpkgs = {
                expr = "import <nixpkgs> { }";
              };

              options = {
                # nixos = {
                #   expr = "(builtins.getFlake \"/home/tyron/nixos-config\").nixosConfigurations.yoga.options";
                # };
                # home-manager = {
                #   expr = "(builtins.getFlake \"/home/tyron/nixos-config\").homeConfigurations.\"tyron@yoga\".options";
                # };
                home-manager = {
                  #"expr": "(builtins.getFlake \"/home/tyron/tynix\").nixosConfigurations.\"testvm\".options.home-manager.users.type.getSubOptions []"
                  expr = "((myFlake: builtins.foldl' (acc: cfgName: acc // (myFlake.nixosConfigurations.\"\${cfgName}\".options or {})) {} (builtins.attrNames myFlake.nixosConfigurations)) (builtins.getFlake \"/home/tyron/nixos-config\")).home-manager.users.type.getSubOptions []";
                };
                nixos = {
                  #"expr": "(builtins.getFlake \"/home/tyron/tynix\").nixosConfigurations.\"testvm\".options"
                  expr = "(myFlake: builtins.foldl' (acc: cfgName: acc // (myFlake.nixosConfigurations.\"\${cfgName}\".options or {})) {} (builtins.attrNames myFlake.nixosConfigurations)) (builtins.getFlake \"/home/tyron/nixos-config\")";
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

    # Activation hook: if the managed zed settings file is a symlink,
    # remove it and copy its contents (so that it becomes writable).
    # The file created by home-manager is placed at ~/.config/zed/settings.json.
    # Activation hook: adjust the zed settings file so that it's not a symlink.
    # This block runs after the writeBoundary and uses the provided run and verboseEcho functions.
    home.activation.testScript = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      echo "Starting to move the settings.json file to a writable file"
      ls -l $HOME/.config/zed/
      echo "Now copying the settings.json file to a writable file"
      run cp $HOME/.config/zed/settings.json $HOME/.config/zed/settings.json.tmp
      run rm $HOME/.config/zed/settings.json -f
      run cp $HOME/.config/zed/settings.json.tmp $HOME/.config/zed/settings.json
      run rm $HOME/.config/zed/settings.json.tmp -f
      run rm $HOME/.config/zed/settings.json.bak -f
      run chmod +w $HOME/.config/zed/settings.json
      echo "Done, settings.json now a regular file"
    '';
  };
}
