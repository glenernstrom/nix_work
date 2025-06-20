{config, pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.aisleriot
	pkgs.lutris
	pkgs.wesnoth
	pkgs.warzone2100
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
	localNetworkGameTransfers.openFirewall = true;
  };
}
