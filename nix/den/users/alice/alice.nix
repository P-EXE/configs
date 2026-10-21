{
  den,
  lib,
  eg,
  ...
}:
{
  den.aspects.alice = { host, ... }: {
    includes =
      let
        # hack for nixf linter to keep findFile :/
        unused = den.lib.take.unused __findFile;
        __findFile = unused den.lib.__findFile;
      in
      [
        <den/primary-user>
        (<den/user-shell> "fish")
        <alice/gui/terminal>
        <alice/coding>
        <alice/fonts>
        <alice/files>
      ];
    nixos = { pkgs, ... }: {
      nixpkgs.config.allowUnfree = true;
      users.users.alice.initialPassword = "1";
    };
    homeManager = { pkgs, ... }: {
      nixpkgs.config.allowUnfree = true;

      xdg.mimeApps = {
        enable = true;
        defaultApplications = {
          "inode/directory" = "yazi-kitty.desktop";
          "text/html" = "helium.desktop";
          "x-scheme-handler/http" = "helium.desktop";
          "x-scheme-handler/https" = "helium.desktop";
          "x-scheme-handler/about" = "helium.desktop";
          "x-scheme-handler/unknown" = "helium.desktop";
        };
      };

      home.packages = with pkgs; [
        nix-index
        nixfmt
      ];
    };
  };
}
