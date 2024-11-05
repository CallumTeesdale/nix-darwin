{...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    initExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
      source #{HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
      eval "$(atuin init zsh)"
      eval "$(fnm env --use-on-cd --shell zsh)"
      
      # .NET suggestions
      _dotnet_zsh_complete() 
      {
        local completions=("$(dotnet complete "$words")")
        reply=( "${(ps:\n:)completions}" )
      }
      compctl -K _dotnet_zsh_complete dotnet
    '';
  };

  home.shellAliases = {
    # Kubernetes
    k = "kubectl";
    kctx = "kubectx";
    kns = "kubens";
    
    # Docker
    dgc = "docker system prune -a";
    dc = "docker-compose";
    
    # Rust
    cb = "cargo build";
    cr = "cargo run";
    ct = "cargo test";
    cw = "cargo watch";
    
    # .NET
    dn = "dotnet";
    dnr = "dotnet run";
    dnt = "dotnet test";
    dnb = "dotnet build";
    dna = "dotnet add";
    dnw = "dotnet watch";
    
    # Git (additional to what's in git.nix)
    gf = "git fetch --all";
    gp = "git pull";
    gst = "git status";
    
    # Azure
    az = "azure-cli";
  };
}