{pkgs, ...}: {
  home.packages = with pkgs; [
    # Development
    rustup # rust toolchain installer
    cargo-edit # cargo add/rm/upgrade commands
    cargo-watch # watch for changes
    cargo-audit # audit dependencies
    cargo-outdated # show outdated dependencies
    cargo-expand # expand macros
    nodejs # required for some neovim plugins
    python3 # required for some neovim plugins
    
    # Build tools
    pkg-config # Required for some Rust builds
    openssl # Required for some Rust builds
    
    # Database tools
    sqlx-cli # SQL toolkit for Rust

    # Kubernetes tools
    kubectl
    kubectx # switch between clusters and namespaces
    k9s # terminal UI for kubernetes
  

    # Utils
    ripgrep # recursively searches directories for a regex pattern
    jq # JSON processor
    yq-go # YAML processor
    fzf # fuzzy finder
    lazygit # git TUI
    glow # markdown previewer
    grex # regex generator

    # Monitoring and debugging
    htop # process viewer
    bottom # system monitor
    hyperfine # benchmarking tool
    
    # Archives
    zip
    xz
    unzip

    # Fonts
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })

    # misc
    file
    which
    tree
  ];

  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
    };

    eza = {
      enable = true;
      git = true;
      icons = true;
      enableZshIntegration = true;
    };

    yazi = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        manager = {
          show_hidden = true;
          sort_dir_first = true;
        };
      };
    };
  };
}