{self, inputs, ...}: {
# this is to be separated out later into separate parts

# files covered:
#
# modules/common.nix DONE
# modules/home.nix DONE - moved into home.nix, nixosModules.home
# modules/hosts.nix DONE
# modules/locale_tz.nix DONE
# modules/nemo DONE
# modules/plasma6.nix DONE
# modules/sddm.nix DONE
# modules/sound.nix DONE
# modules/users.nixa DONE
# modules/uwsm.nix DONE
# modules/work.nix DONE - moved into work.nix, nixosModules.work 

# files completely or mostly ignored:
# modules/cosmic.nix - not using
# modules/distrobox.nix - later: add distrobox, docker, podman etc. 
# modules/dropbox.nix - using maestral instead
# modules/hyprland.nix - replaced by uwsm.nix so not used
# modules/libs.nix - for using non-nix programs, prob mostly old neovim setup, excluded for now, check programs later!
# modules/llm.nix+ollama.nix - for later
# modules/onlyoffice.nix - the onlyoffice documentserver (most likely not needed)
# modules/regreet.nix - not used
# modules/sway.nix - not used
# modules/thunar.nix - not used
# modules/virt.nix - not used

# home/common DONE
# features/bash DONE (in wrapped)
# features/browsers DONE (pkgs + programs below)
# features/cli-tools DONE (added here)
# features/desktop.nix DONE (added here)
# features/dev.nix DONE (added here)

# features/flatpak DONE (services here, packages in flatpak.nix)
# features/fonts.nix DONE (here)
# features/gaming.nix DONE (moved to gaming.nix - beware no pointer size)
# f/mimetypes MISSING TO BE DONE (in general, not per user, search nix options)
# hyprland stuff - MISSING, switching to MangoWM
# f/office DONE (here)
# pywal16.nix - DONE (here) 
# f/qemu.nix - not used (so later)
# f/r.nix - LATER
# f/rofi.nix - DONE
# sway.nix - NOT USED
# swaylock.nix - later for MangoWM
# terminals - DONE (kitty only)
# waybar.nix - DONE (needs testing)
# wofi - UNUSED (using rofi)

# suggested additional programs for mangowm
# app launcher: Rofi, done
# terminal: Kitty, done
# Status bar: Waybar, need to convert to mangowm
# Desktop shell: not needed
# Wallpaper: swaybg (needs no setup?)
# notifications: swaync (needs setup, but works without)
# desktop portal: xdg-desktop-portal-wlr
# xfcepolkit?
# wlr-dpms (turn monitors off?)
# swayidle
# sway-audio-idle-inhibit
# swayosd
# wlogout
# swaylock-effects
# 
# wl-clip-persist cliphist wl-clipboard 
# wlsunset xfce-polkit swaync pamixer brightnessctl swayosd wlr-randr grim slurp satty swaylock-effects-git wlogout sox

# add swaylock audio to waybar: https://github.com/ErikReider/SwayAudioIdleInhibit

# HOSTS
# ALL MISSING

  flake.nixosModules.all = {
    pkgs,
    lib,
    ...
  }: {

    # modules that are always needed
    imports = [
      inputs.mangowm.nixosModules.mango
      inputs.nix-flatpak.nixosModules.nix-flatpak

	flake.wrappers.neovim
	flake.wrappers.mango
	flake.wrappers.waybar
	flake.wrappers.bash
	flake.wrappers.git
	flake.wrappers.kitty
	flake.wrappers.starship
	flake.wrappers.rofi
    ];

    # Enable OpenGL
    hardware.graphics.enable = lib.mkDefault true;

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;                                                                                          
                                                                                                     

    # PACKAGES SECURITY OVERRIDES (for various packages)
    nixpkgs.config.permittedInsecurePackages = [
      "SDL_ttf-2.0.11" 
		  "electron-38.8.4" # for RStudio 2026-04-04
	  ];

    # SETTINGS
    nix.settings = {
      # Enable experimental nix commands and flakes
      experimental-features = [ "nix-command" "flakes" ];
      # Fix download buffer issues
      download-buffer-size = 524288000;
      # allowed users (allowed to interact with nix daemon, this may be the default setting)
      allowed-users = [ "*" ];
      trusted-users = [ "root" "ohm" ]; # beware - needs to be changed to SOPS 
    };

    # USERS
    users = {
      # Default shell
      defaultUserShell = pkgs.bash;
      # USER
      users.ohm = {
        isNormalUser = true;
        description = "ohm";
        home = "/home/ohm"; # taken from home/common.nix
        extraGroups = [ "wheel" "networkmanager" "libvirtd" "cdrom" "optical" "audio" ]; # wheel = sudo, networkmanager = change network, libvirtd = qemu. Consider adding input (doing?), docker and video (doing?).
        shell = pkgs.bash; # superfluous
      };
    };




    # SECURITY (login and sudo related)
    # USERNAME NEEDS FIXING
    security = {
      # RealtimeKit system service - needed for pulseaudio/pipewire to acquire realtime priority (e.g. no lag)
      rtkit.enable = true;

      # KDE WALLET FIX
      # If enabled, pam_wallet will attempt to automatically unlock the user’s default KDE wallet upon login.
      # If the user has no wallet named “kdewallet”, or the login password does not match their wallet password,
      # KDE will prompt separately after login.
      pam = {
        services = {
          ohm = {
            kwallet = {
              enable = true;
              package = pkgs.kdePackages.kwallet-pam;
            };
          };
        };
      };

      sudo.extraRules = [
        {  users = [ "ohm" ];
          commands = [
            { command = "${pkgs.nixos-rebuild}/bin/nixos-rebuild";
              options = [ "NOPASSWD" "SETENV" ];
            }
            { command = "/run/current-system/sw/bin/nixos-rebuild";
              options = [ "NOPASSWD" "SETENV" ];
            }
            { command = "${pkgs.systemd}/bin/systemctl";
              options = [ "NOPASSWD" "SETENV" ];
            }
          
            # reboot and shutdown are symlinks to systemctl,
            # but need to be authorized in addition to the systemctl binary
            # to allow nopasswd sudo
            { command = "/run/current-system/sw/bin/shutdown";
              options = [ "NOPASSWD" "SETENV" ];
            }
            { command = "/run/current-system/sw/bin/reboot";
              options = [ "NOPASSWD" "SETENV" ];
            }           
          ];
        }
      ];

    };

   
    # SERVICES
    services = {
      tailscale.enable = true;

      # Enable timesync (ntp) using default (nix) servers
      timesyncd.enable = true;

      # Enable periodic scrub on btrfs (default once per month) as well as periodic trim (default once per week)
      btrfs.autoScrub.enable = true;
      fstrim.enable = true;

      # FLATPAKS
      flatpak = {
        enable = true;
        update.auto.enable = true; # Auto update
        uninstallUnmanaged = true; # WE DO NOT WANT ROGUE FLATPAKS
      };

      # Services needed for nemo file-browser
	    gvfs.enable = true;
	    tumbler.enable = true;

      # SDDM
      xserver.enable = true;

      displayManager = {
        defaultSession = "mango";

        sddm = {
          enable = true;
          wayland.enable = true;
        };
      };
      # KDE desktop fallback
      desktopManager.plasma6.enable = true;

      # needed for noctalia?
      tuned.enable = true;
      upower.enable = true;

      # SOUND
      pulseaudio.enable = false; 


      pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        wireplumber.enable = true;
      };




    };

    # HOSTS
    # Frequently used tailscale hosts
    networking.hosts = {
      "100.116.102.99" = [ "tauml" ];
		  "100.118.35.5" = [ "taupa" ];
		  "100.76.98.37" = [ "taude" ];
    };




    # TZ and locale
    time.timeZone = "Europe/Copenhagen";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_DK.UTF-8";

    i18n.extraLocaleSettings = {
      LC_ADDRESS = "da_DK.UTF-8";
      LC_IDENTIFICATION = "da_DK.UTF-8";
      LC_MEASUREMENT = "da_DK.UTF-8";
      LC_MONETARY = "da_DK.UTF-8";
      LC_NAME = "da_DK.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "da_DK.UTF-8";
      LC_TELEPHONE = "da_DK.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };

    # Configure console keymap
    console.keyMap = "dk-latin1";

    # Configure keymap in X11 
    services.xserver.xkb = {
      layout = "dk";
      variant = "";
    };

    













    # increase watchable files (to stop dropbox/maestral from blinking...)
    boot.kernel.sysctl = { "fs.inotify.max_user_watches" = "4194304"; };
    
    # Default editor
    environment.variables.EDITOR = "nvim"; # default editor is neovim

       # Setup xdg desktop portals (assuming default install is KDE?!?!? or? fix me)
    xdg = {
      portal = {
        enable = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal-wlr
          xdg-desktop-portal-gtk
        ];
      };
      # Hint electron apps to use wayland?
      menus.enable = true;
      mime.enable = true;
    };

	# Garbage collection
	  nix.gc = {
  	  automatic = true;
  	  dates = "weekly";
  	  options = "--delete-older-than 14d";
	  };

	  # Automatic optimization of the nix store periodically
	  nix.optimise.automatic = true;	



#    gtk.gtk4.theme = config.gtk.theme;  # might be a home-manager thing? Yes, not needed


    # PROGRAMS
    programs = {
      # Fix missing window decorations and terrible icon themes for gnome programs outside of gnome     
      # also needs package gnome.adwaita-icon-theme  
      dconf = {
        enable = true;
        # directories at top please GTK, please - potentially this goes into dconf.settings outside programs?
        profiles.user.databases = [
          {
            settings = {
              "org/gtk/settings/file-chooser" = {
                sort-directories-first = true;
              };
            };
          }
        ];
      };
#      uwsm = {
#        enable = true;
#        waylandCompositors = {
#          mango = {
#            prettyName = "MangoWM";
#            comment = "Mango Window Manager managed by UWSM";
#            binPath = "/run/current-system/sw/bin/mango"; # CHECK!
#          };
#        };
#      };

      # Enable Mango WM
      mango.enable = true;

      # Enable Hyprland
      hyprland = {
		    enable = true;
		    withUWSM = true; # with universal wayland session manager - better systemd integration
		    xwayland.enable = true;
		    portalPackage = pkgs.xdg-desktop-portal-hyprland; 
	    };

      # Firefox (careful?)
      firefox = {
        enable = true;
        languagePacks = [ "en-US" ];
#        configPath = "${config.xdg.configHome}/mozilla/firefox";
      };

      # BASH - careful, does this work with the wrapped module?
      bash = {
        enable = true;
        shellAliases = {
          vi = "nvim";
          sudo = "sudo "; # fix aliases not working using sudo - the space means carry over aliases
        };
      };

#      pywal = {
#        enable = true;
#        package = pkgs.pywal16; # use pywal16 instead of the org package
#      };


    };


    # FONTS
    fonts.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      ubuntu-sans
      cm_unicode
      corefonts
      unifont
      
      font-awesome
		  google-fonts
		  vista-fonts
		  noto-fonts
  	  noto-fonts-cjk-sans
  	  noto-fonts-color-emoji
  	  liberation_ttf
  	  fira-code
  	  fira-code-symbols
  	  mplus-outline-fonts.githubRelease
      #  	dina-font
      #  	proggyfonts
		  nerd-fonts.jetbrains-mono
		  nerd-fonts.fira-code
		  nerd-fonts.droid-sans-mono
		  nerd-fonts.hack
		  nerd-fonts.iosevka
    ];

    fonts.fontconfig.defaultFonts = {
      serif = ["Ubuntu Sans"];
      sansSerif = ["Ubuntu Sans"];
      monospace = ["JetBrainsMono Nerd Font"];
    };






