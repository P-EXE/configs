{ den, ... }: {
  den.aspects.alice.gui.terminal = { host, ... }:{
    homeManager = {
      programs.kitty = {
        enable = true;
        settings = {
			    confirm_os_window_close = 0;
		    };
      };
    };
  };
}