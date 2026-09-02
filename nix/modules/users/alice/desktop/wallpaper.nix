{ den, inputs, ... }: {
  flake-file.inputs.awww.url = "git+https://codeberg.org/LGFae/awww";
  den.aspects.alice._.wallpaper.homeManager = { pkgs, host, ... }: {
    services.awww = {
      enable = host.hasDesktop;
      package = inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww;
      extraArgs = [ ];
    };
    home.packages =
      if host.hasDesktop then
        [
          pkgs.waypaper
        ]
      else
        [ ];
  };
}
