{pkgs, ...}: {
  home.packages = with pkgs; [
    # archives
    zip # compression
    xz # compression
    unzip # decompression

    # utils
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    yq-go # yaml processer https://github.com/mikefarah/yq
    fzf # A command-line fuzzy finder
    lazygit # simple terminal UI for git commands
    glow # markdown previewer in terminal

    # fonts
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })

    # development
    rustup # rust toolchain installer
    nodejs # required for some neovim plugins
    python3 # required for some neovim plugins

    # misc
    file # determine file type
    which # locate a command
    tree # list contents of directories in a tree-like format
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