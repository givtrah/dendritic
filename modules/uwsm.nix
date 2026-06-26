{ inputs, pkgs, config, lib, ... }: {
  # Declare the aspect layout
  flake.nixosModules.uwsm = { config, pkgs, ... }: {
    
    # 1. Wire the env file directly to ~/.config/uwsm/env via NixOS/Home Manager config
    # Adjust this path depending on where your raw 'uwsm-env' text file sits
    environment.etc."uwsm/env".source = ./uwsm-env;

    # 2. Configure UWSM system-wide service registry
    programs.uwsm = {
      enable = true;
      waylandCompositors = {
        
        # --- MangoWM Entry ---
        mango = {
          prettyName = "MangoWM";
          comment = "Mango Window Manager managed by UWSM";
          binPath = "${inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.mango.wrap { 
            hostName = config.networking.hostName; 
          }}/bin/mango";
        };

        # --- Hyprland Entry ---
        hyprland = {
          prettyName = "Hyprland (Lua Edition)";
          comment = "Hyprland Compositor managed by UWSM";
          binPath = "${inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.hyprland.wrap {
            hostName = config.networking.hostName;
          }}/bin/hyprland";
        };

      };
    };
        # Enable Hyprland                                                                                                                                                                                                                                                
        programs.hyprland = {                                                                                 
          enable = true;                                                                              
          withUWSM = true; # with universal wayland session manager - better systemd integration      
          xwayland.enable = true;                                                                     
          portalPackage = pkgs.xdg-desktop-portal-hyprland;                                           
        };
  };
}
