{ den, ... }: {
  den.aspects.alice._.desktop = {
    homeManager = { pkgs, host, ... }: {
      wayland.windowManager.hyprland = {
        enable = true;
        settings = {
          mod = { 
            _var = "Super";
          };
        };
        extraLuaFiles = {
          "keybinds" = ./keybinds.lua;
          "startup" = ./startup.lua;
          "monitors" = ''${ builtins.concatStringsSep " " (map (m: ''
            hl.monitor({
              output = "${m.name}",
              mode = "${toString m.resolution.x}x${toString m.resolution.y}@${toString m.refreshRate}",
              position = "${toString m.position.x}x${toString m.position.y}",
              scale = ${toString m.scale},
            })
          '') host.displays)}'';
        };
      };
    };
  };
}