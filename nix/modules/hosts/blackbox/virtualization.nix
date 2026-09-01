{ den, inputs, lib, ... }: {
  den.aspects.blackbox._.virtualization = {
    includes = lib.attrValues den.aspects.virtualization._;
    _.containers = {
      nixos = {pkgs, ...}: {
        virtualisation = {
          containers.enable = true;
          docker = {
            enable = true;
            storageDriver = "btrfs";
          };
          podman = {
            enable = true;
            # Create a `docker` alias for podman, to use it as a drop-in replacement
            dockerCompat = false;
            # Required for containers under podman-compose to be able to talk to each other.
            defaultNetwork.settings.dns_enabled = true;
          };
        };
        users.extraGroups.docker.members = [ "admin" ];
        # Useful other development tools
        environment.systemPackages = with pkgs; [
          dive # look into docker image layers
          podman-tui # status of containers in the terminal
          podman-desktop
          docker-compose # start group of containers for dev
          #podman-compose # start group of containers for dev
        ];
      };
    };
    _.vm = {
      nixos = { pkgs, ...}: {
        virtualisation = {
          libvirtd = {
            enable = true;
            qemu = {
              package = pkgs.qemu_kvm;
              runAsRoot = true;
              swtpm.enable = true;
              vhostUserPackages = [ pkgs.virtiofsd ];
            };
          };
        };
        services.spice-vdagentd.enable = true;
        # QEMU stuff
        programs.dconf.enable = true;
        environment.systemPackages = with pkgs; [
          virt-manager
          virt-viewer
          spice
          spice-gtk
          spice-protocol
          virtio-win
          win-spice
        ];
        systemd.tmpfiles.rules = [ "L+ /var/lib/qemu/firmware - - - - ${pkgs.qemu}/share/qemu/firmware" ];
        users.extraGroups.libvirtd.members = [
          "alice"
        ];
      };
    };
  };
}