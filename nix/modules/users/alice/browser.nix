{ den, inputs, ... }: {
	  flake-file = {
    inputs = {
      helium = {
        url = "github:P-EXE/helium";
        inputs.nixpkgs.follows = "nixpkgs";
      };
    };
  };
  den.aspects.alice._.desktopPrograms._.browser.homeManager = { host, pkgs, ... }: {
    programs.firefox.enable = host.hasDesktop;
		programs.chromium = {
			enable = host.hasDesktop;
			package = pkgs.ungoogled-chromium;
      #package = inputs.helium.packages.${pkgs.stdenv.hostPlatform.system}.default; # WIP
		};
  };
}