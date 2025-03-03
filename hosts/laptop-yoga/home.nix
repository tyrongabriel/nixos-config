{
  pkgs,
  ...
}:
{
  #imports = [ outputs.homeManagerModules.default ];
  # Configure Home
  home = {
    username = "tyron";
    homeDirectory = "/home/tyron";
    stateVersion = "24.11";
    sessionVariables = {
      #FLAKE = "${config.home.homeDirectory}/nixos-config"; # Not Working
      #FUCK = "HI";
    };
    # pointerCursor = lib.mkDefault {
    #   gtk.enable = true;
    #   x11.enable = true;
    # };
  };
  programs.home-manager.enable = true;
  #nixpkgs.config.allowUnfree = true;

  # Some local git config
  programs.git.userName = "tyrongabriel";
  programs.git.userEmail = "51530686+tyrongabriel@users.noreply.github.com";

  programs.ssh.matchBlocks = {
    "ssh.g0.pp" = {
      hostname = "g0.complang.tuwien.ac.at";
      user = "p12326136";
      identityFile = "~/.ssh/id_ed25519";
    };
    "g0.pp" = {
      hostname = "g0.complang.tuwien.ac.at";
      user = "gitolite3";
      identityFile = "~/.ssh/pp/id_rsa";
    };
  };

  # Configure myHome manager modules
  myHome = {
    profilePicture = ./../../images/catppuccin-pfp.png;
    bundles.gaming.enable = true;
    bundles.general.enable = true;
    bundles.gnome-desktop = {
      enable = true;
      autostartPrograms = [
        {
          pkg = pkgs.bitwarden;
          name = "bitwarden";
        }
        {
          pkg = pkgs.discord;
          name = "discord";
          replaceArguments = [
            {
              from = "Exec=Discord";
              to = "Exec=discord --start-minimized";
            }
          ];
        }
      ];
    };
    #bundles.hyprland-desktop.enable = true;
    #bundles.plasma6-desktop.enable = true;
  };

  # Extra packages not defined in myHome
  home.packages = with pkgs; [
    brave
    discord
    bitwarden
    nmap
  ];
}
