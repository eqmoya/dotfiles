{ lib, inputs, nixpkgs, home-manager, user, location, ... }:

let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
        inherit system;
        
        config.allowUnfree = true;
    };

    lib = nixpkgs.lib;
in {
    desktop = lib.nixosSystem {
        inherit system;

        specialArgs = {
            inherit inputs user location;

            host = {
                hostName = "desktop";
                mainMonitor = "DP-1";
                secondMonitor = "DVI-D-1";
            };
        };

        modules = [
            ./desktop
            ./configuration.nix

            home-manager.nixosModules.home-manager {
                home-manager = {
                    useGlobalPkgs = true;
                    useUserPackages = true;

                    extraSpecialArgs = {
                        inherit user;

                        host = {
                            hostName = "desktop";
                            mainMonitor = "DP-1";
                            secondMonitor = "DVI-D-1";
                        };
                    };

                    users.${user} = {
                        imports = [(import ./home.nix)] ++ [(import ./desktop/home.nix)];
                    };
                };
            }
        ];
    };
}