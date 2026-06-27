{ inputs, pkgs, config, lib, ... }: {
  flake.nixosModules.uwsm = { config, pkgs, ... }: {
    
    # 1. Unified Environment Config for Scale, Theming, and $PATH
    environment.etc."uwsm/env.d/00-dendritic.env".text = ''
      export NIXOS_OZONE_WL="1"
      export ELECTRON_OZONE_PLATFORM_HINT="wayland"
      export OZONE_PLATFORM="wayland"
      export MOZ_ENABLE_WAYLAND="1"
      export GDK_BACKEND="wayland,x11,*"
      export QT_QPA_PLATFORM="wayland;xcb"
      export GDK_SCALE="2"
      
      # Restore wrapped program paths dynamically via the running shell
      export PATH="/run/current-system/sw/bin:/etc/profiles/per-user/$USER/bin:$PATH"
    '';

    # 2. Feed your custom wrapper directly into UWSM
    programs.uwsm = {
      enable = true;
      waylandCompositors = {
        
        hyprland = {
          prettyName = "Hyprland (Lua Edition)";
          comment = "Hyprland Compositor managed by UWSM";
          
          # HERE IS YOUR WRAPPER: UWSM calls this specific binary to launch the session
          binPath = "${inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.hyprland.wrap {
            hostName = config.networking.hostName;
          }}/bin/hyprland";
        };

        mango = {
          prettyName = "MangoWM";
          comment = "Mango Window Manager managed by UWSM";
          binPath = "${inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.mango.wrap { 
            hostName = config.networking.hostName; 
          }}/bin/mango";
        };
      };
    };

    # 3. System-wide Privileges & Portals (Leaves 'package' to default safely)
    programs.hyprland = {                                                                                                                                                                                                                                           
      enable = true;                                                                                                                                                                                                                                                
      withUWSM = true; # Automatically registers the desktop entries to UWSM      
      xwayland.enable = true;                                                                                                                                                                                                                                       
      portalPackage = pkgs.xdg-desktop-portal-hyprland;                                                                                                                                                                                                        
    };
  };
}
