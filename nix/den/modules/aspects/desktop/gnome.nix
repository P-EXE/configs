{ den, ... }: {
	den.aspects.desktop.gnome.nixos = {
		services.displayManager.gdm.enable = true;
  	services.desktopManager.gnome.enable = true;
	};
}