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

    hyprland.url = "github:hyprwm/Hyprland";

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };
  outputs =
    {
      nixpkgs,
      nixpkgs-stable,
      self,
      home-manager,
      stylix,
      ...
    }@inputs:
    let
      # super simple boilerplate-reducing
      # lib with a bunch of functions (Credit to Vimjoyer)
      myLib = import ./myLib/default.nix { inherit inputs; };
    in
    with myLib;
    {
      # NOTE: 'nixos' is the default hostname set by the installer
      nixosConfigurations = {
        yoga = mkSystem ./hosts/laptop-yoga/configuration.nix [
          # Extra modules to be used in the system
          inputs.xremap-flake.nixosModules.default
        ];
        #another host
      };

      homeConfigurations = {
        "tyron@yoga" = mkHome "x86_64-linux" ./hosts/laptop-yoga/home.nix;
      };

      # Accessed via outputs.*.default inside of config files
      homeManagerModules.default = ./homeModules;
      nixosModules.default = ./nixosModules;
    };
}
