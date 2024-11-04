{
  description = "Nix for macOS configuration";

  ##################################################################################################################
  #
  # Want to know Nix in details? Looking for a beginner-friendly tutorial?
  # Check out https://github.com/ryan4yin/nixos-and-flakes-book !
  #
  ##################################################################################################################

  # the nixConfig here only affects the flake itself, not the system configuration!
  nixConfig = {
    substituters = [
      # Query the mirror of USTC first, and then the official cache.
      "https://cache.nixos.org"
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    darwin.url = "github:lnl7/nix-darwin";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
  };

  outputs = inputs @ { self, nixpkgs, darwin, home-manager, ... }: let
    # MacBook Air configuration
    mbaUsername = "callum";
    mbaUseremail = "callumjamesteesdale@gmail.com";
    mbaSystem = "aarch64-darwin";
    mbaHostname = "macbook-air";

    mbaSpecialArgs =
      inputs
      // {
        inherit mbaUsername mbaUseremail mbaHostname;
      };

    # Mac Mini configuration
    miniUsername = "callum";
    miniUseremail = "callumjamesteesdale@gmail.com";
    miniSystem = "aarch64-darwin";
    miniHostname = "mac-mini";

    miniSpecialArgs =
      inputs
      // {
        inherit miniUsername miniUseremail miniHostname;
      };
  in {
    darwinConfigurations."${mbaHostname}" = darwin.lib.darwinSystem {
      inherit mbaSystem mbaSpecialArgs;
      modules = [
        ./modules/nix-core.nix
        ./modules/system.nix
        ./modules/apps.nix
        ./modules/host-users.nix

        # home manager
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = mbaSpecialArgs;
          home-manager.users.${mbaUsername} = import ./home;
        }
      ];
    };

    darwinConfigurations."${miniHostname}" = darwin.lib.darwinSystem {
      inherit miniSystem miniSpecialArgs;
      modules = [
        ./modules/nix-core.nix
        ./modules/system.nix
        ./modules/apps.nix
        ./modules/host-users.nix

        # home manager
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = miniSpecialArgs;
          home-manager.users.${miniUsername} = import ./home;
        }
      ];
    };

    # nix code formatter
    formatter.${mbaSystem} = nixpkgs.legacyPackages.${mbaSystem}.alejandra;
    formatter.${miniSystem} = nixpkgs.legacyPackages.${miniSystem}.alejandra;
  };
}
