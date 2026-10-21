{ ... }: {
  den.schema.host = { lib, ... } : {
    options.hasDesktop = lib.mkEnableOption {
      default = false;
    };
    options.monitors = lib.mkOption {
      type = lib.types.listOf (lib.types.submodule {
        options = {
          id = lib.mkOption {
            type = lib.types.str;
            description = "Monitor id.";
          };
          name = lib.mkOption {
            type = lib.types.str;
            description = "Monitor name.";
          };
          resolution = lib.mkOption {
            type = lib.types.submodule {
              options = {
                x = lib.mkOption {
                  type = lib.types.int;
                  description = "Monitor horizontal resolution";
                  default = 1920;
                };
                y = lib.mkOption {
                  type = lib.types.int;
                  description = "Monitor vertical resolution";
                  default = 1080;
                };
              };
            };
          };
          refreshRate = lib.mkOption {
            type = lib.types.int;
            description = "The monitors refresh rate in Hz.";
            default = 60;
          };
          position = lib.mkOption {
            type = lib.types.submodule {
              options = {
                x = lib.mkOption {
                  type = lib.types.int;
                  description = "Monitor horizontal offset";
                  default = 0;
                };
                y = lib.mkOption {
                  type = lib.types.int;
                  description = "Monitor vertical offset";
                  default = 0;
                };
              };
            };
          };
          safeZones = lib.mkOption {
            type = lib.types.submodule {
              options = {
                tl.x = lib.mkOption {
                  type = lib.types.int;
                  default = 0;
                };
                tl.y = lib.mkOption {
                  type = lib.types.int;
                  default = 0;
                };
                tr.x = lib.mkOption {
                  type = lib.types.int;
                  default = 0;
                };
                tr.y = lib.mkOption {
                  type = lib.types.int;
                  default = 0;
                };
                br.x = lib.mkOption {
                  type = lib.types.int;
                  default = 0;
                };
                br.y = lib.mkOption {
                  type = lib.types.int;
                  default = 0;
                };
                bl.x = lib.mkOption {
                  type = lib.types.int;
                  default = 0;
                };
                bl.y = lib.mkOption {
                  type = lib.types.int;
                  default = 0;
                };
              };
            };
          };
          scale = lib.mkOption {
            type = lib.types.float;
            default = 1.0;
          };
          pseudoScale = lib.mkOption {
            type = lib.types.float;
            default = 1.0;
          };
          colorSpace = lib.mkOption {
            type = lib.types.str;
            default = "srgb";
          };
        };
      });
      description = "List of monitors.";
      default = [];
    };
    options.keyboards = lib.mkOption {
      type = lib.types.listOf (lib.types.submodule {
        layout = lib.mkOption {
          type = lib.types.str;
          description = "Keyboard layout";
        };
      });
    };
  };
}