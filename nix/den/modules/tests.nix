# Some CI checks to ensure this template always works.
# Feel free to adapt or remove when this repo is yours.
{ inputs, ... }:
{
  perSystem =
    {
      pkgs,
      self',
      lib,
      ...
    }:
    let
      checkCond = name: cond: pkgs.runCommandLocal name { } (if cond then "touch $out" else "");
    in
    {
      # checks."igloo builds" = checkCond "igloo-builds" iglooBuilds;
      # checks."apple builds" = checkCond "apple-builds" appleBuilds;
      # checks."vm builds" = checkCond "vm-builds" vmBuilds;
    };
}
