{
  lib,
  config,
  inputs,
  outputs,
  myLib,
  pkgs,
  pkgs-stable,
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
        inherit inputs myLib pkgs-stable;
        homeModules = outputs.homeManagerModules.default;
        outputs = inputs.self.outputs; # Direct outputs cause infinite recursion
      };
      users = {
        ${cfg.userName} =
          { homeModules, ... }:
          {
            imports = [
              (import cfg.userConfig)
              homeModules
            ];
          };
      };
    };

    users.users.${cfg.userName} = {
      isNormalUser = true;
      initialPassword = "12345"; # use mkpasswd -m sha-512 and then ente rpassword
      description = cfg.userName;
      shell = pkgs.zsh;
      extraGroups = [
        "libvirtd"
        "networkmanager"
        "wheel"
      ];
    }
    // cfg.userNixosSettings;
  };
}
