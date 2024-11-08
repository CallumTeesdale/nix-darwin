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
      "gcenx/wine"
    ];

    brews = [
      # Development tools
      "cmake" # Required for some Rust builds
      "llvm" # Required for some Rust builds
      "protobuf" # Protocol buffers
      "grpcurl" # Like curl, but for gRPC
      "winetricks" # Wine tricks

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
      "wine-crossover" # Wine for running Windows apps

      # Utils
      "1password"
      "signal"
      "raycast"
      "stats"
      "tailscale"
      "slack"
      "twingate"
      "whisky"
    ];
  };
}
