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
      Pages = 409201541; # Pages
      Numbers = 40920154; # Numbers
      Keynote = 409183694; # Keynote
      Spark = 1176895641; # Spark
      Boop = 1518425043; # Boop
      "SSH Files" = 1336634154; # SSH Files
      "Claude by Anthropic" = 6473753684; # Claude
    };

    taps = [
      "homebrew/services"
      "gcenx/wine"
      "nikitabobko/tap"
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
      "jetbrains-toolbox"
      "zed"

      # Dev tools
      "docker"
      "dotnet-sdk" # .NET SDK
      "wine-crossover" # Wine for running Windows apps

      #Chat 
      "discord"

      # Utils
      "1password"
      "signal"
      "raycast"
      "stats"
      "tailscale"
      "slack"
      "twingate"
      "whisky"
      "aerospace"
    ];
  };
}
