{ lib, config, ... }:
let
  cfg = config.myHome.ssh;
in
{
  options.myHome.ssh = with lib; {
    enable = mkEnableOption "Enable SSH configuration";
    customConfig = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "Custom SSH configuration text that is written to ~/.ssh/config_custom and included into ssh.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.file.".ssh/config_custom".text = cfg.customConfig;

    programs.ssh = {
      enableDefaultConfig = false;
      includes = [ "~/.ssh/config_custom" ];
      enable = true;
      matchBlocks = {
        "*" = {
          identityFile = "~/.ssh/id_ed25519";
        };
        "github.com" = {
          identityFile = "~/.ssh/id_ed25519";
          user = "git";
          identitiesOnly = true;
        };
      };
    };
  };
}
