flake.wrappers.bash = {
    wlib,
    pkgs,
    lib,
    config,
    ...
  }: {
    imports = [ wlib.modules.default ];
    package = pkgs.bashInteractive;

    constructFiles.myBashrc = {
      relPath = "bashrc";
      content = let
        # Extract your custom wrapped starship for the current host architecture
        myStarship = self.packages.${pkgs.stdenv.hostPlatform.system}.starship;
      in ''
        if [ -f /etc/bashrc ]; then . /etc/bashrc; fi

        # Shell Aliases
        alias nboot="sudo nixos-rebuild boot --flake . --impure"
        alias nswitch="sudo nixos-rebuild switch --flake . --impure"
        alias nsgc="sudo nix-store --gc"
        alias ngc="sudo nix-collect-garbage -d"
        alias ngc7="sudo nix-collect-garbage --delete-older-than 7d"
        alias ngc14="sudo nix-collect-garbage --delete-older-than 14d"
        
        alias cat="${lib.getExe pkgs.bat} --paging=never"
        alias ls="${lib.getExe pkgs.eza}"
        alias z="${lib.getExe pkgs.zoxide}"

        export PATH="$HOME/.cache/.bun/bin:$PATH"

        # Initialize your CUSTOM starfish instead of vanilla pkgs.starship!
        eval "$(${lib.getExe myStarship} init bash)"
      '';
    };

    flags."--rcfile" = config.constructFiles.myBashrc.path;
  };
}
