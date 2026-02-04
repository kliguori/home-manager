{ config, lib, pkgs, ... }:
let
  c = config.theme.colors;
  f = config.theme.fonts;
in
{
  programs.wofi = {
    enable = true;
    
    settings = {
      width = 600;
      height = 400;
      location = "center";
      show = "drun";
      prompt = "Search...";
      filter_rate = 100;
      allow_markup = true;
      no_actions = true;
      halign = "fill";
      orientation = "vertical";
      content_halign = "fill";
      insensitive = true;
      allow_images = true;
      image_size = 40;
      gtk_dark = true;
    };
    
    style = ''
      * {
        font-family: "${f.mono}";
        font-size: ${toString f.size}px;
      }

      window {
        margin: 0px;
        border: 2px solid ${c.purple};
        background-color: ${c.background};
        border-radius: 10px;
      }

      #input {
        margin: 5px;
        border: 1px solid ${c.comment};
        color: ${c.foreground};
        background-color: ${c.selection};
        border-radius: 5px;
        padding: 10px;
      }

      #inner-box {
        margin: 5px;
        border: none;
        background-color: ${c.background};
      }

      #outer-box {
        margin: 5px;
        border: none;
        background-color: ${c.background};
      }

      #scroll {
        margin: 0px;
        border: none;
      }

      #text {
        margin: 5px;
        border: none;
        color: ${c.foreground};
      }

      #entry:selected {
        background-color: ${c.selection};
        border-radius: 5px;
      }

      #entry:selected #text {
        color: ${c.purple};
        font-weight: bold;
      }
    '';
  };
}
