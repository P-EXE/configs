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
    homeManager =
      { pkgs, ... }:
      let
        basePackages = with pkgs; [
          btop
          pinentry-tty
          kdePackages.kdeconnect-kde
          rbw
          nixfmt
        ];
      in
      {
        home.packages =
          if host.hasDesktop then
            with pkgs;
            [
              # System
              kdePackages.kdeconnect-kde

              # Desktop
              spotify
              obsidian
              vesktop

              # Graphics
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
            ]
            ++ basePackages
          else
            basePackages;
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
