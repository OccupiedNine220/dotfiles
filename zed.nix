{ pkgs, lib, ... }:

{
  programs.zed-editor = {
    enable = true;

    extensions = [
      "tokyo-night"
      "rust"
      "toml"
      "nix"
      "yaml"
      "python-lsp"
      "discord-presence"
      "java"
      "latex"
      "github-actions"
      "git-firefly"
    ];

    userSettings = {
      theme = {
        mode = "dark";
        dark = "Tokyo Night";
        light = "Tokyo Night";
      };

      icon_theme = "Material Icon Theme";

      buffer_font_family = "Fira Code Nerd Font";
      buffer_font_size = 14;
      buffer_font_features = {
        calt = true; # лигатуры
      };
      buffer_line_height = "comfortable"; # ~1.6
      ui_font_size = 14;

      terminal = {
        font_family = "JetBrainsMono Nerd Font";
        font_size = 14;
        blinking = "on";
        cursor_shape = "bar";
        copy_on_select = true;
        scrollback_lines = 10000;
        dock = "bottom";
        working_directory = "current_project_directory";
        detect_venv = {
          on = {
            directories = [ ".env" "env" ".venv" "venv" ];
            activate_script = "default";
          };
        };
      };

      auto_update = false;
      load_direnv = "shell_hook";
      base_keymap = "VSCode";

      format_on_save = "on";

      show_whitespaces = "selection";
      show_wrap_guides = true;
      wrap_guides = [ 80 120 ];

      indent_guides = {
        enabled = true;
        line_width = 1;
        active_line_width = 2;
        coloring = "indent_aware";
      };

      tab_size = 4;
      soft_wrap = "editor_width";

      inlay_hints = {
        enabled = true;
        show_type_hints = true;
        show_parameter_hints = true;
        show_other_hints = true;
      };

      minimap = {
        enabled = true;
        show = "always";
      };

      git = {
        enabled = true;
        git_gutter = "tracked_files";
        inline_blame = {
          enabled = false; # gitlens.currentLine.enabled = false
        };
      };

      auto_save = {
        after_delay = {
          milliseconds = 1000;
        };
      };

      file_scan_exclusions = [
        "**/.git"
        "**/.DS_Store"
        "**/node_modules"
        "**/__pycache__"
        "**/.pytest_cache"
        "**/venv"
        "**/.env"
      ];

      lsp = {
        rust-analyzer = {
          binary.path_lookup = true;
          initialization_options = {
            check = {
              command = "clippy";
            };
          };
        };

        pyright = {
          binary.path_lookup = true;
        };

        yaml-language-server = {
          binary.path_lookup = true;
          settings = {
            yaml = {
              format.enable = true;
            };
          };
        };
      };

      languages = {
        "Python" = {
          language_servers = [ "pyright" ];
          formatter = {
            external = {
              command = "black";
              arguments = [ "-" ];
            };
          };
          format_on_save = "on";
        };

        "JavaScript" = {
          formatter = {
            external = {
              command = "prettier";
              arguments = [ "--stdin-filepath" "{buffer_path}" ];
            };
          };
          format_on_save = "on";
        };

        "TypeScript" = {
          formatter = {
            external = {
              command = "prettier";
              arguments = [ "--stdin-filepath" "{buffer_path}" ];
            };
          };
          format_on_save = "on";
        };

        "JSON" = {
          formatter = {
            external = {
              command = "prettier";
              arguments = [ "--stdin-filepath" "{buffer_path}" ];
            };
          };
          format_on_save = "on";
        };

        "Svelte" = {
          language_servers = [ "svelte-language-server" "typescript-language-server" ];
          formatter = {
            external = {
              command = "prettier";
              arguments = [ "--stdin-filepath" "{buffer_path}" "--plugin" "prettier-plugin-svelte" ];
            };
          };
          format_on_save = "on";
        };

        "Rust" = {
          language_servers = [ "rust-analyzer" ];
          format_on_save = "on";
        };

        "YAML" = {
          language_servers = [ "yaml-language-server" ];
          format_on_save = "off"; # в оригинале diffEditor.ignoreTrimWhitespace
        };
      };

      # Аналог todo-tree
      task = {
        show_status_indicator = true;
      };

      # Copilot отключён как в оригинале
      features = {
        inline_completion_provider = "none";
      };

      telemetry = {
        diagnostics = false;
        metrics = false;
      };

      assistant = {
        enabled = false;
        version = "2";
      };
    };
  };
}
