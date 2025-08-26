{
  inputs,
  lib,
  config,
  #outputs,
  ...
}:
{
  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = true;
      AllowUsers = null; # Allows all users by default. Can be [ "user1" "user2" ]
      UseDns = true;
      X11Forwarding = false;
      PermitRootLogin = "no"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
    };
  };

  # onyl for deployrs
  # security.sudo.extraRules = [
  #   {
  #     users = [ "tyron" ];
  #     commands = [
  #       {
  #         command = "ALL";
  #         options = [ "NOPASSWD" ];
  #       }
  #     ];
  #   }
  # ];

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22 ];
}
