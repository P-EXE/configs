{
  den,
  lib,
  ...
}:
{
  den.aspects.alice.gui = {
    includes = [
      (lib.attrValues den.aspects.alice.gui._)
      (lib.attrValues den.aspects.alice.cli._)
    ];

    homeManager = { pkgs, ... }: {
      home.packages = [
        # System
        pkgs.bitwarden-desktop
        # Comms
        pkgs.vesktop
        pkgs.signal-desktop
        # Notes
        pkgs.obsidian
        pkgs.libreoffice
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
