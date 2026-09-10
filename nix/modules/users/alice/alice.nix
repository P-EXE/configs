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
              bitwarden-desktop

              # Desktop
              # Music
              spotify
              # Notes
              obsidian
              calibre
              # Comms
              vesktop
              signal-desktop

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
        nix.settings = {
          trusted-substituters = [
            "https://nix-community.cachix.org"
            "https://cache.nixos.org/"
            "https://hydra.nixos.org/"
          ];
          trusted-public-keys = [
            "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          ];
        };
        # Home manager
        home.stateVersion = "26.11";
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
