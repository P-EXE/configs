{ lib, den, ... }: {
  flake-file = {
    inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixConfig = {
      extra-substituters = [
        "https://nix-community.cachix.org"
        "https://cache.nixos.org/"
      ];
      extra-trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };
  #den.default.nixos.system.stateVersion = "25.11";
  #den.default.homeManager.home.stateVersion = "26.05";

  # enable hm by default
  den.schema.user.classes = lib.mkDefault [ "homeManager" ];
}
