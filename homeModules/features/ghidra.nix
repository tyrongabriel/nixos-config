{
  lib,
  config,
  pkgs,
  ...
}:

let
  cfg = config.myHome.ghidra;

  # Define your custom Ghidra package
  myGhidra = pkgs.ghidra.overrideAttrs (oldAttrs: {
    # 'postInstall' is the hook where you can modify the installed files
    postInstall = ''
      ${oldAttrs.postInstall or ""} # Keep existing postInstall actions

      # Path to the launch.properties file within the installed Ghidra
      GHIDRA_SUPPORT_DIR="$out/lib/ghidra/support"
      LAUNCH_PROPERTIES_FILE="$GHIDRA_SUPPORT_DIR/launch.properties"

      # Ensure the support directory exists
      mkdir -p "$GHIDRA_SUPPORT_DIR"

      SCALE_VALUE="${toString cfg.uiScale}"

      # Check if a line starting with VMARGS_LINUX= and containing -Dsun.java2d.uiScale exists
      if grep -q "^VMARGS_LINUX=-Dsun.java2d.uiScale=" "$LAUNCH_PROPERTIES_FILE"; then
        # The line exists and has uiScale, so replace its value
        sed -i "s/^VMARGS_LINUX=-Dsun.java2d.uiScale=.*/VMARGS_LINUX=-Dsun.java2d.uiScale=$SCALE_VALUE/g" "$LAUNCH_PROPERTIES_FILE"
      else
        # VMARGS_LINUX=-Dsun.java2d.uiScale line does not exist at all, append the whole line
        echo "VMARGS_LINUX=-Dsun.java2d.uiScale=$SCALE_VALUE" >> "$LAUNCH_PROPERTIES_FILE"
      fi
    '';
  });

in
{
  options.myHome.ghidra = {
    enable = lib.mkEnableOption "Enable Ghidra and apply custom configurations.";

    uiScale = lib.mkOption {
      type = lib.types.float; # Changed from int to float
      default = 1.0; # Default to 1.0 (no scaling)
      description = ''
        Set the UI scaling factor for Ghidra.
        Examples: 1.0 (no scaling), 1.25, 1.5, 2.0.
        This modifies the -Dsun.java2d.uiScale Java property in launch.properties.
      '';
      example = 1.5;
    };
  };

  config = lib.mkIf cfg.enable {
    # If using home-manager, use home.packages.
    # If this is a system-wide module, use environment.systemPackages.
    home.packages = [
      myGhidra
    ];
  };
}
