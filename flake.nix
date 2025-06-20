{

 description = "My first flake!";

 inputs = {
   nixpkgs.url = "nixpkgs/nixos-unstable";
   home-manager.url = "github:nix-community/home-manager/master";
   home-manager.inputs.nixpkgs.follows = "nixpkgs";
   nixvim.url = "github:nix-community/nixvim";
   nixvim.inputs.nixpkgs.follows = "nixpkgs";	
 };



 outputs = { self, nixpkgs, ... }@inputs:
    let
       system = "x86_64-linux";
       lib = nixpkgs.lib;
       pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations = {
        mendel = lib.nixosSystem {
          inherit system;
          modules = [ ./configuration.nix ];
       }; 
     };
     homeConfigurations."ernstrom" = 
       inputs.home-manager.lib.homeManagerConfiguration {
       inherit pkgs;
       modules = [ ./home.nix ];  
    };
  };
}
