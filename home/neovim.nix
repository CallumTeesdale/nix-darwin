{
  pkgs,
  lib,
  ...
}: let
  userConfig = pkgs.writeText "user-config.lua" ''
    return {
      colorscheme = "catppuccin",
      
      plugins = {
        {
          "catppuccin/nvim",
          name = "catppuccin",
          priority = 1000,
          config = function()
            require("catppuccin").setup({
              flavour = "mocha",
              transparent_background = false,
              integrations = {
                telescope = true,
                treesitter = true,
                cmp = true,
                notify = true,
              },
            })
          end,
        },
        -- Add Rust tools
        {
          "simrat39/rust-tools.nvim",
          ft = "rust",
          config = function()
            require("rust-tools").setup({
              server = {
                settings = {
                  ["rust-analyzer"] = {
                    checkOnSave = {
                      command = "clippy",
                    },
                  },
                },
              },
            })
          end,
        },
        -- Add .NET/C# support
        {
          "Decodetalkers/csharpls-extended-lsp.nvim",
          ft = "cs",
        },
      },

      -- Configure LSP
      lsp = {
        formatting = {
          format_on_save = true,
        },
        servers = {
          rust_analyzer = {
            settings = {
              ["rust-analyzer"] = {
                checkOnSave = {
                  command = "clippy",
                },
              },
            },
          },
          omnisharp = {
            enable = true,
          },
        },
      },

      -- Configure diagnostics
      diagnostics = {
        virtual_text = true,
        underline = true,
      },

      -- Configure polish
      polish = function()
        -- Set up auto commands
        local autocmd = vim.api.nvim_create_autocmd
        
        -- Auto format on save for specific file types
        autocmd("BufWritePre", {
          pattern = { "*.rs", "*.lua", "*.nix", "*.cs" },
          callback = function()
            vim.lsp.buf.format()
          end,
        })
      end,
    }
  '';

  setup-astronvim = pkgs.writeShellScriptBin "setup-astronvim" ''
    # Remove existing neovim config
    rm -rf $HOME/.config/nvim
    rm -rf $HOME/.local/share/nvim
    rm -rf $HOME/.local/state/nvim
    rm -rf $HOME/.cache/nvim

    # Clone AstroNvim
    ${pkgs.git}/bin/git clone --depth 1 https://github.com/AstroNvim/template $HOME/.config/nvim
    rm -rf ~/.config/nvim/.git

    # Create user config directory
    mkdir -p $HOME/.config/nvim/lua/user

    # Copy user configuration
    cp ${userConfig} $HOME/.config/nvim/lua/user/init.lua

    echo "AstroNvim has been installed. Please start nvim to complete plugin installation."
  '';

in {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;

    extraPackages = with pkgs; [
      # Language servers
      lua-language-server
      rust-analyzer
      nodePackages.typescript-language-server
      nodePackages.vscode-langservers-extracted # html, css, json, eslint
      omnisharp-roslyn # C#
      nil # Nix
      
      # Tools required for various plugins
      ripgrep
      fd
      tree-sitter

      # For telescope
      gcc
      gnumake
      
      # For formatters
      prettierd
      stylua
      nixfmt-classic
      rustfmt
    ];
  };

  # Add the setup script to home.packages
  home.packages = [
    setup-astronvim
  ];

  # Add manual installation instructions to shell startup
  programs.zsh.initExtra = lib.mkAfter ''
    # Check if AstroNvim is installed
    if [ ! -d "$HOME/.config/nvim" ]; then
      echo "AstroNvim is not installed. Run 'setup-astronvim' to install it."
    fi
  '';
}