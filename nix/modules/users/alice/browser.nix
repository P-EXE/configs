{ den, inputs, ... }: {
	#flake-file = {
  #  inputs = {
  #    helium = {
  #      url = "github:P-EXE/helix";
  #      inputs.nixpkgs.follows = "nixpkgs";
  #    };
  #  };
  #};
  den.aspects.alice._.browser.homeManager = { host, pkgs, ... }: {
  #  imports = [
  #    inputs.helium.homeModules.default
  #  ];
    programs.firefox = {
      enable = true;
      package = pkgs.firefox-unwrapped;
    };
  #  programs.helium = {
  #    enable = false;
  #    flags = [
  #      "--enable-features=TouchpadOverscrollHistoryNavigation"
  #      "--start-maximized"
  #    ];
  #  policies = { };
  #  };
  };
}