{ den, lib, ... }: {
  den.aspects.admin._.vscode.homeManager = { pkgs, ... }: {
    programs.vscode = {
      enable = true;
      package = pkgs.vscode.fhs;
    };
  };
}
