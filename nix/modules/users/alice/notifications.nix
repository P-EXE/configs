{ den, ... }: {
  den.aspects.alice._.notifications.homeManager.services.dunst = {
    enable = true;
    settings = {
      global = {
        monitor = 0;
        follow = "none";
        width = 300;
        height = 300;
        offset = "30x50";
        origin = "top-right";
        #transparency = 10;
        #frame_color = "#eceff1";
        background = "#000000";
        frame_width = 0;
        font = "JetBrains Mono 9";

        timeout = 1;
      };
    };
  };
}
