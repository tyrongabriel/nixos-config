{
  myLib,
  pkgs,
  lib,
  ...
}:
let
  features = (myLib.filesIn ./features);
  bundles = (myLib.filesIn ./bundles);
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
