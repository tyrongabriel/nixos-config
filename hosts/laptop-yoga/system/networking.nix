{ ... }:
{
  networking.hostName = "yoga"; # Define your hostname.
  #networking.wireless.enable = true; # Enables wireless support via wpa_supplicant.

  # networking.nameservers = [
  #   "1.1.1.1"
  #   "8.8.8.8"
  # ];

  # networking.extraResolvconfConf = ''
  #   server=/ts.net/100.100.100.100
  # '';
  # Enable networking
  networking.networkmanager.enable = true;
}
