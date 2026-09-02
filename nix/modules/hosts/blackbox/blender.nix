{ den, ... }: {
  den.aspects.blackbox._.blender = {
    providesTo.homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        (blender.override {
          config.cudaSupport = true;
          config.rocmSupport = false;
        })
      ];
    };
  };
}
