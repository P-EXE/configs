{ den, inputs, ... }: {
  flake-file.inputs = {
    bitwig-studio-patched = {
      url = "path:/home/alice/Projects/bitwig";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    musnix.url = "github:musnix/musnix";
  };
  den.aspects.alice._.music = {
    nixos = { pkgs, ... }: {
      nixpkgs.config.allowUnfree = true;
      imports = [
        inputs.musnix.nixosModules.musnix
      ];
    };
    homeManager = { pkgs, ... }: {
      home.packages = [
        inputs.bitwig-studio-patched.packages.${pkgs.stdenv.hostPlatform.system}.default
        pkgs.yabridge
        pkgs.yabridgectl
        pkgs.wine
      ];
      nixpkgs.overlays = [
        (
          final: prev:
          let
            nixpkgs-wine94 =
              import
                (prev.fetchFromGitHub {
                  owner = "NixOS";
                  repo = "nixpkgs";
                  rev = "f60836eb3a850de917985029feaea7338f6fcb8a"; # wineWow64Packages.stable: 9.3 -> 9.4
                  sha256 = "BpQ0tkhz0Tbgz1rN05H6zhEvJgPvPbZy554gTVShn8M=";
                })
                {
                  system = "x86_64-linux";
                };
          in
          {
            inherit (nixpkgs-wine94) yabridge yabridgectl;
          }
        )
      ];
    };
  };
}
