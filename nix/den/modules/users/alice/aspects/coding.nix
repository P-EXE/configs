{ den, ... }: {
  den.aspects.alice.coding = { host, ... }: {
    homeManager = { config, pkgs, ... }: {
      programs.vscode = {
        enable = false;
      };
      programs.vscodium = {
        enable = true;
      };
      programs.git = {
        enable = true;
        package = pkgs.gitFull;
        lfs.enable = true;
        settings = {
          user = {
            email = "alice@domain.top";
            name = "Alice";
          };
        };
      };
      programs.jujutsu = {
        enable = true;
        settings = {
          user = {
            email = "alice@domain.top";
            name = "Alice";
          };
        };
      };
      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
        enableFishIntegration = config.programs.fish.enable;
      };
    };
  };
}