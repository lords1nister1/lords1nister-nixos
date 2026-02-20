{
  description = "NixOS configuration with NVF (Neovim Flake) integration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nvf.url = "github:notashelf/nvf";
  };

  outputs = { self, nixpkgs, nvf, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hardware-configuration.nix
          ./configuration.nix
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

      # Optional — build NVF as standalone package
      packages.${system}.nvf = nvf.lib.neovimConfiguration {
        pkgs = pkgs;
        modules = [ ./nvf-configuration.nix ];
      }.neovim;
      defaultPackage.${system} = self.packages.${system}.nvf;
    };
}
