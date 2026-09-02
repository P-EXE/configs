{ den, ... }: {
  den.aspects.alice._.coding.homeManager = { host, pkgs, ... }: {
    programs = {
      git.enable = true;
      vscodium = {
        enable = host.hasDesktop;
      };
      vscode = {
        enable = host.hasDesktop;
        package = pkgs.vscode.fhs;
      };
    };
  };
}
