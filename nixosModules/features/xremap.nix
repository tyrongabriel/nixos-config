{
  config,
  lib,
  ...
}:
let
  cfg = config.custom.xremap;
in
{
  options.custom.xremap = with lib; {
    enable = mkEnableOption "Enable xremap";
    remaps = mkOption {
      type = with types; attrsOf str;
      default = {
        "Capslock" = "Esc";
      };
      description = ''
        List of remaps to be applied by xremap: ["CapsLock" = "Esc"]
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    # XRemap
    services.xremap = {
      # NOTE: since this sample configuration does not have any DE, xremap needs to be started manually by systemctl --user start xremap
      serviceMode = "user";
      userName = "tyron";
    };
    # Modmap for single key rebinds
    services.xremap.config.modmap = [
      {
        name = "Global";
        remap = cfg.remaps;
      }
    ];
  };
}
