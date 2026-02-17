{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nvf.url = "github:notashelf/nvf";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
  };

  outputs = { self, nixpkgs, nvf, spicetify-nix, ... }:
 let
  system = "x86_64-linux";
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true; 
  };
  spicetify = spicetify-nix.lib.mkSpicetify pkgs { };  

  neovimPkg = (nvf.lib.neovimConfiguration {
    inherit pkgs;
    modules = [ ./nvf-configuration.nix ];
  }).neovim;
  in 
  {
    packages.${system}.default = neovimPkg;

    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./configuration.nix
        nvf.nixosModules.default
        spicetify-nix.nixosModules.default
        {
          environment.systemPackages = [
            neovimPkg
            spicetify
          ];
        }
      ];
    };
  };
}
