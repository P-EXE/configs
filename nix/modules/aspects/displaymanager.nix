{ den, inputs, ... }: {
  flake-file.inputs.tuigreet.url = "github:NotAShelf/tuigreet";
  den.aspects.displayManagers = {
    _.ly = {
      nixos = {
        services.displayManager.ly = {
          enable = false;
        };
      };
    };
    _.regreet = {
      nixos = {
        programs.regreet = {
          enable = true;
            # For this example you'd need to have a version of Adwaita and the font Cantarell installed
          theme.name = "Adwaita"; 
          font = {
            name = "Cantarell";
            size = 16;
          };
          cursorTheme.name = "Adwaita";
        };
      };
    };
    _.sddm = {
      nixos = {
        services.displayManager.sddm = { 
          enable = true;
          wayland.enable = true;
        };
      };
    };
    _.tuigreet = { pkgs, config, ... } : {
      services.greetd = {
        enable = true;
        settings = {
          default_session = {
            command = "${pkgs.greetd.tuigreet}/bin/tuigreet --sessions ${config.services.xserver.displayManager.sessionData.desktops}/share/xsessions:${config.services.xserver.displayManager.sessionData.desktops}/share/wayland-sessions --remember --remember-user-session";
            user = "greeter";
          };
        };
      };
    };
  };
}