{ den, ... }: {
  den.aspects.alice._.programs = {
		homeManager = { pkgs, ... }: {
			home.packages = with pkgs; [
				# System
				btop
				pinentry-tty
				kdePackages.kdeconnect-kde
				rbw
				nixfmt

				# Desktop
				spotify
				obsidian

				# Graphics
				blender
				#(blender.override {cudaSupport=true;})
				inkscape
				krita

				# Gaming
				retroarch
				#rpcs3
				pcsx2
				ppsspp

				# Audio
				mixxx
			];
			programs = {
        vscodium = {
					enable = true;
					#package = pkgs.vscodium;
					#package = pkgs.vscode.fhs; # enable for fhs, be aware that sudo doesn't work with fhs
				};
				vscode = {
					enable = true;
					#package = pkgs.vscodium;
					package = pkgs.vscode.fhs; # enable for fhs, be aware that sudo doesn't work with fhs
				};
				firefox.enable = true;
			};
		};
		nixos = { pkgs, lib, ... }: {
			programs.steam = {
  			enable = true;
  			remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  			dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  			localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
			};
			nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    		"steam"
    		"steam-original"
    		"steam-unwrapped"
    		"steam-run"
  		];
		};
  };
}