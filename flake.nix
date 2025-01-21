{
  inputs = {
    # NOTE: Replace "nixos-23.11" with that which is in system.stateVersion of
    # configuration.nix. You can also use latter versions if you wish to
    # upgrade.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";
    xremap-flake = {
      url = "github:xremap/nix-flake";
    };
    catppuccin.url = "github:catppuccin/nix";

    stylix.url = "github:danth/stylix";
    nixvim = {
      url = "github:nix-community/nixvim";
      # If using a stable channel you can use `url = "github:nix-community/nixvim/nixos-<version>"`
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    #chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  #outputs =
  # inputs@{
  #   self,
  #   nixpkgs,
  #   nixpkgs-stable,
  #   home-manager,
  #   #nix-colors,
  #   #chaotic,
  #   stylix,
  #   nix-vscode-extensions,
  #   nixvim,
  #   ...
  # }:
  outputs =
    {
      nixpkgs,
      self,
      home-manager,
      stylix,
      ...
    }@inputs:
    let
      # super simple boilerplate-reducing
      # lib with a bunch of functions
      myLib = import ./myLib/default.nix { inherit inputs; };
    in
    {
      # NOTE: 'nixos' is the default hostname set by the installer
      nixosConfigurations = {
        yoga = nixpkgs.lib.nixosSystem {
          # NOTE: Change this to aarch64-linux if you are on ARM
          system = "x86_64-linux";
          specialArgs = {
            inherit self inputs myLib;
          };
          modules = [
            ./hosts/laptop-yoga/configuration.nix
            # XRemap Flake config:
            inputs.xremap-flake.nixosModules.default
            inputs.catppuccin.nixosModules.catppuccin
            stylix.nixosModules.stylix
            # home-manager.nixosModules.home-manager
            # {
            #   home-manager = {
            #     useGlobalPkgs = true;
            #     useUserPackages = true;
            #     extraSpecialArgs = { inherit inputs; };
            #     users."tyron" = {
            #       imports = [
            #         ./hosts/laptop-yoga/home.nix
            #         inputs.catppuccin.homeManagerModules.catppuccin
            #       ];
            #     };
            #   };
            # }
          ];
        };

        #another host
      };

      homeConfigurations = {
        "tyron" = home-manager.lib.homeManagerConfiguration {
          # Note: I am sure this could be done better with flake-utils or something
          pkgs = import nixpkgs { system = "x86_64-linux"; };

          modules = [
            ./hosts/laptop-yoga/home.nix
            inputs.catppuccin.homeManagerModules.catppuccin
          ];
        };
      };
    };
}
