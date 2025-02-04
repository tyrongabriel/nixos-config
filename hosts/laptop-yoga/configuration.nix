# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  pkgs,
  myLib,
  ...
}:
let
  # Include the system specific configurations (Boot, hardware etc.)
  sysfiles = (myLib.filesIn ./system);
in
{
  imports = [
    ../../nixosModules
  ] ++ sysfiles;

  options = { };

  config = {
    # TIP FOREVER:
    # do nix build nixpkgs#<package> to build a package
    # cd into that result
    # use nix run nixpkgs#eza -- --tree --level 3 to list package structure
    # This displays folder structure! nice for fonts etc.
    myNixOS = {
      # Enable xremap
      xremap.enable = true;
      xremap.remaps = {
        "Capslock" = "Esc";
      };
      stylix.enable = true;

      # Set home manager
      userName = "tyron";
      userConfig = ./home.nix;
      # userNixosConfig for further user conf
    };

    # Set default editor
    environment.variables.EDITOR = "nvim";

    # Enable CUPS to print documents.
    services.printing.enable = true;

    # System Packages
    environment.systemPackages = with pkgs; [
      nixd # Nix Language Server
      nil
      nixfmt-rfc-style
      neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      git
      libinput
      vscode
      nh
      zsh
    ];

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "24.05"; # Did you read the comment?
  };
}
