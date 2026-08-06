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
        };
      };
    };
  };
}