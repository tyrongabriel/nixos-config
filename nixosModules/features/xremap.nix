{
  config,
  pkgs,
  lib,
  ...
}:

let
  xremapConfig = {
    # Configure your xremap settings here
    # For example, to remap the 'a' key to 'b', you can use:
    # "a" = "b";
  };
in
{
  options = {
    xremap = {
      enable = lib.mkEnableOption "Enable xremap";
      config = lib.mkOption {
        #type = types.attrs;
        default = xremapConfig;
        description = "xremap configuration";
      };
    };
  };

  config = {
    programs.xremap = {
      enable = config.xremap.enable;
      config = config.xremap.config;
      package = pkgs.xremap;
    };
  };
}
