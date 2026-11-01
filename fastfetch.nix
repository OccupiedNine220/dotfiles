{ config, pkgs, ... }:

{
  programs.fastfetch = {
    enable = true;

    settings = {
      "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";

      logo = {
        type = "auto";
        padding = {
          top = 1;
          left = 2;
        };
      };

      display = {
        separator = " → ";
        color = {
          keys = "magenta";
          title = "cyan";
        };
      };

      modules = [
        {
          type = "title";
          format = "{user-name-colored}@{host-name-colored}";
        }
        {
          type = "separator";
          string = "────────────────────────────────";
        }
        {
          type = "os";
          key = "󰍹 OS";
          keyColor = "blue";
        }
        {
          type = "kernel";
          key = " Kernel";
          keyColor = "blue";
        }
        {
          type = "uptime";
          key = "󰔚 Uptime";
          keyColor = "blue";
        }
        {
          type = "packages";
          key = "󰏖 Packages";
          keyColor = "yellow";
          format = "{nix-system} (system) + {nix-user} (user)";
        }
        {
          type = "shell";
          key = " Shell";
          keyColor = "yellow";
        }
        {
          type = "terminal";
          key = " Terminal";
          keyColor = "yellow";
        }
        {
          type = "wm";
          key = "󰖲 WM";
          keyColor = "green";
        }
        {
          type = "wmtheme";
          key = "󰃟 Theme";
          keyColor = "green";
        }
        {
          type = "icons";
          key = "󰀻 Icons";
          keyColor = "green";
        }
        {
          type = "cpu";
          key = "󰍛 CPU";
          keyColor = "red";
        }
        {
          type = "gpu";
          key = "󰢮 GPU";
          keyColor = "red";
        }
        {
          type = "memory";
          key = "󰑭 Memory";
          keyColor = "red";
        }
        {
          type = "disk";
          key = "󰋊 Disk";
          keyColor = "magenta";
        }
        {
          type = "localip";
          key = "󰩟 Local IP";
          keyColor = "cyan";
          format = "{ipv4}";
        }
        {
          type = "separator";
          string = "────────────────────────────────";
        }
        {
          type = "colors";
          paddingLeft = 2;
          symbol = "circle";
        }
      ];
    };
  };
}
