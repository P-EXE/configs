{ inputs, den, lib, __findFile ? __findFile, ... }: {
  flake-file = {
    inputs = {
      #nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.xz";
      nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
      #flake-file.url = lib.mkDefault "github:vic/flake-file";
      flake-file.url = "github:vic/flake-file";
      den.url = lib.mkDefault "github:denful/den";

      home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
      };
      darwin = {
        url = "github:nix-darwin/nix-darwin";
        inputs.nixpkgs.follows = "nixpkgs";
      };
      nixos-wsl = {
        url = "github:nix-community/nixos-wsl";
        inputs.nixpkgs.follows = "nixpkgs";
        inputs.flake-compat.follows = "";
      };
    };
    nixConfig = {
      extra-trusted-public-keys = [ 
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" 
        # Other substituters from aspects since nix cant concat them 
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="
      ];
      extra-substituters = [
        "https://nix-community.cachix.org"
        "https://cache.nixos.org/"
        # Other substituters from aspects since nix cant concat them
        "https://hyprland.cachix.org"
        "https://yazi.cachix.org"
      ];
    };
  };
  imports = [
    (inputs.flake-file.flakeModules.dendritic or { })
    (inputs.den.flakeModules.dendritic or { })
    # Namespaces
    (inputs.den.namespace "eg" true)
  ];
  den.default = { lib, config, ... }: {
    includes = [
      <den/hostname>
      <den/define-user>
      # Disable booting when running on CI on all NixOS hosts.
      #(if config ? _module.args.CI then <eg/ci-no-boot> else { })
    ];
    darwin.system.stateVersion = lib.mkDefault 6;
    nixos = {
      nix.settings = {
        trusted-users = [ "@wheel" ];
        builders-use-substitutes = true;
        extra-trusted-public-keys = [ 
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" 
          # Other substituters from aspects since nix cant concat them 
          "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="   
          "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="
        ];
        extra-trusted-substituters = [
          "https://nix-community.cachix.org"
          "https://cache.nixos.org/"
          # Other substituters from aspects since nix cant concat them
          "https://hyprland.cachix.org"
          "https://yazi.cachix.org"
        ];
        experimental-features = [ "nix-command flakes" ];
      };
      system.stateVersion = lib.mkDefault "26.05";
      home-manager.backupFileExtension = "backup";
      home-manager.overwriteBackup = true;
    };
    homeManager = {
      home.stateVersion = lib.mkDefault "26.05";
    };
  };
  # HomeManager
  den.schema.user.classes = lib.mkDefault [ "homeManager" ];
  # Enable angle brackets
  _module.args.__findFile = den.lib.__findFile;
  # Enable NH on all systems
  perSystem = { pkgs, ... }: {
    packages = den.lib.nh.denPackages { fromFlake = true; } pkgs;
  };
}
