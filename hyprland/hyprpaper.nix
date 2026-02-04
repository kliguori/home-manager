{ config, lib, pkgs, hostname, username, ... }:
let
  wallpaperPath = "/home/${username}/wallpapers/eagle.png";
  
  # Host-specific monitor configurations
  monitorConfigs = {
    # Sherlock - Desktop with 2 monitors
    sherlock = [
      "HDMI-A-1"
      "HDMI-A-2"
    ];
    
    # Watson - Laptop with single monitor
    watson = [
      "eDP-1"
    ];
    
    # Default fallback
    default = [ ];
  };
  
  # Get monitors for current host
  monitors = monitorConfigs.${hostname} or monitorConfigs.default;
  
  # Function to make list of strings "monitor,wallpaperPath" for each monitor
  mkWallpaperList = monitors: path: builtins.map (m: "${m},${path}") monitors;
in
{
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ wallpaperPath ];
      wallpaper = mkWallpaperList monitors wallpaperPath;
    };
  };
}
