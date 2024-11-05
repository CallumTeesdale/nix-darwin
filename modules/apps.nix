{pkgs, ...}: {
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
    ];

    brews = [
      # Development tools
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

      # Dev tools
      "docker"
      "dotnet-sdk" # .NET SDK
      "insomnia" # REST client

      # Utils
      "1password"
      "signal"
      "raycast"
      "stats"
    ];
  };
}
