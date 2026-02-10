{
  description = "Very simple flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    spicetify-nix,
    ...
  }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs;
      };
      modules = [
        ./configuration.nix
        ./modules/spicetify.nix
        ./hardware-configuration.nix
        home-manager.nixosModules.home-manager
        spicetify-nix.nixosModules.spicetify
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.user = {
            home.stateVersion = "25.11";
          };
        }
      ];
    };
  };
}
