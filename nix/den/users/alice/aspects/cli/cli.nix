{ den, lib, ... } : {
  den.aspects.alice.cli.includes = [
    (lib.attrValues den.aspects.alice.cli._)
  ];
}