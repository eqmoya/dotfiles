{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.cli.shells;
in {
  options.modules.cli.shells.zsh = {
    enable = mkEnableOption "zsh";
  };

  config = mkIf (cfg.zsh.enable || (cfg.default == pkgs.zsh)) {
    programs.zsh.enable = true;
    home-manager.users.${config.user.name}.programs.zsh = {
      enable = true;
      shellAliases = cfg.shellAliases;
      enableCompletion = true;
      autosuggestion.enable = true;
      # syntaxHighlighting.enable = true;
      autocd = true;
      dirHashes = {
        dl = "$HOME/Downloads";
        docs = "$HOME/Documents";
        code = "$HOME/Documents/Code";
        dots = "$HOME/Documents/Code/dotfiles";
      };
      history.expireDuplicatesFirst = true;
      initExtra = ''
        # # search history based on what's typed in the prompt
        # autoload -U history-search-end
        # zle -N history-beginning-search-backward-end history-search-end
        # zle -N history-beginning-search-forward-end history-search-end
        # bindkey "^[OA" history-beginning-search-backward-end
        # bindkey "^[OB" history-beginning-search-forward-end

        # open commands in $EDITOR with C-e
        autoload -z edit-command-line
        zle -N edit-command-line
        bindkey "^e" edit-command-line

        # case insensitive tab completion
        zstyle ':completion:*' completer _complete _ignored _approximate
        zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
        zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
        zstyle ':completion:*' menu select
        zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
        zstyle ':completion:*' verbose true

        # use cache for completions
        zstyle ':completion:*' use-cache on
        zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"
        _comp_options+=(globdots)
      '';
    };
  };
}
