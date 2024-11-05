{...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    initExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
      source #{HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
      eval "$(atuin init zsh)"
      eval "$(fnm env --use-on-cd --shell zsh)"
    '';
  };

  home.shellAliases = {
    k = "kubectl";

    # git
    g = "git";
    gs = "git status";
    ga = "git add";
    gc = "git commit";
    gca = "git commit -a";
    gcm = "git commit -m";
    gp = "git push";
    gpl = "git pull";
    gco = "git checkout";
    gb = "git branch";

    # docker
    dgc = "docker system prune -a";
  };
}
