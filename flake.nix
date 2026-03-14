{
  description = "NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nvf.url = "github:notashelf/nvf";

    nix-index-database = {
     url = "github:nix-community/nix-index-database";
     inputs.nixpkgs.follows = "nixpkgs";
     };
  };

  outputs = { self, nixpkgs, nvf, nix-index-database, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hardware-configuration.nix
          ./configuration.nix
          nix-index-database.nixosModules.default
          nvf.nixosModules.default

          ({
            config, pkgs, ... 
          }: {
            programs.nvf = {
              enable = true;
              settings = {
                imports = [ ./nvf-configuration.nix ];
              };
            };
          })
        ];
      };

      packages.${system}.nvf = nvf.lib.neovimConfiguration {
        pkgs = pkgs;
        modules = [ ./nvf-configuration.nix ];
      }.neovim;
      defaultPackage.${system} = self.packages.${system}.nvf;
    };
}
