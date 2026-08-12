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
			package = pkgs.ungoogled-chromium;
			extensions = [
				{ id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; }
			];
		};
		home.packages = [
			inputs.helium
		];
  };
}