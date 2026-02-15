{
  description = "A very basic flake";

  inputs = {
   nvf.url = "github:notashelf/nvf";
   nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs, nvf, ... }: {

   nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
    modules = [
     ./configuration.nix
     nvf.nixosModules.default
     ];
    };

  };
}
