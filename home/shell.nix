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

    # docker
    dgc = "docker system prune -a";
  };
}
