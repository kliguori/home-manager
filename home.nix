{ config, lib, pkgs, hostname, username, ... }:
{
  # Import all program modules
  imports = [
    ./git.nix
    ./zsh.nix
    ./starship.nix
    ./kitty.nix
    ./wofi.nix
    ./hyprland
    ./waybar
  ];
  
  # Theme options and configuration
  options.theme = {
    name = lib.mkOption {
      type = lib.types.str;
      default = "dracula";
      description = "Theme name";
    };

    colors = lib.mkOption {
      type = lib.types.attrs;
      description = "Color palette for the theme";
    };

    fonts = {
      mono = lib.mkOption {
        type = lib.types.str;
        default = "JetBrainsMono Nerd Font";
        description = "Monospace font";
      };

      ui = lib.mkOption {
        type = lib.types.str;
        default = "JetBrainsMono Nerd Font";
        description = "UI font for menus and text";
      };

      size = lib.mkOption {
        type = lib.types.int;
        default = 12;
        description = "Base font size in px";
      };
    };
  };

  config = {
    # Set Dracula theme
    theme = {
      name = "dracula";
      colors = {
        # Base colors
        background = "#282a36";
        foreground = "#f8f8f2";
        selection = "#44475a";
        comment = "#6272a4";
        
        # Accent colors
        cyan = "#8be9fd";
        green = "#50fa7b";
        orange = "#ffb86c";
        pink = "#ff79c6";
        purple = "#bd93f9";
        red = "#ff5555";
        yellow = "#f1fa8c";
        
        # Additional utility colors
        currentLine = "#44475a";
        
        # RGB versions (without #) for Hyprland
        bgRgb = "282a36";
        fgRgb = "f8f8f2";
        selectionRgb = "44475a";
        commentRgb = "6272a4";
        cyanRgb = "8be9fd";
        greenRgb = "50fa7b";
        orangeRgb = "ffb86c";
        pinkRgb = "ff79c6";
        purpleRgb = "bd93f9";
        redRgb = "ff5555";
        yellowRgb = "f1fa8c";
      };
    };

    # Home manager settings
    home.username = username;
    home.homeDirectory = "/home/${username}";
    home.stateVersion = "25.11";

    # Install fonts
    home.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      brave
      htop
      ripgrep
      fd
      bat
      eza
    ];

    programs.home-manager.enable = true;
  };
}
