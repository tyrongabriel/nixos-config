{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.myHome.bundles.security;
in
{
  options.myHome.bundles.security = {
    enable = lib.mkEnableOption "Enable Security Bundle";
  };

  config = lib.mkIf cfg.enable {
    myHome = {
      ghidra = {
        enable = true;
        uiScale = 2;
      };
    };

    home.packages = with pkgs; [
      python3 # Python for Http server
      ngrok # For publishing tunnels
      #python3Packages.z3-solver
      pwntools
      radare2 # Reverse engineering framework
      gdb # Gnu debugger
      binutils # objdump, readelf etc. for binary inspection
      binwalk # Firmware analysis
      nmap # Network scanner
      #openbsd
      hydra
      sqlmap
      socat
      john
      hashcat
      exiftool
      foremost
      wireshark
      capstone
    ];
  };
}
