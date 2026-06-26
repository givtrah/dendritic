{ inputs, pkgs, config, lib, ... }: {
  # Declare the aspect layout
  flake.nixosModules.uwsm = { config, pkgs, ... }: {

    # 1. Direct the environment configuration vector to the correct global UWSM directory
    # Writing this to uwsm/env.d/00-dendritic.env ensures UWSM parses it globally on session launch
    environment.etc."uwsm/env.d/00-dendritic.env".source = ./uwsm-env;

    # 2. Configure UWSM system-wide service registry
    programs.uwsm = {
      enable = true;

      # AUTOMATICALLY APPEND SYSTEM PATHS
      # This forces UWSM to safely pass down your wrapped application paths to the session environment
      ensureEntries = [
        "/run/current-system/sw/bin"
        "/etc/profiles/per-user/\${USER}/bin"
      ];

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
 #       hyprland = {
#          prettyName = "Hyprland (Lua Edition)";
#          comment = "Hyprland Compositor managed by UWSM";
#          binPath = "${inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.hyprland.wrap {
#            hostName = config.networking.hostName;
#          }}/bin/hyprland";
#        };

      };
    };

    # Enable Hyprland
    programs.hyprland = {
      enable = true;
      withUWSM = true; # with universal wayland session manager - better systemd integration
      xwayland.enable = true;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
      package = (self.wrappers.hyprland.wrap { inherit pkgs; hostName = config.networking.hostName; });
    };
  };
}
