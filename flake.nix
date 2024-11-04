{
  description = "Nix for macOS configuration";

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
      system = mbaSystem;
      specialArgs = mbaSpecialArgs;
      modules = [
        ./modules/nix-core.nix
        ./modules/system.nix
        ./modules/apps.nix
        (import ./modules/host-users.nix {
          username = mbaUsername;
          hostname = mbaHostname;
        })

        # home manager
        home-manager.darwinModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = mbaSpecialArgs;
          home-manager.users.${mbaUsername} = import ./home {
            username = mbaUsername;
            useremail = mbaUseremail;
          };
        }
      ];
    };

    darwinConfigurations."${miniHostname}" = darwin.lib.darwinSystem {
      system = miniSystem;
      specialArgs = miniSpecialArgs;
      modules = [
        ./modules/nix-core.nix
        ./modules/system.nix
        ./modules/apps.nix
        (import ./modules/host-users.nix {
          username = miniUsername;
          hostname = miniHostname;
        })

        # home manager
        home-manager.darwinModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = miniSpecialArgs;
          home-manager.users.${miniUsername} = import ./home {
            username = miniUsername;
            useremail = miniUseremail;
          };
        }
      ];
    };

    # nix code formatter
    formatter.${mbaSystem} = nixpkgs.legacyPackages.${mbaSystem}.alejandra;
    formatter.${miniSystem} = nixpkgs.legacyPackages.${miniSystem}.alejandra;
  };
}
