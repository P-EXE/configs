{ den, inputs, ... }: {
  flake-file.inputs.awww.url = "git+https://codeberg.org/LGFae/awww";
  den.aspects.alice._.wallpaper.homeManager = { pkgs, ... }: {
	  services.awww = {
      enable = true;
	    package = inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww;
      extraArgs = [];
    };
    home.packages = with pkgs; [
      waypaper
    ];
  };
}