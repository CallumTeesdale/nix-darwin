{pkgs ? import <nixpkgs> {}}: let
  # Common shell utilities
  shellTools = with pkgs; [
    nixfmt # Nix formatter
    nil # Nix language server
    pre-commit # Git pre-commit hooks
    alejandra # Alternative Nix formatter
    just # Command runner
    git # Version control
    jq # JSON processor
  ];

  # Development tools
  devTools = with pkgs; [
    nixpkgs-fmt # Alternative Nix formatter
    nix-tree # Nix dependency viewer
    nix-diff # Compare Nix derivations
    deadnix # Find dead Nix code
    statix # Lint Nix code
  ];
in
  pkgs.mkShell {
    buildInputs = shellTools ++ devTools;

    shellHook = ''
      # Set up pre-commit hooks
      if ! command -v pre-commit &> /dev/null; then
        echo "Installing pre-commit hooks..."
        ${pkgs.pre-commit}/bin/pre-commit install
      fi

      # Create local bin directory if it doesn't exist
      mkdir -p ./.local/bin

      echo """
      🔨 Nix development shell

      Available commands:
        - just                : Show available commands
        - just darwin <host>  : Build and activate configuration for <host>
        - just fmt           : Format nix files
        - pre-commit run     : Run all pre-commit hooks
        - nix-tree          : View dependency tree
        - statix check .     : Lint Nix code
        - deadnix .         : Find dead code

      Development tools:
        - nixfmt, alejandra : Nix formatters
        - nil              : Nix language server
        - nix-tree        : Dependency viewer
        - statix          : Linter
        - deadnix         : Dead code finder
        - jq              : JSON processor
      """
    '';

    # Environment variables
    NIX_CONFIG = "experimental-features = nix-command flakes";
  }
