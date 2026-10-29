{ den, inputs, ... }: {
  flake-file.inputs.nvf = {
    url = "github:NotAShelf/nvf";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  den.aspects.alice.coding = {
    homeManager = { config, pkgs, ... }: {
      imports = [ inputs.nvf.homeManagerModules.default ];

      programs.tmux = {
        enable = true;
        clock24 = true;
        extraConfig = "";
      };

      programs.nvf = {
        enable = true;
        settings = {
          vim = {
            theme = {
              enable = true;
              name = "gruvbox";
              style = "dark";
            };
            viAlias = false;
            vimAlias = false;
            statusline.lualine.enable = true;
            telescope.enable = true;
            autocomplete.nvim-cmp.enable = true;
            lsp.enable = true;
            languages = {
              enableTreesitter = true;
              nix.enable = true;
            };
          };
        };
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
      programs.vscode = {
        enable = false;
      };
      programs.vscodium = {
        enable = true;
      };
    };
  };
}
