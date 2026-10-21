{ den, lib, ... }:
{
  den.hosts.x86_64-linux.igloo = {
    users.bob = { };
    users.alice = { };
  };
  den.aspects.igloo = {
    homeManager.programs.direnv.enable = true;
    nixos = { pkgs, ... }: {
      environment.systemPackages = [ pkgs.hello ];
    };
  };
}
