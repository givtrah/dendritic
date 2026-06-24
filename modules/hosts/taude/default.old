{ config, lib, pkgs, self, ... }:

{
  imports = [
    # Local Hardware & Device-Specific Subsystems
    ./hardware-configuration.nix
    "${builtins.fetchTarball "https://github.com/nix-community/disko/archive/master.tar.gz"}/module.nix"
    ./disko-config.nix
    
    # nixos dendritic modules (exposed by import-tree)
    self.nixosModules.all
    self.nixosModules.uwsm
    self.nixosModules.work

  ];

  # Boot Management
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Kernel version
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Kernel options and modules
  # Enable KVM / virtualization and dvd/bluray drives (sg)
  boot.kernelModules = [ "kvm-amd" "kvm-intel" "sg" ]; 

  # Ensure NFS can be mounted at boot / load NFS modules
  boot.supportedFilesystems = [ "nfs" ];


  # Networking & Bluetooth
  networking.hostName = "taude"; # Define your hostname.                                            
  # Pick only one of the below networking options.                                                  
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.              
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.  
  networking.networkmanager.wifi.powersave = false; # hopefully fixes bluetooth disconnect issues   

  networking.firewall.enable = false; # Should probably be enabled later...

  hardware.bluetooth.enable = true; # enables support for Bluetooth                                 
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot   

  # Essential services (ssh)                                                                                                  
  services.openssh.enable = true;   
  services.ratbagd.enable = true; # dbus daemon for gaming mice (DPI, mapping etc), may not be strictly needed

  # PRINTING
  services.printing.enable = true;                                                                  
  services.ipp-usb.enable = true;                                                                   
    services.avahi = {                                                                              
    enable = true;                                                                                  
    nssmdns4 = true;                                                                                
    openFirewall = true;                                                                            
  };                         


  # Misc
  # enable overdrive on amdgpu (should make it possible to set fan speed on Radeon Pro W6800)
  #	hardware.amdgpu.overdrive.enable = true;

  # Mount additional drives (not present in hardware-configuration.nix)
  fileSystems."/mnt/vm" = {                                                                        
    device = "/dev/disk/by-uuid/a6928e70-7552-4a8b-83cc-2834259c3e35";                                                         
    fsType = "btrfs";                                                                                
    options = [ # If you don't have this options attribute, it'll default to "defaults"              
      # boot options for fstab. Search up fstab mount options you can use                            
      "noatime" # performance                                                                        
      "compress=zstd:3" # best performance from normal ssd                                           
      "users" # Allows any user to mount and unmount                                                 
      "nofail" # Prevent system from failing if this drive doesn't mount                             
    ];                                                                                               
  };


system.stateVersion = "25.11"; 

}
