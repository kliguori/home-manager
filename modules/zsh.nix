{ config, lib, pkgs, username, hostname, system, ... }:
let
  isLinux = lib.hasInfix "linux" system;
  isDarwin = lib.hasInfix "darwin" system;
in
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history = {
      size = 10000;
      save = 10000;
      extended = true;
      share = true;
    };

    shellAliases = {
      # filesystem 
      ll  = "ls -lah";
      cl   = "clear";
      ".." = "cd ..";

      # git
      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gl = "git pull";
      gd = "git diff";

      # neovim
      vi = "nvim";
      
      # nixos
      hms = "home-manager switch --flake ~/home-manager#${hostname}";
    } // lib.optionalAttrs isLinux {
      nrs = "sudo nixos-rebuild switch --flake ~/nixos-system#${hostname}";
    };
  };
}
