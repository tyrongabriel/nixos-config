{ outputs, ... }:
{
  imports = [ outputs.homeManagerModules.default ];
  home = {
    username = "tyron";
    homeDirectory = "/home/tyron";
    stateVersion = "24.11";

    shellAliases = {
      g = "git";
    };
  };
  programs.home-manager.enable = true;
}
