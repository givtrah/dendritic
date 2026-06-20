{ lib, config, pkgs, ... }:
{

  services.flatpak.packages = [
    #{ appId = "com.brave.Browser"; origin = "flathub"; }
#    "com.usebottles.bottles"
#    "org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/24.08" # CAREFUL, VERSION MIGHT BE INCOMPATIBLE WITH BOTTLES IN THE FUTUR
E!
#    "org.freedesktop.Platform.VulkanLayer.gamescope/x86_64/24.08"
    "com.github.IsmaelMartinez.teams_for_linux"
    "com.github.tchx84.Flatseal"
		"org.onlyoffice.desktopeditors" # Onlyoffice (should work on both x86_64 and aarch64 platforms)
#		"com.collaboraoffice.Office" # Collabora office (currently plugins not working, should work on x86_64 and aarch64 pl
atforms) - fucking horrible shit show, do not use for now 2026-06-03
		"org.libreoffice.LibreOffice" # should work on both x86_64 and aarch64

		"com.valvesoftware.Steam"

    "com.heroicgameslauncher.hgl"

    "org.freedesktop.Platform.VulkanLayer.MangoHud"


#    "xyz.armcord.ArmCord"
    

  ];



}
