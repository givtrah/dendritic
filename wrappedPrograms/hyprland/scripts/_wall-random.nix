{ pkgs, wallpaperDir }:

pkgs.writeShellApplication {
  name = "wall-random";

  # Nix ensures these are available in the script's PATH at runtime
  runtimeInputs = with pkgs; [
    pywal          # for the 'wal' command
    findutils      # for 'find'
    coreutils      # for 'echo', 'test', etc.
    waypaper       # for 'waypaper'
    swaybg
  ];

  text = ''
    # Default directory - using shell expansion for HOME
    DEFAULT_DIR="${wallpaperDir}" # defined when the program is defined in mango/default.nix

    if [ -z "''${1:-}" ]; then
      DIR="$DEFAULT_DIR"
      echo "No directory provided. Using default: $DIR"
    else
      DIR="$1"
    fi

    if [ ! -d "$DIR" ]; then
      echo "Error: Directory '$DIR' not found."
      exit 1
    fi

    # Simplified the loop since we only need one random image
    IMG=$(find "$DIR" -type f | shuf -n 1)

    if [ -n "$IMG" ]; then
      waypaper --backend swaybg --wallpaper "$IMG"
      wal -n --cols16 lighten -i "$IMG"
    else
      echo "No files found in $DIR"
      exit 1
    fi
  '';
}

