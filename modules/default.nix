{
  user = import ./user.nix;

  # System
  networking = import ./system/networking.nix;
  ## Hardware
  audio = import ./system/hardware/audio.nix;
  bluetooth = import ./system/hardware/bluetooth.nix;
  thunderbolt = import ./system/hardware/thunderbolt.nix;
  katana = import ./system/hardware/katana.nix;

  # Services
  logind = import ./services/logind.nix;
  greetd = import ./services/greetd.nix;
  waybar = import ./services/waybar;

  # CLI
  git = import ./cli/git.nix;
  starship = import ./cli/starship.nix;
  tmux = import ./cli/tmux.nix;
  ## Shells
  shells = import ./cli/shells;
  zsh = import ./cli/shells/zsh.nix;

  # Desktop
  hyprland = import ./desktop/hyprland;
  ## Terminals
  terminals = import ./desktop/terminals;
  kitty = import ./desktop/terminals/kitty.nix;
  foot = import ./desktop/terminals/foot.nix;
  ## Browsers
  browsers = import ./desktop/browsers;
  firefox = import ./desktop/browsers/firefox;

  # Editors
  editors = import ./editors;
  nvim = import ./editors/nvim.nix;

  # Theme
  theme = import ./theme;
}
