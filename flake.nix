{
  description = "Bruce never flakes their rope";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
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
