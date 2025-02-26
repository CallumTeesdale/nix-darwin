_: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    initExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
      # Use the actual path instead of variable
      source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
      eval "$(atuin init zsh)"
      eval "$(fnm env --use-on-cd --shell zsh)"

      # Load .NET CLI tools
      export PATH="$PATH:$HOME/.dotnet/tools"
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
  };
}
