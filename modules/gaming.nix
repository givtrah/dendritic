{self, inputs, ...}: {
  flake.nixosModules.gaming = {pkgs, ...}: {

    environment.systemPackages = with pkgs; [


# remoteplay
#  moonlight-qt
#  sunshine

  rusty-path-of-building
  
  eden # switch 1 emu


  # Emulation
  
#  retroarchFull # multi system with all cores (should be changed to NOT mame, but everything else)

  mednafen # multisystem emulator
  mednaffe # frontend for mednafen

#  desmume # Nintendo DS - not compiling 2024-12-29
  melonds # Nintendo DS
#  lime3ds # Nintendo 3DS
  mgba # Nintendo Gameboy Advance
  sameboy # Nintendo Gameboy, Gameboy color, Super Gameboy
#  fceux # NES
#  punes-qt6 # NES
#  snes9x-gtk # SNES
#  nanoboyadvance # Nintendo Gameboy Advance - not compiling 2
  dolphin-emu # Nintendo Gamecube / Wii / triforce
  ryubing # Nintendo Switch

#  duckstation # PS1 # moved to x86 only as it does not compil
#  pcsxr # PS1
  ppsspp-sdl-wayland # Playstation portable (wayland)
  rpcs3 # PS3
  
  maxcso # compression from iso to cso for psp and ps2 emus
 
  dosbox # Dos games
 
#  xemu # original xbox - not compiling 2025-09-09
 
  dgen-sdl # Sega Genesis / Megadrive
#  flycast # Sega Dreamcast, Naomi and Atomiswave emulator - b
roken 2025-01-06

  stella # Atari 2600
#  openmsx # MSX - not compiling 2025-08-23
#  fsuae # Amiga, not working right now
#  uae # Amiga - failed to build on 2024-12-29
  vice # C-64

#  emulationstation # Frontend currently with security issues


#  heroic # heroic launcher
#  gogdl # gog downloader for heroic

  scummvm

  mangohud

  # x86_64 ONLY
  mupen64plus
  pcsx2
  cemu
  # zsnes
  # duckstation
  # heroic

    ];

  };
}
