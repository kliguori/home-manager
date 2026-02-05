{ config, lib, pkgs, hostname, username, system, ... }:
let
  # Platform detection
  isLinux = lib.hasInfix "linux" system;
  isDarwin = lib.hasInfix "darwin" system;
  
  # Cross-platform modules
  baseModules = [ 
    ./modules/git.nix
    ./modules/zsh.nix
    ./modules/starship.nix
    ./modules/kitty.nix
    ./modules/neovim.nix
  ];
  
  # Linux-specific modules
  linuxModules = [ 
    ./modules/wofi.nix
    ./modules/hyprland
    ./modules/waybar
  ];
  
  # macOS-specific modules
  darwinModules = [ ];
 
  # Cross-platform packages
  basePackages = with pkgs; [
    spotify
    ghostty-bin
    nerd-fonts.jetbrains-mono
    htop
    ripgrep
    fd
    bat
    eza
    tree
    jq
    wget
    curl
    # Language servers and formatters
    nixd
    nixfmt
    pyright
    black
    ruff
    julia-bin
    clang-tools
    texlab
  ];
  
  # Linux-specific packages
  linuxPackages = with pkgs; [
    wl-clipboard  # Wayland clipboard
    xclip         # X11 clipboard
  ];
  
  # macOS-specific packages
  darwinPackages = with pkgs; [ ];
in 
 { 
  # Import all program modules
  imports = baseModules 
    ++ (if isLinux then linuxModules else [])
    ++ (if isDarwin then darwinModules else []);
  
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

    # Enable home-manager
    programs.home-manager.enable = true;

    # Home manager settings
    home = {
      username = username;
      homeDirectory = if isDarwin then "/Users/${username}" else "/home/${username}";
      stateVersion = "25.11";

      # Install packages 
      packages = basePackages
        ++ (if isLinux then linuxPackages else [])
        ++ (if isDarwin then darwinPackages else []);

      # Activation script to make apps discoverable by spotlight
      activation = lib.mkIf isDarwin {
        linkApplications = lib.hm.dag.entryAfter ["writeBoundary"] ''
          echo "Linking GUI applications to ~/Applications/Nix..."
          apps_source="$HOME/.nix-profile/Applications"
          apps_target="$HOME/Applications/Nix"
          
          # Create Nix subdirectory in Applications
          mkdir -p "$apps_target"
          
          # Remove broken symlinks
          find "$apps_target" -type l ! -exec test -e {} \; -delete
          
          # Symlink all .app bundles
          if [ -d "$apps_source" ]; then
            for app in "$apps_source"/*.app; do
              if [ -e "$app" ]; then
                app_name=$(basename "$app")
                target="$apps_target/$app_name"
                
                # Only create symlink if it doesn't exist or is different
                if [ ! -e "$target" ] || [ "$(readlink "$target")" != "$app" ]; then
                  echo "  Linking $app_name"
                  ln -sf "$app" "$target"
                fi
              fi
            done
          fi
          
          echo "Application linking complete!"
        '';
      };
    };
  };
}
