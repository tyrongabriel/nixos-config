# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  pkgs,
  pkgs-stable,
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
      devenv.enable = true;
      # Enable gnome desktop
      bundles.gnome-desktop.enable = true;
      #bundles.hyprland-desktop.enable = true;
      #bundles.plasma6-desktop.enable = true;
      # Enable xremap
      xremap.enable = true;
      xremap.remaps = {
        "Capslock" = "Esc";
      };
      stylix.enable = true;
      appimage.enable = true;
      nix-ld.enable = true;
      steam.enable = true;
      # Set home manager
      userName = "tyron";
      userConfig = ./home.nix;
      # userNixosConfig for further user conf
      # spacedrive.enable = true;
      userNixosSettings = {
        packages = with pkgs; [
          obsidian
          jetbrains.idea-ultimate
        ];
      };
      #winapps.enable = true; #Could not get it to work
      klee.enable = true;
      qemu.enable = true;
      john-the-ripper.enable = true;
      wireguard.enable = true;
    };

    # Set default editor
    environment.variables.EDITOR = "nvim";

    # Enable CUPS to print documents.
    services.printing.enable = true;

    # System Packages
    environment.systemPackages =
      (with pkgs; [
        nil
        nixfmt-rfc-style
        neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
        git
        libinput
        vscode
        nh
        zsh
        tlp
        nodePackages."@angular/cli"
        rustup # Needed to get zed dev extensions to work (angular)
        # Fix needed: for --target wasm32-waisip1
        # https://www.reddit.com/r/Gentoo/comments/181y6mc/i_maybe_messed_up_my_rust_installation_wasm_not/?rdt=50810
        # rustup target add --toolchain stable wasm32-unknown-unknown
      ])
      ++ (with pkgs-stable; [
        nixd # Nix Language Server
      ]);

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "24.05"; # Did you read the comment?
  };
}
