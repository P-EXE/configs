{ den, ... }: {
  den.aspects.alice.gui.comms = { host, ... }:{
    homeManager = { pkgs, ... }: {
      programs.thunderbird = {
        enable = true;
      };
      home.packages = with pkgs; [
        vesktop
        signal-desktop
      ];
    };
  };
}