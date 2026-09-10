{ lib, den, ... }: {
  flake-file = {
    inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixConfig = {
      trusted-substituters = [
        "https://nix-community.cachix.org"
        "https://cache.nixos.org/"
        "https://hydra.nixos.org/"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };

  # enable hm by default
  den.schema.user.classes = lib.mkDefault [ "homeManager" ];
}
