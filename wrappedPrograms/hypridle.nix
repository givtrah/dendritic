{ self, ... }: {
  flake.wrappers.hypridle = {
    wlib,
    pkgs,
    ...
  }: let
    # Inline generation of the hypridle.conf file inside the Nix store
    hypridleConfig = pkgs.writeText "hypridle.conf" ''
      # ==========================================
      # SELF-CONTAINED HYPRIDLE CONFIGURATION
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
  in {
    # 1. Import the default fallback module schema
    imports = [ wlib.modules.default ];

    # 2. Bind the base upstream package
    package = pkgs.hypridle;

    # 3. Supply runtime path dependencies using your schema's key
    runtimePkgs = [
      pkgs.hyprland
      pkgs.hyprlock
    ];

    # 4. Map the configuration path via flags using your explicit syntax
    flags."--config" = toString hypridleConfig;
  };
}
