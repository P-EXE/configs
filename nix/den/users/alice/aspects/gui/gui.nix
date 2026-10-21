{ den, lib, inputs, ... } : {
  flake-file = {
    inputs.spicetify-nix.url = "github:Gerg-L/spicetify-nix";
  };
  den.aspects.alice.gui = {
    includes = [
      (lib.attrValues den.aspects.alice.gui._)
      (lib.attrValues den.aspects.alice.cli._)
    ];
    homeManager = { pkgs, ... }: {
      imports = [
        inputs.spicetify-nix.homeManagerModules.default
      ];

      programs.spicetify = let
        spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
      in {
        enable = true;

        enabledExtensions = with spicePkgs.extensions; [
          adblock
          hidePodcasts
          shuffle # shuffle+ (special characters are sanitized out of extension names)
        ];
        enabledCustomApps = with spicePkgs.apps; [
          newReleases
          ncsVisualizer
        ];
        enabledSnippets = with spicePkgs.snippets; [
          rotatingCoverart
          pointer
        ];

        theme = spicePkgs.themes.text;
        colorScheme = "Spotify";
      };

      home.packages = [
        # System
        pkgs.bitwarden-desktop
        # Comms
        pkgs.vesktop
        pkgs.signal-desktop
        # Notes
        pkgs.obsidian
        pkgs.calibre
        pkgs.libreoffice
        # Media
        #pkgs.spotify
        # Graphics
        pkgs.freecad
        pkgs.inkscape
        pkgs.krita
        # Audio
        pkgs.mixxx
      ];
    };
  };
}