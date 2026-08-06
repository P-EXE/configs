# defines all hosts + users + homes.
# then config their aspects in as many files you want
{
  # tux user at igloo host.
  den.hosts.x86_64-linux.silverslab = rec {
    users.alice = {
      wallpaperPath = "~/Pictures/Wallpapers/Clay Banks/Arizona/Wheat.jpg";
    };
    displays = [
      {
        name = "eDP-1";
        id = 0;
        friendlyName = "BOE NE135A1M-NY1";
        resolution.x = 2880;
        resolution.y = 1920;
        size.x = 290;
        size.y = 190;
        dpi = 256;
        refreshRate = 120;
        scale = 1;
        pseudoScale = 1.5;
        safeZones = {
          tl.x = 24;
          tl.y = 24;
          tr.x = 24;
          tr.y = 24;
          br.x = 12;
          br.y = 12;
          bl.x = 12;
          bl.y = 12;
        };
      }
    ];
    primaryDisplay = builtins.elemAt displays 0;
    battery = {
    };
  };

  # define an standalone home-manager for tux
  # den.homes.x86_64-linux.alice = { };

  # be sure to add nix-darwin input for this:
  # den.hosts.aarch64-darwin.apple.users.alice = { };

  # other hosts can also have user tux.
  # den.hosts.x86_64-linux.south = {
  #   wsl = { }; # add nixos-wsl input for this.
  #   users.tux = { };
  #   users.orca = { };
  # };
}
