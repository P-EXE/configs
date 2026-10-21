{ den, ... }: {
  den.aspects.alice.fonts = {
    homeManager = {
      fonts.fontconfig = {
        enable = true;
        antialiasing = true;
        hinting = "full";
        subpixelRendering = "rgb";
        defaultFonts.monospace = [
          "JetBrains Mono"
        ];
        defaultFonts.sansSerif = [ ];
        defaultFonts.serif = [ ];
      };
    };
    nixos = { pkgs, ... }: {
      fonts.packages = [
        pkgs.jetbrains-mono
        pkgs.nerd-fonts.jetbrains-mono
      ];
    };
  };
}