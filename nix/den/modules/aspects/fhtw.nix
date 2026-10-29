{ den, inputs, ... }: {
  den.aspects.fhtw = { lib, ... }: {
    includes = [] ++ lib.attrValues den.aspects.fhtw._;
    stm32 = {
      nixos = { pkgs, ... }: {
        services.udev.packages = with pkgs; [
          platformio-core.udev
          openocd
          stlink # Needed for ST-Link
        ];
      };
    };
    wireshark = {
      nixos = {
        programs.wireshark = {
          enable = true;
          dumpcap.enable = true;
          usbmon.enable = true;
        };
        users.groups.wireshark.members = [ "alice" ];
      };
    };
  };
}
