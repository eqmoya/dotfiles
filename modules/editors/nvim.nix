{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.editors;
in {
  options.modules.editors.nvim.enable = mkEnableOption "nvim";
  config = mkIf (cfg.nvim.enable || (cfg.default == "nvim")) {
    environment.systemPackages = with pkgs; [
      git
      gcc
      gnumake
      unzip
      ripgrep
      fd
      wl-clipboard
      luarocks
      tree-sitter
      nodejs
    ];

    home-manager.users.${config.user.name} = {
      programs.neovim = {
        enable = true;
        package = pkgs.unstable.neovim-unwrapped;
      };
      xdg.configFile = {
        "nvim" = {
          source = ../../config/nvim;
          recursive = true;
        };
      };
    };
  };
}
