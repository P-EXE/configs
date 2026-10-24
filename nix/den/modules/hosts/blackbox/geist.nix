{ den, lib, __findFile, ... }:
{
  den.aspects.blackbox.geist = {
    includes = [
      <coding>
      <virtualization>
      #<desktop/gnome>
    ];
  };
}
