# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, libs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./system/nvidia.nix
##	  ./system/packages/nvim.nix
	  ./system/packages/reading.nix
	  ./system/packages/multimedia.nix
	  ./system/packages/games.nix
    ];

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "mendel"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ernstrom = {
    isNormalUser = true;
    description = "Glen Ernstrom";
    extraGroups = [ "scanner" "lp" "networkmanager" "wheel" ];
    shell = pkgs.fish;
    
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; 
  
    let 

      R-with-my-packages = rWrapper.override{ packages = with rPackages; [ ggplot2 ggraph dplyr dplyr tidyr survival
      tidyverse shiny knitr]; };

      RStudio-with-my-packages = rstudioWrapper.override{ packages = with rPackages; [ ggplot2 ggraph dplyr dplyr tidyr 
      survival tidyverse shiny knitr]; };

    in

  [

   # Science

   RStudio-with-my-packages
   R-with-my-packages
   texliveFull
   pymol
   fiji

   wget
   git
   
   # TUI
   lynx
   yazi # file browser
   iamb # matrix client with vim bindings
   aerc # email
   zellij
   alpine
   w3m
   ddgr
   elinks
   wiki-tui
   micro
   calcurse
   helix
 
   # Media
   yt-dlp
   
   # Libraries
   tk
   
   # Office
   libreoffice

   # Entertainment
   shortwave
   gnome-podcasts

   # Internet
   mumble
   newsflash
   fractal
   element-desktop
   discord
   pcloud
   zoom-us
   
   # Graphics
   inkscape
   gimp3
   switcheroo
   scribus
   eyedropper
   pdfarranger
 
   # Notes
   rnote
   xournalpp
   iotas
   logseq
 
   # Writing
   texmaker
   citations
   logseq
   texliveFull

   # Utilities
   impression
   ghostty
   gnome-solanum
   blanket
   deja-dup
   bitwarden
   gnome-tweaks
   gdm-settings
   gnome-extension-manager
   pika-backup
   tesseract
   hplip

   # Programming
   python313Packages.jupyterlab # for learning, not projects
   vscode-fhs # not for complex projects
   
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
   services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 64738 ];
  networking.firewall.allowedUDPPorts = [ 64738 ];
  
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  
  # Enalbe flatpak
  services.flatpak.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; 
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
   };
  
  # Turn on scanner support
  hardware.sane.enable = true;
  
  # Sleep is not great on Linux
  systemd.sleep.extraConfig = ''
    AllowSuspend=no
    AllowHibernation=no
    AllowHybridSleep=no
    AllowSuspendThenHibernate=no
  '';
  
  # Turn on bluetooth
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  
  # Best shell ever
  programs.fish.enable = true;
  
  # Necessary mesh networking
  services.tailscale.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}

