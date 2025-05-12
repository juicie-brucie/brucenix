{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.11";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  }; #inputs

  outputs = { self, nixpkgs, home-manager, ... }: 
   let
	lib = nixpkgs.lib;
	system = "x86_64-linux";
	pkgs = nixpkgs.legacyPackages.${system};
   in { 
   nixosConfigurations = {
	brucenix = lib.nixosSystem {
	inherit system;
	modules = [ ./configuration.nix ];
	}; #brucenix
	}; #nixosConfig
   homeConfigurations = {
	bruce = home-manager.lib.homeManagerConfiguration {
	inherit pkgs;
	modules = [ ./home.nix ];
}; #bruce
}; #homeConfig

  
  }; #in

}
