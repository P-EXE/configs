# enables `nix run .#vm`. it is very useful to have a VM
# you can edit your config and launch the VM to test stuff
# instead of having to reboot each time.
{ inputs, den, ... }:
let
  hostName = "blackbox";
  userName = "alice";
in
{
  perSystem = { pkgs, ... }: {
    packages.vm = pkgs.writeShellApplication {
      name = "vm";
      text =
        let
          host = inputs.self.nixosConfigurations.${hostName}.config;
        in
        ''
          ${host.system.build.vm}/bin/run-${host.networking.hostName}-vm "$@"
        '';
    };
  };
}
