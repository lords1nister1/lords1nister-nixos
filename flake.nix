{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nvf.url = "github:notashelf/nvf";
  };

  outputs = { self, nixpkgs, nvf, ... }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};

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
        {
          environment.systemPackages = [
            neovimPkg
          ];
        }
      ];
    };
  };
}
