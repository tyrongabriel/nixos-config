{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myHome.latex;
in
{
  options.myHome.latex = {
    enable = lib.mkEnableOption "Enable Latex editing with Texstudio";

    packages = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [
        "amsmath"
        "amsfonts"
        "amssymb"
        "amsthm"
        "mathtools"
        "graphicx"
        "geometry"
        "hyperref"
        "inputenc"
        "fontenc"
        "babel"
        "listings"
        "color"
        "xcolor"
        "tikz"
        "pgfplots"
        "siunitx"
        "booktabs"
        "microtype"
        "enumitem"
        "csquotes"
        "biblatex"
      ];
      description = "List of LaTeX packages to include.";
    };

    settings = lib.mkOption {
      type = lib.types.attrs;
      default = { }; # Add Texstudio specific settings here
      description = "Texstudio settings.";
    };
  };

  config = lib.mkIf cfg.enable {
    # https://nixos.wiki/wiki/TexLive
    home.packages = with pkgs; [
      texstudio
      texlive.combined.scheme-basic # or scheme-full or scheme-medium, depending on your needs
      texlive.combined.scheme-ext
      (texlive.combinePackages cfg.packages)

    ];

    # You can add Texstudio configuration files here if needed
    # For example, copying a custom texstudio.ini file:
    home.file.".config/texstudio/texstudio.ini".source = ./texstudio.ini; # assuming you have a texstudio.ini in the same directory

    # Example of using settings (replace with actual Texstudio settings if known)
    # Note:  This might require a different approach depending on how Texstudio handles settings.
    # programs.dconf.enable = true;
    # dconf.settings = {
    #   "org/texstudio" = cfg.settings;
    # };

    # If Texstudio has a config file with key-value pairs, you could generate it with:
    # home.file.".config/texstudio/user.txsprofile".text = lib.generators.toKeyValue {} cfg.settings;

    # Warning:  Texstudio configuration and settings application in NixOS can be tricky.  The exact method depends on how Texstudio stores its configurations.  Research and experimentation are usually necessary.
  };
}
