{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myHome.hyprland;
in
{
  options.myHome.hyprland = {
    enable = lib.mkEnableOption "Enable Hyprland";
  };

  config = lib.mkIf cfg.enable {
    myHome = {
      waybar.enable = lib.mkDefault true;
      rofi.enable = lib.mkDefault true;
    };

    wayland.windowManager.hyprland = {
      enable = true;

      # For plugins configure hyprland-plugins flake
      # Then you can do
      # plugins = []; # List of plugins in inputs.hyprland-pluins.packages."${pkgs.system}".PLUGINNAME;
      # which can then be configured in settings... "plugin:NAME" = {...};
      settings = {
        "$mod" = "SUPER";
        general = {
          gaps_in = 5;
          gaps_out = 10;
          border_size = 2;
          "col.active_border" =
            lib.mkForce "rgba(${config.stylix.base16Scheme.base0E}ff) rgba(${config.stylix.base16Scheme.base09}ff) 60deg";
          "col.inactive_border" = lib.mkForce "rgba(${config.stylix.base16Scheme.base00}ff)";
          layout = "dwindle";
        };

        env = [
          "XCURSOR_SIZE,24"
        ];

        input = {
          kb_layout = "at";
          kb_variant = "nodeadkeys";
          kb_options = "caps:escape";

          touchpad = {
            natural_scroll = true;
          };

          repeat_rate = 40;
          repeat_delay = 250;
          force_no_accel = true;

          sensitivity = -0.5; # -1. / 1.0, 0 is no modification
        };

        exec-once = [
          "waybar"
          "ghostty"
        ];

        bind = [
          "$mod, SPACE, exec, rofi -show run"
          "$mod, L, exec, hyprlock"
        ];

      };
    };

    home.packages = with pkgs; [
      wl-clipboard
      grim
      swaylock
    ];
  };
}
