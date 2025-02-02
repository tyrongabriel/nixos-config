{ outputs, config, ... }:
{
  imports = [ outputs.homeManagerModules.default ];
  home = {
    username = "tyron";
    homeDirectory = "/home/tyron";
    stateVersion = "24.11";
    sessionVariables = {
      #FLAKE = "${config.home.homeDirectory}/nixos-config"; # Not Working
      #FUCK = "HI";
    };
  };
  programs.home-manager.enable = true;
  programs.ghostty.enable = true;
  # Some local git config
  programs.git.userName = "tyrongabriel";
  programs.git.userEmail = "51530686+tyrongabriel@users.noreply.github.com";
}
