{ config, pkgs, lib, ... }:

let
  isDarwin = pkgs.stdenv.isDarwin;
in
{
  programs.ghostty = {
    enable = true;
    package = pkgs.ghostty-bin;

    settings = {
      # Auto update 
      auto-update = false;

      # Font configuration
      font-family = "JetBrains Mono";
      font-size = 14;
      font-thicken = true;
      
      # Theme and colors
      theme = "dracula";
      background-opacity = 0.95;
      
      # Window appearance (cross-platform)
      window-decoration = true;
      window-padding-x = 8;
      window-padding-y = 8;
      
      # Cursor
      cursor-style = "block";
      cursor-style-blink = false;
      
      # Shell integration
      shell-integration = "detect";
      shell-integration-features = "cursor,sudo,title";
      
      # Keybindings (works on both, but see below)
      keybind = if isDarwin then [
        "cmd+n=new_window"
        "cmd+t=new_tab"
        "cmd+w=close_surface"
        "cmd+shift+[=previous_tab"
        "cmd+shift+]=next_tab"
        "cmd+equal=increase_font_size:1"
        "cmd+minus=decrease_font_size:1"
        "cmd+0=reset_font_size"
        "cmd+c=copy_to_clipboard"
        "cmd+v=paste_from_clipboard"
      ] else [
        "ctrl+shift+n=new_window"
        "ctrl+shift+t=new_tab"
        "ctrl+shift+w=close_surface"
        "ctrl+page_up=previous_tab"
        "ctrl+page_down=next_tab"
        "ctrl+equal=increase_font_size:1"
        "ctrl+minus=decrease_font_size:1"
        "ctrl+0=reset_font_size"
        "ctrl+shift+c=copy_to_clipboard"
        "ctrl+shift+v=paste_from_clipboard"
      ];
      
      # Misc
      confirm-close-surface = false;
      quit-after-last-window-closed = !isDarwin;  # Different behavior
      copy-on-select = false;
      clipboard-read = "allow";
      clipboard-write = "allow";
    } // lib.optionalAttrs isDarwin {
      # macOS-only settings
      macos-titlebar-style = "transparent";
      macos-option-as-alt = true;
      macos-non-native-fullscreen = false;
    };
  };
}
