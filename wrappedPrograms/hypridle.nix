{ self, ... }: {
  flake.wrappers.hypridle = {
    wlib,
    pkgs,
    lib,
    ...
  }: {
    # 1. Direct package binding without module imports
    package = pkgs.hypridle;

    # 2. Re-map required path binaries for idle triggers
    runtimePkgs = [
      pkgs.hyprland 
      pkgs.hyprlock
    ];

    # 3. Use raw string injection instead of constructFiles
    extraConfig = ''
      # ==========================================
      # DYNAMIC HYPRIDLE CONFIGURATION
      # ==========================================

      general {
          lock_cmd = pidof hyprlock || hyprlock       # dbus/sysd session lock helper
          before_sleep_cmd = loginctl lock-session    # lock before device goes to sleep
          after_sleep_cmd = hyprctl dispatch dpms on  # wake up display on resume
      }

      listener {
          timeout = 300                               # 5 minutes
          on-timeout = loginctl lock-session          # command to execute when timeout has passed
      }

      listener {
          timeout = 330                               # 5.5 minutes
          on-timeout = hyprctl dispatch dpms off      # turn off display
          on-resume = hyprctl dispatch dpms on        # turn on display when activity detected
      }

      listener {
          timeout = 600                               # 10 minutes
          on-timeout = systemctl suspend              # suspend target host machine
      }
    '';
  };
}

