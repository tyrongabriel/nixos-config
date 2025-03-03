{ lib, ... }:
{
  #services.power-profiles-daemon.enable = lib.mkForce false; # Gnome uses this, we dont!
  #https://nixos.wiki/wiki/Laptop
  # For gnome battery extension
  security.polkit.enable = true;
  # Standard powersave
  powerManagement = {
    enable = true;
    powertop.enable = true; # Autotune for efficiency
    #cpuFreqGovernor = "powersave"; # Default to powersave
  };

  # Configure on battery/ac
  #https://linrunner.de/tlp/settings/processor.html#cpu-scaling-min-max-freq-on-ac-bat
  services.tlp = {
    enable = false;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;

      CPU_DRIVER_OPMODE_ON_AC = "active";
      CPU_DRIVER_OPMODE_ON_BAT = "active";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      #CPU_MIN_PERF_ON_AC = 0;
      #CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      #CPU_MAX_PERF_ON_BAT = 50;

      #Optional helps save long term battery health
      START_CHARGE_THRESH_BAT0 = 80; # 80 and below it starts to charge
      STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging

    };
  };
}
