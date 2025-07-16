{
  description = "NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    home-manager = { 
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri.url = "github:sodiboo/niri-flake";

    waybar.url = "github:Alexays/Waybar/master";

    yazi.url = "github:sxyazi/yazi";

		nixvim = {
        url = "github:nix-community/nixvim/nixos-25.05";
        inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, yazi, ... }: {
    nixosConfigurations.legion = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./nixos/configuration.nix # config file
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.humongoushard = import ./home-manager/humongoushard.nix;
          home-manager.extraSpecialArgs = { inherit inputs; };
        }
        ({ pkgs, ... }: {
					nixpkgs.overlays = [
						yazi.overlays.default            
						(self: super: { waybar_git = inputs.waybar.packages.${pkgs.stdenv.hostPlatform.system}.waybar; })
					];
        })
      ];
    };
  };
}
