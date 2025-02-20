{
  lib,
  config,
  inputs,
  outputs,
  myLib,
  pkgs,
  ...
}:
let
  cfg = config.myNixOS;
in
{
  options.myNixOS = {
    userName = lib.mkOption {
      default = "tyron";
      description = ''
        username
      '';
    };

    userConfig = lib.mkOption {
      default = ./../../hosts/laptop-yoga/home.nix;
      description = ''
        home-manager config path
      '';
    };

    userNixosSettings = lib.mkOption {
      default = { };
      description = ''
        NixOS user settings
      '';
    };
  };

  config = {
    programs.zsh.enable = true;
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "bak";
      extraSpecialArgs = {
        inherit inputs;
        inherit myLib;
        outputs = inputs.self.outputs;
      };
      users = {
        ${cfg.userName} =
          { ... }:
          {
            imports = [
              (import cfg.userConfig)
              outputs.homeManagerModules.default
            ];
          };
      };
    };

    users.users.${cfg.userName} = {
      isNormalUser = true;
      initialPassword = "12345";
      description = cfg.userName;
      shell = pkgs.zsh;
      extraGroups = [
        "libvirtd"
        "networkmanager"
        "wheel"
      ];
    } // cfg.userNixosSettings;
  };
}
