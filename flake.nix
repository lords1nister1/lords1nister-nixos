{
  description = "NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nvf.url = "github:notashelf/nvf";
    flake-utils.url = "github:numtide/flake-utils";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nvf, nix-index-database, flake-utils, spicetify-nix, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };

      runst = pkgs.rustPlatform.buildRustPackage {
        pname = "runst";
        version = "latest";
        src = pkgs.fetchFromGitHub {
          owner = "orhun";
          repo = "runst";
          rev = "0123456789abcdef0123456789abcdef01234567";
          hash = pkgs.lib.fakeHash;
        };
        cargoHash = pkgs.lib.fakeHash;
      };
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        
        specialArgs = { inherit inputs; };

        modules = [
          spicetify-nix.nixosModules.default

          ./spicetify.nix
          ./hardware-configuration.nix
          ./configuration.nix
          nix-index-database.nixosModules.default
          nvf.nixosModules.default
          ({ config, pkgs, ... }: {
            programs.nvf.enable = true;
            programs.nvf.settings.imports = [ ./nvf-configuration.nix ];
          })
        ];
      };

      packages.${system} = {
        default = nvf.lib.neovimConfiguration {
          inherit pkgs;
          modules = [ ./nvf-configuration.nix ];
        }.neovim;
      };
    };
}

