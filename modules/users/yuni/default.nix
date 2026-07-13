{ den, inputs, lib, ... }: {
  # user aspect
  den.aspects.yuni = {
    includes = [
      den.provides.define-user
      den.provides.primary-user
      (den.provides.user-shell "fish")
    ];
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [ 
      ];
    };
    provides.to-hosts.nixos = { pkgs, ... }: { };
  };
}