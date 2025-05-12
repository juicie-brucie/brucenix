{
   description = "my first flake";
   inputs = {
   inputs.otherDir.url = "path:/home/bruce/.dotfiles/nixpkgs-openfoam.tar.gz";
    };
   outputs = {self, openfoam, ...}@inputs: {
     nixosConfigurations.brucenix = openfoam.lib.nixosSystem {
		system = "x86_64-linux";
		modules = [ ./configuration.nix ];

		};


         };


}
