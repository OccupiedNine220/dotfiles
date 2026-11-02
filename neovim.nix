{ pkgs, ... }:

{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    colorschemes.tokyonight = {
      enable = true;
      settings.style = "night";
    };

    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    opts = {
      number = true;
      relativenumber = true;
      expandtab = true;
      shiftwidth = 4;
      tabstop = 4;
      smartindent = true;
      termguicolors = true;
      signcolumn = "yes";
      cursorline = true;
      scrolloff = 8;
      ignorecase = true;
      smartcase = true;
      undofile = true;
      updatetime = 250;
      splitright = true;
      splitbelow = true;
      clipboard = "unnamedplus";
      wrap = true;
      linebreak = true;
      colorcolumn = "80,120";
      autowrite = true;
    };

    autoCmd = [
      {
        event = "FileType";
        pattern = [
          "nix"
          "yaml"
          "javascript"
          "typescript"
          "javascriptreact"
          "typescriptreact"
          "json"
          "html"
          "css"
          "lua"
        ];
        command = "setlocal shiftwidth=2 tabstop=2";
      }
    ];

    extraConfigLua = ''
      if vim.lsp.inlay_hint then
        vim.lsp.inlay_hint.enable(true)
      end
    '';

    extraPackages = with pkgs; [
      nixfmt
      black
      prettier
      rustfmt
      rust-analyzer
      ripgrep
      fd
    ];

    plugins = {
      web-devicons.enable = true;

      treesitter = {
        enable = true;
        settings = {
          highlight.enable = true;
          indent.enable = true;
        };
        grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          nix
          python
          rust
          javascript
          typescript
          tsx
          json
          html
          css
          lua
          markdown
          bash
          toml
          yaml
        ];
      };

      lsp = {
        enable = true;
        servers = {
          nixd.enable = true;
          pyright.enable = true;
          ts_ls.enable = true;
          eslint.enable = true;
          rust_analyzer = {
            enable = true;
            installCargo = false;
            installRustc = false;
            settings.check.command = "clippy";
          };
        };
        keymaps = {
          silent = true;
          lspBuf = {
            gd = "definition";
            gD = "declaration";
            gr = "references";
            gi = "implementation";
            K = "hover";
            "<leader>rn" = "rename";
            "<leader>ca" = "code_action";
          };
          diagnostic = {
            "[d" = "goto_prev";
            "]d" = "goto_next";
            "<leader>e" = "open_float";
          };
        };
      };

      conform-nvim = {
        enable = true;
        settings = {
          formatters_by_ft = {
            nix = [ "nixfmt" ];
            python = [ "black" ];
            javascript = [ "prettier" ];
            typescript = [ "prettier" ];
            javascriptreact = [ "prettier" ];
            typescriptreact = [ "prettier" ];
            json = [ "prettier" ];
            html = [ "prettier" ];
            css = [ "prettier" ];
            rust = [ "rustfmt" ];
          };
          format_on_save = {
            timeout_ms = 500;
            lsp_format = "fallback";
          };
        };
      };

      blink-cmp = {
        enable = true;
        settings = {
          keymap.preset = "default";
          sources.default = [ "lsp" "path" "snippets" "buffer" ];
          completion.documentation.auto_show = true;
        };
      };
      friendly-snippets.enable = true;

      oil = {
        enable = true;
        settings = {
          view_options.show_hidden = true;
          default_file_explorer = true;
        };
      };

      gitsigns = {
        enable = true;
        settings.current_line_blame = false;
      };
      neogit = {
        enable = true;
        settings.integrations.diffview = true;
      };
      diffview.enable = true;

      telescope = {
        enable = true;
        keymaps = {
          "<leader>ff" = "find_files";
          "<leader>fg" = "live_grep";
          "<leader>fb" = "buffers";
          "<leader>fh" = "help_tags";
        };
      };

      lualine.enable = true;
      which-key.enable = true;
      nvim-autopairs.enable = true;
      comment.enable = true;
      indent-blankline.enable = true;
    };

    keymaps = [
      {
        mode = "n";
        key = "-";
        action = "<cmd>Oil<CR>";
        options.desc = "Open Oil file explorer";}
      {
        mode = "n";
        key = "<leader>gg";
        action = "<cmd>Neogit<CR>";
        options.desc = "Neogit";
      }
      {
        mode = "n";
        key = "<leader>gd";
        action = "<cmd>DiffviewOpen<CR>";
        options.desc = "Git diff";
      }
      {
        mode = "n";
        key = "<Esc>";
        action = "<cmd>nohlsearch<CR>";
      }
    ];
  };
}
