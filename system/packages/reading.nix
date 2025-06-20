{config, pkgs, ...}:

{
  # Packages for reading
  environment.systemPackages [
    pkgs.foliate
    pkgs.calibre
    pkgs.cozy
    pkgs.papers
  ];

}
