# modules/lock.nix
{ lib, ... }: {
  
  # Register directly into your framework's global module tree
  flake.nixosModules.lock = { config, pkgs, ... }: {

    # =====================================================================
    # 1. Swaylock-Effects Configuration
    # =====================================================================
    programs.swaylock = {
      enable = true;
      package = pkgs.swaylock-effects;
      settings = {
        # Recreating your blurred backdrop rules
        screenshots = true;
        clock = true;
        indicator = true;
        indicator-radius = 100;
        indicator-thickness = 7;
        
        # Blur passes & properties matching your hyprlock config
        effect-blur = "6x2";
        effect-vignette = "0.5:0.5";
        effect-greyscale = false;
        
        # Color Styling (RGB mapping matching your inputs)
        color = "191414";
        bs-hl-color = "c77ea4"; # Pulling your accent color14 from earlier steps
        key-hl-color = "334487";
        
        # Ring aesthetics
        ring-color = "151515";
        inside-color = "c8c8c8";
        text-color = "0a0a0a";
        
        # General configurations
        grace = 0;
        fade-in = 0.2;
        hide-keyboard-layout = true;
        disable-caps-lock-text = true;
      };
    };

    # =====================================================================
    # 2. Swayidle Configuration
    # =====================================================================
    services.swayidle = {
      enable = true;
      
      # Master Execution Controls
      lockCmd = "${pkgs.swaylock-effects}/bin/swaylock";
      beforeSleepCmd = "${pkgs.systemd}/bin/loginctl lock-session";
      
      # Event Timers Sequence
      timeouts = [
        # Timeout 1: 15 Minutes (900s) -> Run Lock Routine
        {
          timeout = 900;
          command = "${pkgs.systemd}/bin/loginctl lock-session";
        }
        # Timeout 2: 20 Minutes (1200s) -> Display Management Power Off
        # Note: Using modern 'wlopm' tool context which works perfectly inside MangoWM
        {
          timeout = 1200;
          command = "${pkgs.wlopm}/bin/wlopm --off \*";
          resumeCommand = "${pkgs.wlopm}/bin/wlopm --on \* && ${pkgs.brightnessctl}/bin/brightnessctl -r";
        }
      ];
    };

    # Ensure required companion utilities are globally accessible at runtime
    environment.systemPackages = with pkgs; [
      wlopm
      brightnessctl
    ];

  };
}
