{ den, lib, ... }: {
  den.aspects.admin = {
    includes = [
      den.batteries.define-user
      den.batteries.primary-user
      (den.batteries.user-shell "fish")
    ] ++ lib.attrValues den.aspects.admin._;
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
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
      home-manager.backupFileExtension = "backup";
      home-manager.overwriteBackup = true;
    };
  };
}
