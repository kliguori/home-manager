{ config, lib, pkgs, ... }:
let
  f = config.theme.fonts;
  c = config.theme.colors;
in
{
  programs.waybar = {
    enable = true;

    settings = [{
      layer = "top";
      position = "top";
      modules-left = [ "hyprland/workspaces" ];
      modules-center = [ "hyprland/window" ];
      modules-right = [
        "tray"
        "pulseaudio"
        "battery"
        "clock"
      ];

      clock = {
        format = "<span foreground='${c.pink}'>   </span>{:%a %d %H:%M}";
        tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      };

      battery = {
        states = {
          warning = 30;
          critical = 15;
        };
        format = "<span size='13000' foreground='${c.green}'>{icon} </span> {capacity}%";
        format-icons = [
          ""
          ""
          ""
          ""
          ""
        ];
        tooltip-format = "{time}";
      };

      pulseaudio = {
        format = "{icon}  {volume}%";
        format-muted = "";
        format-icons.default = [
          ""
          ""
          " "
        ];
        on-click = "pavucontrol";
      };

      network = {
        format-wifi = "<span size='13000' foreground='${c.cyan}'>  </span>{essid}";
        format-disconnected = "<span size='13000' foreground='${c.red}'>  </span>Disconnected";
      };
    }];

    style = ''
      * {
        font-family: "${f.mono}";
        font-size: ${toString f.size}px;
        font-weight: bold;
        color: ${c.foreground};
      }

      window#waybar {
        background-color: ${c.background};
        color: ${c.foreground};
        border-bottom: 1px solid ${c.comment};
      }

      #workspaces button {
        padding: 0 5px;
        background-color: transparent;
        color: ${c.comment};
        border: none;
        border-radius: 0;
      }

      #workspaces button.active {
        background-color: ${c.selection};
        color: ${c.purple};
        border-bottom: 2px solid ${c.purple};
      }

      #workspaces button:hover {
        background-color: ${c.selection};
        color: ${c.foreground};
      }

      #clock {
        padding: 0 10px;
        color: ${c.pink};
        border-bottom: 2px solid ${c.pink};
      }

      #pulseaudio {
        padding: 0 10px;
        color: ${c.cyan};
        border-bottom: 2px solid ${c.cyan};
      }

      #battery {
        padding: 0 10px;
        color: ${c.green};
        border-bottom: 2px solid ${c.green};
      }

      #battery.warning {
        color: ${c.orange};
        border-bottom: 2px solid ${c.orange};
      }

      #battery.critical {
        color: ${c.red};
        border-bottom: 2px solid ${c.red};
      }

      #network {
        padding: 0 10px;
        color: ${c.yellow};
        border-bottom: 2px solid ${c.yellow};
      }

      #tray {
        padding: 0 10px;
      }

      #window {
        color: ${c.purple};
      }
    '';
  };
}
