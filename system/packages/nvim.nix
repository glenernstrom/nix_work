{config, pkgs, ... }:

{
  enironment.systemPackages [
	# telescope dependencies
	pkgs.ripgrep
    pkgs.fd
  ];
}
