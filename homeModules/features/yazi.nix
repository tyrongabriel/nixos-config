{
  config,
  lib,
  ...
}:
let
  cfg = config.myHome.yazi;
in
{
  options.myHome.yazi = with lib; {
    enable = mkEnableOption "Enable Yazi file manager";
  };

  config = lib.mkIf cfg.enable {
    programs.yazi = {
      enable = lib.mkDefault true;
      enableZshIntegration = true;
      # Extra settings
      settings = {
        manager = {
          linemode = "mtime";
        };
        # Configure opener
        # opener = {
        #   # Editor list
        #   edit = [
        #     {
        #       run = "nvim";
        #       for = "unix";
        #     }
        #   ];
        # };
      };

    };
  };
}
