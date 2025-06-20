{config, pkgs, ... }:

{
  # Suite of multimedia apps
  environment.systemPackages =  [
    pkgs.vlc
	pkgs.kdePackages.kdenlive
	pkgs.shotcut
	pkgs.obs-studio
	pkgs.gnome-podcasts
	pkgs.shortwave
  ];
}
