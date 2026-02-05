{ config, lib, pkgs, ... }:
let
  c = config.theme.colors;
  f = config.theme.fonts;
in
{
  programs.hyprlock = {
    enable = true;
    
    settings = {
      general = {
        disable_loading_bar = true;
        hide_cursor = true;
      };
      
      background = [{
        monitor = "";
        path = "screenshot";
        blur_passes = 3;
        blur_size = 8;
      }];
      
      input-field = [{
        monitor = "";
        size = "300, 50";
        outline_thickness = 2;
        dots_size = 0.2;
        dots_spacing = 0.2;
        dots_center = true;
        
        outer_color = "rgb(${c.purpleRgb})";
        inner_color = "rgb(${c.bgRgb})";
        font_color = "rgb(${c.fgRgb})";
        check_color = "rgb(${c.greenRgb})";
        fail_color = "rgb(${c.redRgb})";
        
        placeholder_text = "<i>Password...</i>";
        
        position = "0, -20";
        halign = "center";
        valign = "center";
      }];
      
      label = [
        {
          monitor = "";
          text = "cmd[update:1000] echo \"<b>$(date +'%H:%M')</b>\"";
          color = "rgb(${c.fgRgb})";
          font_size = 64;
          font_family = f.mono;
          position = "0, 80";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = "cmd[update:1000] echo \"<b>$(date +'%A, %B %d')</b>\"";
          color = "rgb(${c.commentRgb})";
          font_size = 24;
          font_family = f.mono;
          position = "0, 40";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
