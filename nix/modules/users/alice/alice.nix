{ den, lib, ... }: {
  den.aspects.alice = {
    includes = [
      den.batteries.define-user
      den.batteries.primary-user
      (den.batteries.user-shell "fish")
      #den.aspects.themes.archive
    ] ++ lib.attrValues den.aspects.alice._;
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        #jetbrains-mono
      ];
      fonts.fontconfig = {
        enable = true;
        antialiasing = true;
        hinting = "full";
        subpixelRendering = "rgb";
        defaultFonts.monospace = [
          "JetBrains Mono"
        ];
        defaultFonts.sansSerif = [];
        defaultFonts.serif = [];
      };
      nixpkgs.config.allowUnfree = true;
      home.stateVersion = "26.05";
    };
    provides.to-hosts.nixos = { pkgs, ... }: {
      nixpkgs.config.allowUnfree = true;
      fonts.packages = with pkgs; [
        jetbrains-mono
      ];
      home-manager.backupFileExtension = "backup";
      home-manager.overwriteBackup = true;
    };
  };
}
