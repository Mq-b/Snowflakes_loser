{
	description = "Snowflake";
	nixConfig = {
		experimental-features = [ "nix-command" "flakes" ];
		substituters = [
			https://mirrors.ustc.edu.cn/nix-channels/store
			https://mirror.sjtu.edu.cn/nix-channels/store
		];
		extra-substituters = [
			https://nix-community.cachix.org
		];
		extra-trusted-pulic-key = [
			"nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
		];
	};
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		homeManager = {
			url = github:nix-community/home-manager;
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};
	outputs = inputs@{ nixpkgs, homeManager,...}:{
		nixosConfigurations = {
			"nixos" = nixpkgs.lib.nixosSystem {
				system = "x86_64-linux";
				modules = [
					./configuration.nix
					homeManager.nixosModules.home-manager {
						home-manager = {
							useGlobalPkgs = true;
							useUserPackages = true;
							users.tritium = import ./home.nix;
						};
					}
				];
			};
		};
	};
}
