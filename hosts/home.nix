{ config, lib, pkgs, user, ... }:

{
    imports =
        (import ../modules/editors) ++
        (import ../modules/programs) ++
        (import ../modules/services);
    
    home = {
        username = "${user}";
        homeDirectory = "/home/${user}";

        packages = with pkgs; [
            brave
            unzip
            unrar
            gh
        ];

        file.".config/wall".source = ../modules/themes/wall;
        file.".config/wall.mp4".source = ../modules/themes/wall.mp4;

        stateVersion = "23.05";        
    };

    programs = {
        home-manager.enable = true;
    };
}