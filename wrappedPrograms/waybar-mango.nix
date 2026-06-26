{ self, ... }: {

  flake.wrappers.waybar-mango = { wlib, pkgs, lib, config, ... }:
    
    let 
      workspacesConfigs = {
        taude = {
          on-click = "activate";
          format = "{id}";
          persistent-workspaces = {
            "DP-1" = [1 2 3 4 5 6];
            "DP-2" = [7 8 9];
          };
        };
        taupa = {
          on-click = "activate";
          format = "{id}";
          persistent-workspaces = {
            "DP-2" = [1 2 3 4 5 6];
            "DP-4" = [7 8 9];
          };
        };
        taumac = {
          on-click = "activate";
          format = "{id}";
          persistent-workspaces = { "eDP-1" = [1 2 3 4 5 6]; };
        };
        tausurf = {
          on-click = "activate";
          format = "{id}";
          persistent-workspaces = { "eDP-1" = [1 2 3 4 5 6]; };
        };
        default = {
          on-click = "activate";
          format = "{id}";
        };
      };

      # FIX: We define the 'settings' variable right here so it can be evaluated below!
      settingsData = {
        layer = "top";
        position = "bottom";
        height = null; 
        width = null; 
        margin-left = 12;
        margin-right = 12;

        modules-left = [
          "custom/distrologo"
          "ext/workspaces"
          "dwl/window"
        ];
        
        modules-center = [
          "mpris"
        ];
        
        modules-right = [
          "network"
          "memory"
          "cpu"
          "temperature"
          "pulseaudio"
          "battery"
          "tray"
          "clock"
        ];
        
        "ext/workspaces" = workspacesConfigs.${config.hostName} or workspacesConfigs.default;

        "dwl/window" = {
          format = "{title}";
          icon = true;
          icon-size = 24;
        };

        tray = {
          icon-size = 24;
          spacing = 13;
        };

        cpu = {
          format = "{usage}% ";
          tooltip = false;
          interval = 5;
          on-click = "kitty --hold bash -c btop";
        };

        memory = {
          format = "{used:0.1f}G/{total:0.1f}G ";
          format-alt = "{}% ";
        };

        network = {
          format = "U:{bandwidthUpBytes} D:{bandwidthDownBytes}";
        };
        
        clock = {
          format = "{:%H:%M %a %b %d}";
        };

        temperature = {
          hwmon-path = "/sys/class/hwmon/hwmon2/temp1_input";
          critical-threshold = 80;
          format = "{temperatureC}°C {icon}";
          format-icons = ["" "" ""];
        };

        "custom/distrologo" = {
          format = "{icon}";
          tooltip-format = "Nix OS BTW";
          tooltip = true;
          format-icons = {
            default = " ";
          };
          on-click = "kitty --hold bash -c fastfetch";
        };

        mpris = {
          format = "{player_icon} {dynamic}";
          format-paused = "{status_icon} <i>{dynamic}</i>";
          player-icons = {
            default = "▶";
            mpv = "🎵";
          };
          status-icons = {
            paused = "⏸";
          };
          dynamic-order = ["artist" "title"];
          format-len = 30;
        };

        bluetooth = {
          format = " {status}";
          format-connected = " {device_alias}";
          format-connected-battery = " {device_alias} {device_battery_percentage}%";
          tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
          tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
          tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
          on-click = "blueman-manager";
        };

        pulseaudio = {
          format = "{volume}% {icon} {format_source}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = " {icon} {format_source}";
          format-muted = " {format_source}";
          format-source = "{volume}% ";
          format-source-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = ["" "" ""];
          };
          on-click = "pavucontrol";
        };

        cava = {
          framerate = 30;
          autosens = 1;
          bars = 12;
          lower_cutoff_freq = 50;
          higher_cutoff_freq = 10000;
          method = "pulse";
          source = "auto";
          stereo = true;
          reverse = false;
          bar_delimiter = 0;
          monstercat = false;
          waves = false;
          noise_reduction = "0.6";
          input_delay = 2;
          format-icons = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█" ];
          actions = {
            on-click-right = "mode";
          };
        };
      };

    in {
      imports = [ wlib.wrapperModules.waybar ];

      options = {
        hostName = lib.mkOption {
          type = lib.types.str;
          default = "default";
          description = "The target deployment hostname for choosing workspace structures";
        };
      };

      config = {
        settings = settingsData;
        "style.css".content = builtins.readFile ./waybar-style.css;

      };
    };
}
