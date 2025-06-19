{config, pkgs, ... }:

{
  # Enable OpenGL
   hardware.graphics = {
     enable = true;
  };

   # Load nvidia driver for Xorg and Wayland
   services.xserver.videoDrivers = ["nvidia"];

   hardware.nvidia = {

    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
    # of just the bare essentials.
    powerManagement.enable = true;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of 
    # supported GPUs is at: 
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Only available from driver 515.43.04+
    open = false;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

   # Optionally, you may need to select the appropriate driver version for your specific GPU.
   
   package = config.boot.kernelPackages.nvidiaPackages.beta; 

   # package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
   #   version = "570.153.02";
   #   sha256_64bit = "sha256-FIiG5PaVdvqPpnFA5uXdblH5Cy7HSmXxp6czTfpd4bY=";
   #   sha256_aarch64 = "sha256-2DpY3rgQjYFuPfTY4U/5TcrvNqsWWnsOSX0f2TfVgTs=";
   #   openSha256 = "sha256-2DpY3rgQjYFuPfTY4U/5TcrvNqsWWnsOSX0f2TfVgTs=";
   #   settingsSha256 = "sha256-5m6caud68Owy4WNqxlIQPXgEmbTe4kZV2vZyTWHWe+M=";
   #   persistencedSha256 = "";
   # };
  };
}
