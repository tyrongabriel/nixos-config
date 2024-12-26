{
  config,
  lib,
  ...
}:
{
  options.custom = with lib; {
    xremap.enable = mkEnableOption "Enable xremap";
    xremap.remaps = mkOption {
      type = types.attrsOf types.string;
      default = {
        "Capslock" = "Esc";
      };
      description = ''
        List of remaps to be applied by xremap: ["CapsLock" = "Esc"]
      '';
    };
  };

  config = lib.mkIf config.custom.xremap.enable {
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
        remap = {
          "Capslock" = "Esc";
        };
      }
    ];
  };
}
