{ lib, config, ... }:
let
  cfg = config.myHome.winapps;
in
{
  options.myHome.winapps = with lib; {
    enable = mkEnableOption "Enable Windows apps";
  };

  config = lib.mkIf cfg.enable {
    home.file.".config/winapps/compose.yaml".source = ./compose.yaml;
    # https://github.com/winapps-org/winapps/blob/main/docs/docker.md
    # Have not found a way to nixify the installation of the container OS
    home.file.".config/winapps/install-compose.yaml".source = ./install-compose.yaml;
  };
}
