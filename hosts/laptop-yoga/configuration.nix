# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  pkgs,
  pkgs-stable,
  myLib,
  lib,
  ...
}:
let
  # Include the system specific configurations (Boot, hardware etc.)
  sysfiles = (myLib.filesIn ./system);
in
{
  imports = [
    ../../nixosModules
  ]
  ++ sysfiles;

  options = { };

  config = {
    # TIP FOREVER:
    # do nix build nixpkgs#<package> to build a package
    # cd into that result
    # use nix run nixpkgs#eza -- --tree --level 3 to list package structure
    # This displays folder structure! nice for fonts etc.
    myNixOS = {
      android-dev.enable = true;
      tailscale.enable = true;
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
          jetbrains.idea-ultimate # At help -> Edit Custom VM Options -> add -Dawt.toolkit.name=WLToolkit
        ];
      };
      #winapps.enable = true; #Could not get it to work
      klee.enable = true;
      qemu.enable = true;
      john-the-ripper.enable = true;
      wireguard.enable = false;
      docker.enable = true;
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
        iproute2
        #comma not when using nix-index
        kubectl
        krew
        kubectx # Installs kubens
        k3s
        kubernetes-helm
        k9s
        netbird
        openconnect
        binaryninja-free
      ])
      ++ (with pkgs-stable; [
        nixd # Nix Language Server
        #ventoy-full-gtk
      ]);
    nixpkgs.config.permittedInsecurePackages = [
      "ventoy-gtk3-1.1.05"
    ];

    services.netbird.enable = true;

    programs.nix-index-database.comma.enable = true;

    services.zerotierone = {
      enable = true;
      joinNetworks = [ "134dabecc87d8e19" ];
    };
    networking.firewall.allowedUDPPorts = lib.mkForce [
      9993 # ZeroTier default port
    ];
    networking.extraHosts = ''
      # K3s Cluster Dashboard Hostname
      100.101.134.116 kubernetes-dashboard.tyclan.ts.net
      100.101.134.116:8080 haproxy.tyclan.ts.net
    '';

    networking.networkmanager.plugins = with pkgs; [
      networkmanager-openconnect
    ];

    programs.wireshark = {
      enable = true;
      usbmon.enable = true;
      dumpcap.enable = true;
    };

    services.openssh = {
      enable = true;
      openFirewall = true;
    };
    users.users.tyron = {
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEqAq3GCuNXFc8mQL+H/czF0+pOlyQ4c4GILKUcrK0fZ 51530686+tyrongabriel@users.noreply.github.com"
      ];
    };

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "24.05"; # Did you read the comment?
  };
}
