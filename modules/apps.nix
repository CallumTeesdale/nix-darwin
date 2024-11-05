{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    neovim
    git
    just # use Justfile to simplify nix-darwin's commands 
    dotnet-sdk_8 # .NET SDK
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
      "wget"  # download files from the web
      "curl" # transfer data with URLs
      "bat" # cat clone with syntax highlighting
      "fd"  # simple, fast and user-friendly alternative to find
      "zoxide"  # a faster way to navigate your filesystem
      "zsh-autosuggestions"  # fish-like autosuggestions for zsh
      "atuin" # a modern prompt for the modern shell
      "fnm"  # Node.js version manager
    ];

    casks = [
      "visual-studio-code" # code editor
      "1password"  # password manager
      "docker" # containerization platform
      "signal" # encrypted messaging
      "raycast" # productivity tool
      "stats" # system monitor
    ];
  };
}