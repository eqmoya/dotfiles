{ pkgs, ... }:

{
    imports =
        [
            ../../modules/desktop/awesome/home.nix
        ];
    
    home = {
        packages = with pkgs; [
            firefox
            google-chrome
        ];
    };
}