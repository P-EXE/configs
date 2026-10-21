{
  den,
  lib,
  eg,
  ...
}:
{
  den.aspects.bob = {
    includes =
      let
        # hack for nixf linter to keep findFile :/
        unused = den.lib.take.unused __findFile;
        __findFile = unused den.lib.__findFile;
      in
      [
        <den/primary-user>
        (<den/user-shell> "fish")
      ];
    nixos = { pkgs, ... }: {
      users.users.bob.packages = [ pkgs.vim ];
    };
    homeManager = { pkgs, ... }: {
      home.packages = [ pkgs.htop ];
    };
  };
}
