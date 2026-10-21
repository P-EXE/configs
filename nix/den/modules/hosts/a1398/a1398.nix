{ lib, ... }:
{
  den.hosts.a1398 = {
    system = "x86_64-darwin";
    users.alice = { };
  };
  den.aspects.a1398 = {
    darwin = {
    };
    homeManager = {};
  };
}
