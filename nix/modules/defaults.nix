{ lib, den, ... }: {
  flake-file.inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  #den.default.nixos.system.stateVersion = "25.11";
  #den.default.homeManager.home.stateVersion = "25.11";

  # enable hm by default
  den.schema.user.classes = lib.mkDefault [ "homeManager" ];
}
