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
    nixos = {
      users.users.yuni.extraGroups = [
        "sambagroup"
      ];
    };
    provides.to-hosts.nixos = { pkgs, ... }: { };
  };
}