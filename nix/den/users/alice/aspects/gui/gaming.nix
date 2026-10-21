{ den, lib, ... } : {
  den.aspects.alice.gui.gaming = {
    includes = [
    ];
    homeManager = { pkgs, ... }: {
      home.packages = [
        pkgs.cbonsai
      ];
    };
    provides.to-hosts = {
      nixos.programs.steam.enable = true;
    };
  };
}