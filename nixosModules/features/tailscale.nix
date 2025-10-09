{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.myNixOS.tailscale;
  tailnet = "tail1c2108.ts.net";
in
{
  options.myNixOS.tailscale = with types; {
    enable = mkEnableOption "Enable Tailscale vpn";
    # Add more options here
  };

  config = lib.mkIf cfg.enable {
    environment.variables = {
      TAILNET_NAME = tailnet;
    };
    services.tailscale.enable = true;
    # Tailscale had my dns broken sometimes... Adding backups
    # https://github.com/tailscale/tailscale/issues/4254
    networking.nameservers = [
      "1.1.1.1"
      "1.0.0.1"
    ];
    services.resolved = {
      enable = true;
      dnssec = "false"; # because some dns (like terranix.org) dont resolve
      domains = [ "~." ];
      fallbackDns = [
        "1.1.1.1"
        "1.0.0.1"
      ];
      dnsovertls = "true";
      extraConfig = ''
        DNSOverTLS=opportunistic
        ReadEtcHosts=yes
      '';
    };
    networking.networkmanager.dns = "systemd-resolved";

    # Bug: https://github.com/tailscale/tailscale/issues/4254
    #networking.useNetworkd = true;

    networking.interfaces.tailscale0 = {
      useDHCP = false;
    };

    # If my tailnet uses routing features etc. need to configure
    #services.tailscale.useRoutingFeatures = "both" | "server" | "client"

    # For dns certs in the tailnet, run
    # sudo tailscale cert ${HOSTNAME}.${TAILNET_NAME}
    # Or like me make this service
    systemd.services.update-tailscale-tls-cert = {
      description = "Execute my tailscale cert to get new https cert";
      environment = {
        HOSTNAME = config.networking.hostName; # The hostname of the machine
        TAILNET_NAME = tailnet;
      };
      serviceConfig = {
        User = "root"; # Or a less privileged user if appropriate
        Type = "oneshot"; # The service exits after executing the command
        ExecStart = "${pkgs.tailscale}/bin/tailscale cert \${HOSTNAME}.\${TAILNET_NAME}";
      };
    };

    systemd.timers.update-tailscale-tls-cert-timer = {
      description = "Run my tls update monthly";
      wantedBy = [ "timers.target" ];
      partOf = [ "update-tailscale-tls-cert.service" ];
      timerConfig = {
        Unit = "update-tailscale-tls-cert.service";
        OnCalendar = "monthly"; # Run at the beginning of each month (00:00)
        # You can be more specific, e.g., "03:15 1st * *" for 3:15 AM on the 1st of every month
        Persistent = true; # If the system was off, run the job soon after boot
      };
    };
  };
}
