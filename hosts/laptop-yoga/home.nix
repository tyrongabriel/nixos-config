{
  pkgs,
  pkgs-stable,
  ...
}:
let
  #pkgs-stable = inputs.nixpkgs-stable;
in
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
  nixpkgs.config.allowUnfree = true;

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
    "reset.inso-world.com" = {
      hostname = "reset.inso-world.com";
      user = "git";
      identityFile = "~/.ssh/id_ed25519_uni";
    };
    "hp01" = {
      hostname = "hp01";
      user = "tyron";
      port = 22;
      identityFile = "~/.ssh/id_ed25519";
    };
    "ltc01" = {
      hostname = "ltc01";
      user = "tyron";
      port = 22;
      identityFile = "~/.ssh/id_ed25519";
    };
    "ncvps" = {
      hostname = "202.61.203.208";
      user = "tyron";
      port = 22022;
      identityFile = "~/.ssh/id_ed25519";
    };
  };

  # Configure myHome manager modules
  myHome = {
    winapps.enable = true;
    ssh.customConfig = ''
      Host testbed
        User e12326136
        HostName is.hackthe.space
        Port 65522
        HostKeyAlgorithms +ssh-rsa
        PubkeyAcceptedAlgorithms +ssh-rsa
        IdentityFile ~/.ssh/id_ed25519_introsec
    '';
    profilePicture = ./../../images/catppuccin-pfp.png;
    git.includes = [
      {
        condition = "gitdir:~/university/sepm/";
        contents = {
          user = {
            name = "Tyron Dylan Gabriel";
            email = "e12326136@student.tuwien.ac.at";
          };
        };
      }
    ];
    bundles.security.enable = true;
    ghidra = {
      enable = true;
      uiScale = 2.0;
    };
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
  home.packages =
    with pkgs;
    [
      discord
      bitwarden
      nmap
      dig
      signal-desktop
      devbox
      compose2nix
      burpsuite
      zoxide
      ripgrep
      zoom-us
    ]
    ++ (with pkgs-stable; [
      brave
    ]);
}
