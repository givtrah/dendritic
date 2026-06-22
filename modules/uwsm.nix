{ lib, ... }: {
  # Declare the aspect layout
  flake.nixosModules.uwsm = { config, pkgs, ... }: {
    
    # 1. Wire the env file directly to ~/.config/uwsm/env via NixOS/Home Manager config
    # Adjust this path depending on where your raw 'uwsm-env' text file sits
    environment.etc."uwsm/env".source = ../wrappedPrograms/mango/uwsm-env;

    # 2. Configure UWSM system-wide service registry
    programs.uwsm = {
      enable = true;
      waylandCompositors = {
        mango = {
          prettyName = "MangoWM";
          comment = "Mango Window Manager managed by UWSM";
          
          # Dynamically map the path using sessionPackages so it points to your wrapper automatically
          binPath = "${config.hardware.displayManager.sessionPackages}/bin/mango";
        };
      };
    };

  };
}
