{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.myNixOS.wireguard;
in
{
  options.myNixOS.wireguard = with lib; {
    enable = mkEnableOption "Enable WireGuard";
  };

  config = lib.mkIf cfg.enable {
    networking.firewall = {
      allowedUDPPorts = [ 51820 ]; # Clients and peers can use the same port, see listenport
    };
    # Enable WireGuard
    networking.wireguard.interfaces = {
      # "wg0" is the network interface name. You can name the interface arbitrarily.
      wg0 = {
        # Determines the IP address and subnet of the client's end of the tunnel interface.
        ips = [ "10.13.37.2/24" ];
        listenPort = 51820; # to match firewall allowedUDPPorts (without this wg uses random port numbers)

        # Path to the private key file.
        #
        # Note: The private key can also be included inline via the privateKey option,
        # but this makes the private key world-readable; thus, using privateKeyFile is
        # recommended.
        privateKeyFile = "/etc/wireguard/introsec";

        peers = [
          # For a client configuration, one peer entry for the server will suffice.

          {
            # Public key of the server (not a file path).
            publicKey = "CJsoWtGkb2mbTA3LUU6q3gvGg+5re7YD4A5QRUxraTo=";

            # Forward all the traffic via VPN.
            allowedIPs = [ "10.13.37.0/24" ];
            # Or forward only particular subnets
            #allowedIPs = [ "10.100.0.1" "91.108.12.0/22" ];

            # Set this to the server IP and port.
            endpoint = "is.hackthe.space:65075"; # ToDo: route to endpoint not automatically configured https://wiki.archlinux.org/index.php/WireGuard#Loop_routing https://discourse.nixos.org/t/solved-minimal-firewall-setup-for-wireguard-client/7577

            # Send keepalives every 25 seconds. Important to keep NAT tables alive.
            persistentKeepalive = 25;
          }
        ];
      };
    };

  };
}
