{ ... }:
{
  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  # Enable real time scheduling for audio.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
