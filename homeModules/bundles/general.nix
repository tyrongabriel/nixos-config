{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myHome.bundles.general;
in
{
  options.myHome.bundles.general = with lib; {
    enable = mkEnableOption "Enable General Bundle";
  };

  config = lib.mkIf cfg.enable {
    myHome = {
      ghostty.enable = lib.mkDefault true;
      zsh.enable = lib.mkDefault true;
    };

    home.packages = with pkgs; [
      bottom
      bat
      zsh
      neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      wget
      brave
      discord
      bitwarden
      htop
      btop
      tmux
      curl
      wget
      git
      vlc
      fzf
      ripgrep
      ncdu
      nmap
      neofetch
    ];
  };
}
