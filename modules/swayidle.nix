# modules/swayidle.nix
{ lib, ... }: {
  
  # Register directly into your framework's global module tree
  flake.nixosModules.swayidle = { config, pkgs, ... }: {

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
