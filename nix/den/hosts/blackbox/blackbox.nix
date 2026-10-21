{ lib, __findFile, ... }:
{
  den.hosts.blackbox = {
    system = "x86_64-linux";
    users.alice = { };
  };
  den.aspects.blackbox = {
    includes = [
    ];
    nixos = {
      
    };
    homeManager = {};
  };
}
