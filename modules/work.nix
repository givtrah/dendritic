{self, inputs, ...}: {
  flake.nixosModules.work = {pkgs, ...}: {
    networking.timeServers = [ "ntp.ku.dk" ];

# below no longer functional, FIX ME
#	  fileSystems."/mnt/slow/media" = {
#		  device = "100.86.219.83:/slow/media";
#		  fsType = "nfs";
#		  options = [ "x-systemd.automount" "noauto" "nfsvers=4.2" ];
#	  };

#	  fileSystems."/mnt/slow/backedup" = {
#		  device = "100.86.219.83:/slow/backedup";
#		  fsType = "nfs";
#		  options = [ "x-systemd.automount" "noauto" "nfsvers=4.2" ];
#	  };

#	  fileSystems."/mnt/fast" = {
#		  device = "100.86.219.83:/fast";
#		  fsType = "nfs";
#		  options = [ "x-systemd.automount" "noauto" "nfsvers=4.2" ];
#	  };


    environment.systemPackages = with pkgs; [
      # WORKONLY packages goes here

    ];

  };
}
