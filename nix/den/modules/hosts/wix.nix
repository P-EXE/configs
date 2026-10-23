{ den, lib, __findFile, ... }: {
  den.hosts.wix = {
    system = "x86_64-linux";
    wsl = {
      enable = true;
      defaultUser = "nixos";
    };
    users.alice = {};
    hasDesktop = false;
    monitors = [
      {
        name = "eDP-1";
        resolution.x = 1920;
        resolution.y = 1080;
        refreshRate = 60;
        position.x = 0;
        position.y = 0;
        safeZones.tl.x = 0;
        safeZones.tl.y = 0;
        safeZones.tr.x = 0;
        safeZones.tr.y = 0;
        safeZones.br.x = 0;
        safeZones.br.y = 0;
        safeZones.bl.x = 0;
        safeZones.bl.y = 0;
        scale = 1.0;
        pseudoScale = 1.0;
        colorSpace = "srgb";
      }
    ];
  };
  den.aspects.wix = {
    includes = [
      <displayManager/tuigreet>
      <desktop/hyprland>
      <virtualization>
      <stm32>
      (den.lib.policy.when
        (
          { user, ... }:
          lib.hasAttrByPath [ user.name "gui" ] den.aspects
        )
        (
          den.lib.policy.mkPolicy "gui-package-user" (
            { user, ... }: [
              (den.lib.policy.include [
                den.aspects.${user.name}.gui
              ])
            ]
          )
        )
      )
    ];
    nixos = {
      imports = [
        #<nixos-wsl/modules>
      ];
      nix.settings.experimental-features = [ "nix-command" "flakes" ];
      #wsl.enable = true;
      #wsl.defaultUser = "nixos";
      system.stateVersion = "26.05";
    };
  };
}
