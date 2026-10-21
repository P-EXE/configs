{ lib, __findFile, ... }:
{
  den.hosts.whitebox = {
    system = "x86_64-linux";
    users.alice = { };
  };
  den.aspects.whitebox = {
    includes = [
      <desktop/hyprland>
    ];
    nixos = {
      
    };
    homeManager = {};
  };
}
