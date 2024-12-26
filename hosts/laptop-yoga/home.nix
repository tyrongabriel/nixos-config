{ ... }:
{
  imports = [
    ../../homeModules
  ];
  home = {
    username = "tyron";
    homeDirectory = "/home/tyron";
    stateVersion = "24.11";

    shellAliases = {
      echi = "echo hi";
    };
  };
}
