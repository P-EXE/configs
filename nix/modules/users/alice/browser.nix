{ den, inputs, ... }: {
	  flake-file = {
    inputs = {
      helium = {
        url = "github:P-EXE/helium";
        inputs.nixpkgs.follows = "nixpkgs";
      };
    };
  };
  den.aspects.alice._.browser.homeManager = { pkgs, ... }: {
    programs.firefox.enable = true;
		programs.chromium = {
			enable = true;
			package = inputs.helium.packages.${pkgs.stdenv.hostPlatform.system}.default;
		};
  };
}