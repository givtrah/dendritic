{ inputs, self, ... }: {
  
  flake.wrappers.swayidle = {
    wlib,
    pkgs,
    ...
  }: {
    # 1. Import the official upstream swayidle wrapper module
    imports = [ wlib.wrapperModules.swayidle ];

    config = {
      # 2. Assign the underlying package core layer
      package = pkgs.swayidle;

      # 3. Supply runtime dependency path lookups for your scripts
      runtimePkgs = with pkgs; [
        wlopm
        brightnessctl
        systemd
      ];

      # 4. Feed your event triggers straight to the wrapper settings block
      events = {
        # Master Execution Controls
        lock = "loginctl lock-session";
        before-sleep = "loginctl lock-session";
      };
      # Event Timers Sequence
      timeouts = [
        # Timeout 1: 15 Minutes (900s) -> Run Lock Routine
        {
          timeout = 900;
          command = "loginctl lock-session";
        }
        # Timeout 2: 20 Minutes (1200s) -> Power Off Screen
        {
          timeout = 1200;
          command = "wlopm --off *";
          resumeCommand = "wlopm --on * && brightnessctl -r";
        }
      ];
    };
  };
}
