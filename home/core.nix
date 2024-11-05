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

    # misc
    file # determine file type
    which # locate a command
    tree # list contents of directories in a tree-like format
    lazygit # simple terminal UI for git commands

    # productivity
    glow # markdown previewer in terminal

    # programming
    rustup # rust toolchain installer

  ];

  programs = {
    # modern vim
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

    # terminal file manager
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
