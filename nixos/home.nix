{self, inputs, ...}: {
  flake.nixosModules.work = {pkgs, ...}: {

	  fileSystems."/mnt/slow/media" = {
		  device = "192.168.42.42:/slow/media";
		  fsType = "nfs";
		  options = [ "x-systemd.automount" "noauto" "nfsvers=4.2" ];
	  };


	  fileSystems."/mnt/slow/backedup" = {
		  device = "192.168.42.42:/slow/backedup";
		  fsType = "nfs";
		  options = [ "x-systemd.automount" "noauto" "nfsvers=4.2" ];
	  };

	  fileSystems."/mnt/fast" = {
		  device = "192.168.42.42:/fast";
		  fsType = "nfs";
		  options = [ "x-systemd.automount" "noauto" "nfsvers=4.2" ];
	  };




    environment.systemPackages = with pkgs; [
      # HOMEONLY packages goes here

    ];

  };
}
