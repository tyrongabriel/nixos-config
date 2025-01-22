{ myLib, ... }:
let
  features = (myLib.filesIn ./features);
in
{
  imports = [ ] ++ features;
}
