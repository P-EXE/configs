{ den, lib, ... }: {
  den.aspects.admin._.git.homeManager.programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Admin Blackbox";
        email = "admin@blackbox";
      };
      init.defaultBranch = "main";
    };
  };
}
