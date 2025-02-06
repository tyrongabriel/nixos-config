{ lib, config, ... }:
let
  cfg = config.myHome.ssh;
in
{
  options.myHome.ssh = with lib; {
    enable = mkEnableOption "Enable SSH configuration";
  };

  config = lib.mkIf cfg.enable {
    programs.ssh = {
      enable = true;
      matchBlocks = {
        "*" = {
          identityFile = "~/.ssh/id_rsa";
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
