{ den, ... }: {
  den.aspects.alice.gui.browser.librewolf.homeManager = { pkgs, ... }: {
    programs.librewolf = {
      enable = true;
      settings = {
        "webgl.disabled" = false;
        "privacy.resistFingerprinting" = true;
        "privacy.clearOnShutdown.history" = false;
        "privacy.clearOnShutdown.cookies" = true;
        "network.cookie.lifetimePolicy" = 0;
      };
      profiles = {
        default = {
          settings = {
            "browser.startup.homepage" = "https://nixos.org";
            "browser.newtabpage.pinned" = [
              {
                title = "NixOS";
                url = "https://nixos.org";
              }
            ];
          };
          userChrome = ''
            #TabsToolbar {
              display: none !important;
            }
            #sidebar-panel-header { display: none !important; }
            #sidebar-box { padding-inline-start: 0px !important; }

            * { border-radius: 0 !important;}
          '';
        };
      };
    };
  };
}
