{ den, ... }: {
  den.aspects.alice._.browser.homeManager = { pkgs, ... }: {
    programs.firefox.enable = true;
		programs.chromium = {
			enable = true;
			package = pkgs.ungoogled-chromium;
			extensions = [
				{ id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; }
			];
		};
  };
}