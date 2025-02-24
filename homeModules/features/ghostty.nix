{
  config,
  lib,
  ...
}:
let
  cfg = config.myHome.ghostty;
in
{
  options.myHome.ghostty = with lib; {
    enable = mkEnableOption "Enable Ghostty";
  };

  config = lib.mkIf cfg.enable {
    programs.ghostty = {
      enable = lib.mkDefault true;
      enableZshIntegration = lib.mkDefault true;
    };

    # xdg.mimeApps.defaultApplications = {
    #   "x-scheme-handler/ssh" = [ "com.mitchellh.ghostty.desktop" ];
    #   "x-scheme-handler/telnet" = [ "com.mitchellh.ghostty.desktop" ];
    #   "application/x-terminal-emulator" = [ "com.mitchellh.ghostty.desktop" ];
    # };

  };
}
