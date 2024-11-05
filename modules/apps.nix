{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    neovim
    git
    just # use Justfile to simplify nix-darwin's commands 
  ];
  environment.variables.EDITOR = "nvim";

  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      upgrade = true; 
      cleanup = "zap";
    };

    masApps = {
    };

    taps = [
      "homebrew/services"
      "rust-lang/rust"
    ];

    brews = [
      # Development tools
      "dotnet-sdk" # .NET SDK
      "rust-analyzer" # Rust language server
      "cmake" # Required for some Rust builds
      "llvm" # Required for some Rust builds
      "protobuf" # Protocol buffers
      "grpcurl" # Like curl, but for gRPC
      
      # CLI tools
      "wget"
      "curl" 
      "bat"
      "fd"
      "zoxide"
      "zsh-autosuggestions"
      "atuin"
      "fnm"
    ];

    casks = [
      # IDEs and editors
      "visual-studio-code"
      "jetbrains-rider" # .NET IDE

      # Dev tools
      "docker"
      "postman" # API testing
      
      # Utils
      "1password"
      "signal"
      "raycast"
      "stats"
    ];
  };
}