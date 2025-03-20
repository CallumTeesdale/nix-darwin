{
  description = "Nix for macOS configuration";

  nixConfig = {
    substituters = [
      "https://cache.nixos.org"
    ];
  };
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-24.11-darwin";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:lnl7/nix-darwin/nix-darwin-24.11"; # Note the branch change
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    darwin,
    home-manager,
    ...
  }: let
    # Common configuration
    commonConfig = {
      username = "callum";
      useremail = "callumjamesteesdale@gmail.com";
    };

    # Host-specific configurations
    hosts = {
      # MacBook Air configuration
      "macbook" = {
        system = "aarch64-darwin";
        extraModules = [./hosts/macbook/configuration.nix];
      };

      # Mac Mini configuration
      "mac-mini" = {
        system = "aarch64-darwin"; # Change to x86_64-darwin if it's an Intel Mac Mini
        extraModules = [./hosts/mac-mini/configuration.nix];
      };
    };

    # Function to create a Darwin configuration
    mkDarwinConfig = {
      hostname,
      system,
      extraModules,
    }: let
      specialArgs =
        inputs
        // commonConfig
        // {
          inherit hostname;
        };
    in
      darwin.lib.darwinSystem {
        inherit system specialArgs;
        modules =
          [
            # Common modules
            ./modules/nix-core.nix
            ./modules/system.nix
            ./modules/apps.nix
            ./modules/host-users.nix

            # home manager
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = specialArgs;
              home-manager.users.${commonConfig.username} = import ./home;
            }
          ]
          ++ extraModules; # Add host-specific modules
      };
  in {
    # Create configurations for each host
    darwinConfigurations =
      builtins.mapAttrs
      (hostname: hostConfig: mkDarwinConfig (hostConfig // {inherit hostname;}))
      hosts;

    # nix code formatter
    formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.alejandra;
    formatter.x86_64-darwin = nixpkgs.legacyPackages.x86_64-darwin.alejandra;
  };
}