##################################### PACKAGES ############################################
##################################### PACKAGES ############################################
##################################### PACKAGES ############################################
##################################### PACKAGES ############################################


    environment.systemPackages = with pkgs; [
      
      nixos-rebuild # needed for rebuilding

      git # git must be first when using flakes as it clones its dependencies using git
      gh
  
      curl
      wget

      cups-browsed


      # BROWSERS

      floorp-bin
      brave
      chromium
      google-chrome # beware of aarch64



      # OTHER
      pywal16

      vim # so we at least have vi - for neovim, see home-manager

      tailscale
      rclone
      # qutebrowser # backup browser just in case!

      adwaita-icon-theme # for dconf enable above, fix gnome window decorations

      wireguard-tools

      cmake
      sshfs

      # needed systemwide packages for neovim kickstart
      gnumake
      unzip
      gcc
      gcc14
      nfs-utils
 
      # Nemo file-manager
		  nemo-with-extensions
		  nemo-preview
		  nemo-emblems
		  nemo-fileroller
		  folder-color-switcher

		  file-roller # gnome desktop archive manager

      # SDDM themes (may or may not be working at all)
      sddm-chili-theme
	    elegant-sddm
	    sddm-sugar-dark
	    sddm-astronaut

      # SOUND control
      pavucontrol
      alsa-utils


      # FROM dev.nix
      vscode
      yarn
      # install via bun instead # opencode 

      devenv # for python development (any..) 
      direnv 

      nodejs
      bun



      # FROM CLI-TOOLS
      luarocks
      nnn # terminal file manager
      rename # perl-rename to use with regex
      htop
      # replacements
      eza # ls replacement (exa, maintained, aliased to ls)
      bat # cat replacement (aliased to cat)
      ripgrep # grep replacement (not aliased)
      zoxide # cd replacement (aliased to cd)
      fd # find replacement (not aliased)
      # replacements end

      dua # du improved / interactive version
      kew # command-line music player
      yt-dlp # youtube downloader

      hugo # static site generator
      glow # markdown preview in terminal
      ffmpeg
      streamlink

      killall


      # archives
      zip
      xz
      unzip
      p7zip
      unrar

      # utils
      jq # A lightweight and flexible command-line JSON processor
      yq-go # yaml processor https://github.com/mikefarah/yq
      fzf # A command-line fuzzy finder

      # networking tools
      mtr # A network diagnostic tool
      iperf3
      dnsutils  # `dig` + `nslookup`
      ldns # replacement of `dig`, it provide the command `drill`
      aria2 # A lightweight multi-protocol & multi-source command-line download utility
      socat # replacement of openbsd-netcat
      nmap # A utility for network discovery and security auditing
      ipcalc  # it is a calculator for the IPv4/v6 addresses

      # misc
      cowsay
      file
      which
  #   tree
      gnused
      gnutar
      gawk
      zstd
      gnupg

      # nix related
      #
      # it provides the command `nom` works just like `nix`
      # with more details log output
      nix-output-monitor
      
      tmux

      btop  # replacement of htop/nmon
      iotop # io monitoring
      iftop # network monitoring

      # system call monitoring
      strace # system call monitoring
      ltrace # library call monitoring
      lsof # list open files

      # system tools
      sysstat
      dmidecode # for hardware information
      inxi # for hardware information
      lm_sensors # for `sensors` command
      ethtool
      pciutils # lspci
      usbutils # lsusb

      fastfetch

      smartmontools
      #  gsmartcontrol
      # productivity / work
      autossh # FW passthrough

      # for printing
      libusb1



      # DESKTOP (GUI ONLY?) apps from desktop.nix
      libappindicator-gtk3 # required for tray icon?
    
      qview # fast af image viewer
      rapidraw # gpu accel raw image editor
      # oculante # minimalistic image viewer written in rust

      # ocrmypdf # convert image only pdf to pdf+text that's searchable


		  projectm-sdl-cpp # milkdrop audio visualizer


      lazygit

      gimp3-with-plugins
      #    deskflow

      #    amarok
      clementine
      asunder # cd ripper
      lame
      #    beets # does not compile 2024-12-29
      kid3

      amdgpu_top
      lact
      piper

      gnome-multi-writer

		  rmapi # remarkable interface
      qbittorrent

      telegram-desktop
      kdePackages.kcalc
    
      #    legcord      # uses electron! (electron-unwrapped)
      obsidian
      jellyfin-media-player # insecure 2025-08-30 since it uses qtwebengine 5.15.19 based on old chromium
      mesa-demos # includes everything in glxinfo
      #  zoom-us
      #  teams-for-linux
      vulkan-tools
      adwaita-icon-theme
      #  steam-run 
      v4l-utils
      #  guvcview
      #  nerdfonts

      inkscape

      gsmartcontrol
      # productivity / work
      kitty
      kitty-themes
      kitty-img
      starship

      #  zettlr
      remmina
      #  libsForQt5.kcalc
      #  libsForQt5.kate


      # Multimedia
      mpv
      vlc

      maestral 
      maestral-gui

      # Videorip encoding etc.
      mkvtoolnix
  


      # FONTS - from fonts.nix
      font-awesome
	  	google-fonts
	  	corefonts
	  	vista-fonts
	  	noto-fonts
    	noto-fonts-cjk-sans
    	noto-fonts-color-emoji
    	liberation_ttf
    	fira-code
    	fira-code-symbols
    	mplus-outline-fonts.githubRelease
      #   	dina-font
      #   	proggyfonts
	  	nerd-fonts.jetbrains-mono
	  	nerd-fonts.fira-code
	  	nerd-fonts.droid-sans-mono
	  	nerd-fonts.hack
	  	nerd-fonts.iosevka

      hunspell
      hunspellDicts.da_DK
      hunspellDicts.en_US



  ]

 ++
  # packages not available on aarch64 goes here 
    (if (pkgs.stdenv.hostPlatform.system == "aarch64-linux")
    then [  zotero ] # zotero-nix.packages.aarch64-linux.default]
  else
    (if (pkgs.stdenv.hostPlatform.system == "x86_64-linux")
      then [ zotero zoom-us steam-run zettlr # nomachine-client 

# makemkv not working 2026-02-28, same for calibre

    upscayl  # AI upscaler
        ]
      else []));

# teams-for-linux











  };
}
