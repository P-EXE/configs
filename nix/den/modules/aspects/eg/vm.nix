{ eg, ... }:
{
  eg.vm = {
    gui.includes = [
      eg.vm
      eg.vm-bootable.gui
    ];

    tui.includes = [
      eg.vm
      eg.vm-bootable.tui
    ];
  };
}
