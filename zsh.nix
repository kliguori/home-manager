{ config, pkgs, hostname, ... }:
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
      rebuild-system = "sudo nixos-rebuild switch --flake .#${hostname}";
      rebuild-home = "home-manager switch --flake .#${hostname}";
    };
  };
}
