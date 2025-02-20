{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.myNixOS.sddm;
in
{
  options.myNixOS.sddm = {
    enable = lib.mkEnableOption "Enable SDDM";
  };

  config = lib.mkIf cfg.enable {
    # https://github.com/catppuccin/sddm
    environment.systemPackages = [
      (pkgs.catppuccin-sddm.override {
        flavor = "mocha";
        font = "JetBrainsMono Nerd Font Mono";
        fontSize = "9";
        background = "${./../../wallpapers/waterfall.png}";
        loginBackground = true;
      })
    ];

    services.displayManager.sddm = lib.mkForce {
      enable = true;
      enableHidpi = true;
      wayland.enable = true;
      theme = "catppuccin-mocha";
      package = pkgs.kdePackages.sddm;
    };

  };
}
