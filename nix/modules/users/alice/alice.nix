{
  den,
  lib,
  ...
}:
{
  den.aspects.alice = { host, ... }: {
    includes =
      if host.hasDesktop then
        [
          den.batteries.define-user
          den.batteries.primary-user
          (den.batteries.user-shell "fish")
          den.aspects.themes.archive
        ]
        ++ lib.attrValues den.aspects.alice._
      else
        [
          den.batteries.define-user
          den.batteries.primary-user
          (den.batteries.user-shell "fish")
        ];
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        # System
        btop
        pinentry-tty
        kdePackages.kdeconnect-kde
        rbw
        nixfmt

        # Desktop
        spotify
        obsidian
        vesktop

        # Graphics
        #blender
        #(blender.override {
        #	config.cudaSupport=true;
        #	config.rocmSupport=true;
        #})
        #cudaPackages.cuda_cudart # Test for blender-cuda
        #cudaPackages.cudnn # Test for blender-cuda
        freecad
        inkscape
        krita

        # Gaming
        retroarch
        #rpcs3
        pcsx2
        ppsspp

        # Audio
        mixxx
      ];
      # Drives
      services.udiskie.enable = true;
      # Fonts
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
      # Nix
      nixpkgs.config.allowUnfree = true;
      # Home manager
      home.stateVersion = "26.05";
    };
    provides.to-hosts.nixos = { pkgs, ... }: {
      nixpkgs.config.allowUnfree = true;
      # Fonts
      fonts.packages = with pkgs; [
        jetbrains-mono
      ];
      # Home manager
      home-manager.backupFileExtension = "backup";
      home-manager.overwriteBackup = true;
    };
  };
}
