{ inputs, self, ... }: {
  
  flake.wrappers.swaylock = {
    wlib,
    pkgs,
    lib,
    config,
    ...
  }: {
    # 1. Import the official upstream swaylock wrapper module
    imports = [ wlib.wrapperModules.swaylock ];

    config = {
      # 2. Tell the wrapper layer to target the enhanced effects variant
      package = pkgs.swaylock-effects;

      # 3. Feed your structured config preferences into the wrapper settings
      settings = {
        # Backdrop aesthetics
        screenshots = true;
        clock = true;
        indicator = true;
        indicator-radius = 100;
        indicator-thickness = 7;
        
        # Blur & post-processing filters
        effect-blur = "6x2";
        effect-vignette = "0.5:0.5";
        effect-greyscale = false;
        
        # Hex palette mappings 
        color = "191414";
        bs-hl-color = "c77ea4";
        key-hl-color = "334487";
        ring-color = "151515";
        inside-color = "c8c8c8";
        text-color = "0a0a0a";
        
        # Functional flags
        grace = 0;
        fade-in = 0.2;
        hide-keyboard-layout = true;
        disable-caps-lock-text = true;
      };
    };
  };
}
