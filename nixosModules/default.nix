{
  inputs,
  myLib,
  ...
}:
let
  #cfg = config.myNixOS;

  # Taking all modules in ./features and adding enables to them
  #features = myLib.extendModules (name: {
  #  extraOptions = {
  #    custom.${name}.enable = lib.mkEnableOption "enable my ${name} configuration";
  #  };

  #  configExtension = config: (lib.mkIf cfg.${name}.enable config);
  #}) (myLib.filesIn ./features);

  # Taking all module bundles in ./bundles and adding bundle.enables to them
  #bundles =
  #  myLib.extendModules
  #  (name: {
  #    extraOptions = {
  #      myNixOS.bundles.${name}.enable = lib.mkEnableOption "enable ${name} module bundle";
  #    };
  #
  #    configExtension = config: (lib.mkIf cfg.bundles.${name}.enable config);
  #  })
  #  (myLib.filesIn ./bundles);

  # Taking all module services in ./services and adding services.enables to them
  #services =
  #  myLib.extendModules
  #  (name: {
  #    extraOptions = {
  #      myNixOS.services.${name}.enable = lib.mkEnableOption "enable ${name} service";
  #    };

  features = (myLib.filesIn ./features);
  bundles = (myLib.filesIn ./bundles);
in
#    configExtension = config: (lib.mkIf cfg.services.${name}.enable config);
#  })
#  (myLib.filesIn ./services);
{
  imports =
    [
      inputs.home-manager.nixosModules.home-manager
    ]
    ++ features
    ++ bundles;
  #++ features
  #++ bundles
  #++ services;

  #options.custom = {
  #  hyprland.enable = lib.mkEnableOption "enable hyprland";
  #};

  #config = {
  #nix.settings.experimental-features = ["nix-command" "flakes"];
  #programs.nix-ld.enable = true;
  #nixpkgs.config.allowUnfree = true;
  #};
}
