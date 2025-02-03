{ myLib, ... }:
let
  features = (myLib.filesIn ./features);
  bundles = (myLib.filesIn ./bundles);
in
{
  imports = [ ] ++ features ++ bundles;
}
