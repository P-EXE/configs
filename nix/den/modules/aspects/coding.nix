{ den, inputs, ... }: {
  flake-file.inputs.vscode-server.url = "github:nix-community/nixos-vscode-server";
  den.aspects.coding.nixos = {
    imports = [ inputs.vscode-server.nixosModules.default ];
    services.vscode-server.enable = true;
  };
}
