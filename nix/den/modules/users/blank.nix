{
  den,
  lib,
  eg,
  ...
}:
{
  den.aspects.blank = {
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
      users.users.blank.packages = [ pkgs.htop ];
    };
    homeManager = { pkgs, ... }: {
      home.packages = [ pkgs.btop ];
    };
  };
}
