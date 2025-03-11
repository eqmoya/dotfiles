{config, ...}: {
  gtk.gtk3.bookmarks = let
    home = config.home.homeDirectory;
  in [
    "file://${home}/Documents"
    "file://${home}/Media"
    "file://${home}/Downloads"
    "file://${home}/.config Config"
  ];
}
