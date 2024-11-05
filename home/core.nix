{pkgs, ...}: {
  home.packages = with pkgs; [
    # Development
    rustup
    cargo-edit
    cargo-watch
    cargo-audit
    cargo-outdated
    cargo-expand
    nodejs
    python3

    # Build tools
    pkg-config
    openssl

    # Kubernetes tools
    kubectl
    kubectx
    k9s

    # Utils
    ripgrep
    jq
    yq-go
    fzf
    lazygit
    glow
    grex

    # Monitoring and debugging
    htop
    bottom
    hyperfine

    # Archives
    zip
    xz
    unzip

    # Fonts
    (nerdfonts.override {fonts = ["JetBrainsMono"];})

    # misc
    file
    which
    tree
  ];

  programs = {
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
