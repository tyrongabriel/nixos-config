{ outputs, ... }:
{
  imports = [ outputs.homeManagerModules.default ];
  home = {
    username = "tyron";
    homeDirectory = "/home/tyron";
    stateVersion = "24.11";
  };
  programs.home-manager.enable = true;

  # Some local git config
  programs.git.userName = "tyrongabriel";
  programs.git.userEmail = "51530686+tyrongabriel@users.noreply.github.com";
}
