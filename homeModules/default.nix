{
  #myLib,
  pkgs,
  lib,
  ...
}:
let
  filesIn = dir: (map (fname: dir + "/${fname}") (builtins.attrNames (builtins.readDir dir)));

  features = (filesIn ./features);
  bundles = (filesIn ./bundles);
in
{
  imports = [ ] ++ features ++ bundles;
  options.myHome = {
    profilePicture = lib.mkOption {
      description = "Path to profile picture";
      type = with pkgs.lib.types; path;
    };
  };
}
