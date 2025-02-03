{ config, lib, ... }:
let
  cfg = config.myHome.git;
in
{
  options.myHome.git = with lib; {
    enable = mkEnableOption "Enable Git";
  };

  config = lib.mkIf cfg.enable {
    # Configure Git
    programs.git = {
      enable = lib.mkDefault true;
      extraConfig = {
        # Set default branch [init] defaultBranch = xxx
        init = {
          defaultBranch = "main";
        };
        # Set default editor
        core = {
          editor = "nvim";
        };
        # Automatically setup remote
        push = {
          autoSetupRemote = true;
        };
      };

    };

  };
}
