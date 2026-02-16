{
  description = "A very basic flake";

  inputs = {
   nvf.url = "github:notashelf/nvf";
   nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs, nvf, ... }: {

  packages."x86_64-linux".default = 
   (nvf.lib.neovimConfiguration {
    pkgs = nixpkgs.legacyPackages."x86_64-linux";
    modules = [ ./nvf-configuration.nix ]; 
  }).neovim;



   nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
    modules = [
     ./configuration.nix
     nvf.nixosModules.default
     ];
    };

  };
} 
