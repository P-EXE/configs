{ inputs, den, lib, ... }: {
	flake-file = {
		inputs = {
			hyprland = {
				url = "github:hyprwm/Hyprland";
				inputs.nixpkgs.follows = "nixpkgs";
			};
			hyprland-plugins = {
				url = "github:hyprwm/hyprland-plugins";
				inputs.hyprland.follows = "hyprland";
			};
		};
	};
	den.aspects.desktop.hyprland = {
		includes = [
			(	
				den.lib.policy.when ({ user, ... }:
					lib.hasAttrByPath [ user.name "desktop" "hyprland" ] den.aspects
     		)
				(
					den.lib.policy.mkPolicy "desktop-hyprland-user" ({ user, ... }: [
					(den.lib.policy.include [
						den.aspects.${user.name}.desktop.hyprland
					])
					(den.lib.policy.include {
						homeManager = {
							services.hyprpolkitagent.enable = false;
							services.polkit-gnome.enable = true;
						};
					})
					])
				)
			)
		];
		nixos = { pkgs, ... }: {
			programs.hyprland = {
				enable = true;
				# set the flake package
				package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
				# make sure to also set the portal package, so that they are in sync
				portalPackage = pkgs.xdg-desktop-portal; 
					#inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
				xwayland.enable = true;
				withUWSM = true;
			};
			security.polkit.enable = true;
			environment.sessionVariables.NIXOS_OZONE_WL = "1";
		};
	};
}