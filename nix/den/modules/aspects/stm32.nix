{ den, inputs, ... }: {
  den.aspects.stm32 = {
    nixos = { pkgs, ... }: {
      services.udev.packages = with pkgs; [
        platformio-core.udev
        openocd
        stlink # Needed for ST-Link
      ];
    };
  };
}
