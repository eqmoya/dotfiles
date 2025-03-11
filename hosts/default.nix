{
  lib,
  config,
  inputs,
  outputs,
  ...
}:
with lib; let
  flakeInputs = filterAttrs (_: isType "flake") inputs;
  username = config.user.name;
in {
  imports =
    [
      inputs.home-manager.nixosModules.home-manager
    ]
    ++ (builtins.attrValues outputs.modules);

  nix = {
    settings = {
      trusted-users = ["root" "@wheel"];
      auto-optimise-store = mkDefault true;
      experimental-features = ["nix-command" "flakes"];
      warn-dirty = false;
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };

    # Add each flake input as a registry and nix_path
    registry = mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

  nixpkgs = {
    config.allowUnfree = true;
    overlays =
      [
        inputs.nur.overlay
      ]
      ++ (builtins.attrValues outputs.overlays);
  };

  # Run non-nix executables
  # https://nix.dev/permalink/stub-ld
  programs.nix-ld.enable = true;

  home-manager = {
    useGlobalPkgs = true;
    extraSpecialArgs = {inherit inputs outputs;};
    users.${username} = {
      programs = {
        home-manager.enable = true;
        git.enable = true;
      };

      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

      systemd.user.startServices = "sd-switch";
      news.display = "show";

      home = {
        username = username;
        homeDirectory = "/home/${username}";
        sessionPath = ["$HOME/.local/bin"];
        stateVersion = lib.mkDefault "23.05";
        sessionVariables = {
        };
      };
    };
  };

  system.stateVersion = "23.05";
}
