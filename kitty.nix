{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;

    font = {
      name = "Fira Code Nerd Font";
      size = 10.0;
    };

    settings = {
      bold_font        = "Fira Code Nerd Font Bold";
      italic_font      = "Fira Code Nerd Font Italic";
      bold_italic_font = "Fira Code Nerd Font Bold Italic";

      symbol_map = "U+E0A0-U+E0A3,U+E0C0-U+E0C7 PowerlineSymbols";
      disable_ligatures = "never";
      font_features = "none";

      # Window size
      remember_window_size  = false;
      initial_window_width  = "110c";
      initial_window_height = "28c";
      window_padding_width  = 8;
      window_border_width   = "1pt";
      draw_minimal_borders  = true;
      hide_window_decorations = false;
      placement_strategy    = "center";

      # Cursor
      cursor_shape              = "beam";
      cursor_beam_thickness     = 1.5;
      cursor_underline_thickness = 2.0;
      cursor_blink_interval     = 0.5;
      cursor_stop_blinking_after = 15.0;

      # Scrollback
      scrollback_lines              = 10000;
      scrollback_pager              = "less --chop-long-lines --RAW-CONTROL-CHARS +INPUT_LINE_NUMBER";
      scrollback_pager_history_size = 0;
      scrollback_fill_enlarged_window = false;
      wheel_scroll_multiplier       = 5.0;
      wheel_scroll_min_lines        = 1;
      touch_scroll_multiplier       = 1.0;

      # Mouse
      mouse_hide_wait       = 3.0;
      copy_on_select        = true;
      url_color             = "#7aa2f7";
      url_style             = "curly";
      open_url_with         = "default";
      strip_trailing_spaces = "smart";
      select_by_word_characters = "@-./_~?&=%+#";
      detect_urls           = true;

      # Performance
      repaint_delay  = 10;
      input_delay    = 3;
      sync_to_monitor = true;

      # Bell
      enable_audio_bell    = false;
      visual_bell_duration = "0.0";
      visual_bell_color    = "none";
      window_alert_on_bell = false;
      bell_on_tab          = "🔔 ";
      command_on_bell      = "none";
      bell_path            = "none";

      # Tab bar
      tab_bar_edge         = "top";
      tab_bar_margin_width = "0.0";
      tab_bar_style        = "powerline";
      tab_powerline_style  = "slanted";
      tab_bar_align        = "left";
      tab_bar_min_tabs     = 2;
      tab_switch_strategy  = "previous";
      tab_separator        = " ┇";
      tab_activity_symbol  = "none";
      tab_title_template   = "{fmt.fg.red}{bell_symbol}{activity_symbol}{fmt.fg.tab}{index}:{title}";

      # Tokyo Night colors
      foreground = "#c0caf5";
      background = "#1a1b26";

      selection_foreground = "#1a1b26";
      selection_background = "#33467c";

      cursor            = "#c0caf5";
      cursor_text_color  = "#1a1b26";

      active_border_color   = "#7aa2f7";
      inactive_border_color = "#414868";
      bell_border_color     = "#e0af68";

      mark1_foreground = "#1a1b26";
      mark1_background = "#7aa2f7";
      mark2_foreground = "#1a1b26";
      mark2_background = "#9ece6a";
      mark3_foreground = "#1a1b26";
      mark3_background = "#bb9af7";

      # Colors
      color0  = "#15161e";
      color8  = "#414868";
      color1  = "#f7768e";
      color9  = "#ff7a93";
      color2  = "#9ece6a";
      color10 = "#b9f27c";
      color3  = "#e0af68";
      color11 = "#ff9e64";
      color4  = "#7aa2f7";
      color12 = "#2ac3de";
      color5  = "#bb9af7";
      color13 = "#bb9af7";
      color6  = "#7dcfff";
      color14 = "#73daca";
      color7  = "#a9b1d6";
      color15 = "#c0caf5";

      # Tab bar
      active_tab_foreground   = "#1a1b26";
      active_tab_background   = "#7aa2f7";
      active_tab_font_style   = "bold";
      inactive_tab_foreground = "#a9b1d6";
      inactive_tab_background = "#24283b";
      inactive_tab_font_style = "normal";
      tab_bar_background      = "#1a1b26";
      tab_bar_margin_color    = "none";

      # Advanced
      shell   = ".";
      editor  = "nvim";
      confirm_os_window_close = 0;
      allow_remote_control    = true;
      listen_on               = "unix:/tmp/kitty";
      update_check_interval   = 0;
      clipboard_control       = "write-clipboard write-primary read-clipboard-ask read-primary-ask";
      close_on_child_death    = false;

      # Wayland
      wayland_titlebar_color = "system";
      linux_display_server   = "auto";
      wayland_enable_ime     = true;

      # Misc
      allow_hyperlinks       = true;
      term                   = "xterm-kitty";
      shell_integration      = "enabled";
      enabled_layouts        = "tall:bias=50;full_size=1;mirrored=false";
      window_resize_step_cells = 2;
      window_resize_step_lines = 2;
    };

    keybindings = {
      # Tabs
      "ctrl+shift+t"         = "new_tab";
      "ctrl+shift+w"         = "close_tab";
      "ctrl+shift+right"     = "next_tab";
      "ctrl+shift+left"      = "previous_tab";
      "ctrl+shift+."         = "move_tab_forward";
      "ctrl+shift+,"         = "move_tab_backward";
      "ctrl+shift+alt+t"     = "set_tab_title";
      "ctrl+shift+1"         = "goto_tab 1";
      "ctrl+shift+2"         = "goto_tab 2";
      "ctrl+shift+3"         = "goto_tab 3";
      "ctrl+shift+4"         = "goto_tab 4";
      "ctrl+shift+5"         = "goto_tab 5";
      "ctrl+shift+6"         = "goto_tab 6";
      "ctrl+shift+7"         = "goto_tab 7";
      "ctrl+shift+8"         = "goto_tab 8";
      "ctrl+shift+9"         = "goto_tab 9";
      # Windows
      "ctrl+shift+enter"     = "new_window";
      "ctrl+shift+n"         = "new_os_window";
      "ctrl+shift+]"         = "next_window";
      "ctrl+shift+["         = "previous_window";
      "ctrl+shift+f"         = "move_window_forward";
      "ctrl+shift+b"         = "move_window_backward";
      "ctrl+shift+`"         = "move_window_to_top";
      "ctrl+shift+r"         = "start_resizing_window";
      "ctrl+shift+x"         = "close_window";
      "ctrl+shift+l"         = "next_layout";
      # Font size
      "ctrl+shift+equal"     = "change_font_size all +1.0";
      "ctrl+shift+plus"      = "change_font_size all +1.0";
      "ctrl+shift+minus"     = "change_font_size all -1.0";
      "ctrl+shift+0"         = "change_font_size all 0";
      # Clipboard
      "ctrl+shift+c"         = "copy_to_clipboard";
      "ctrl+shift+v"         = "paste_from_clipboard";
      "shift+insert"         = "paste_from_selection";
      "ctrl+shift+s"         = "paste_from_selection";
      # Scrolling
      "ctrl+shift+up"        = "scroll_line_up";
      "ctrl+shift+k"         = "scroll_line_up";
      "ctrl+shift+down"      = "scroll_line_down";
      "ctrl+shift+j"         = "scroll_line_down";
      "ctrl+shift+page_up"   = "scroll_page_up";
      "ctrl+shift+page_down" = "scroll_page_down";
      "ctrl+shift+home"      = "scroll_home";
      "ctrl+shift+end"       = "scroll_end";
      "ctrl+shift+h"         = "show_scrollback";
      "ctrl+shift+/"         = "launch --type=overlay --stdin-source=@screen_scrollback less +G -R";
      # Hints
      "ctrl+shift+e"         = "open_url_with_hints";
      "ctrl+shift+u"         = "kitten unicode_input";
      "ctrl+shift+alt+u"     = "kitten unicode_input";
      "ctrl+shift+p>f"       = "kitten hints --type path --program -";
      "ctrl+shift+p>l"       = "kitten hints --type line --program -";
      "ctrl+shift+p>w"       = "kitten hints --type word --program -";
      "ctrl+shift+p>h"       = "kitten hints --type hash --program -";
      # Config
      "ctrl+shift+f2"        = "edit_config_file";
      "ctrl+shift+f5"        = "load_config_file";
      "ctrl+shift+f6"        = "debug_config";
      # Opacity
      "ctrl+shift+a>m"       = "set_background_opacity +0.05";
      "ctrl+shift+a>l"       = "set_background_opacity -0.05";
      "ctrl+shift+a>1"       = "set_background_opacity 1";
      "ctrl+shift+a>d"       = "set_background_opacity default";
    };
  };
}
