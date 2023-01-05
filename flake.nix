{
    description = "nixos starter flake home-manager";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        home-manager.url = "github:nix-community/home-manager";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = inputs @ { self, nixpkgs, home-manager, ... }:
        let
            user = "enrique";
            location = "$HOME/.flake";
        in {
            nixosConfigurations = (
                import ./hosts {
                    inherit (nixpkgs) lib;
                    inherit inputs nixpkgs home-manager user location;
                }
            );
        };
}