{ inputs, den, ... }: {
  flake-file = {
    inputs.helium-flake.url = "github:oxcl/nix-flake-helium-browser";
  };
  den.aspects.alice.gui.browser.homeManager = { pkgs, ... }: {
    imports = [ inputs.helium-flake.homeModules.default ];
    programs.firefox.enable = true;
    programs.chromium = {
      enable = true;
      package = pkgs.ungoogled-chromium;
      extensions = [
        # chrome-web-store
        {
          id = "ocaahdebbfolfmndjeplogmgcagdmblk";
          crxPath = pkgs.fetchurl {
            url = "https://github.com/NeverDecaf/chromium-web-store/releases/latest/download/Chromium.Web.Store.crx";
            hash = "sha256-Y8B1tKJbEa8sU22tGRlG6NlUf5LVtsJXss5BONKZbzI=";
          };
          version = "1.0";
        }
      ];
    };
    programs.google-chrome.enable = true;
    programs.helium = {
      enable = true;
    };
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
        "alice" = {
          userChrome = ''
            
          '';
        };
      };
    };
  };
}
