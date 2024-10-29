{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    enableFeatureA = {
      default = false;
      description = "Enable feature A";
      type = lib.types.bool;
    };

    enableFeatureB = {
      default = true;
      description = "Enable feature B";
      type = lib.types.bool;
    };
  };

  config = {
    # Your existing configuration goes here

    services = {
      # Enable/disable services based on options
      serviceA.enable = config.enableFeatureA;
      serviceB.enable = config.enableFeatureB;
    };
  };
}
