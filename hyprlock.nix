 { config, pkgs, ... }:


{

  sops.secrets.weather_api_key = { };

  sops.templates."weather.sh" = {
    mode = "0755";
    content = ''
      #!/bin/bash
      CITY="Kaliningrad"
      API_KEY=${config.sops.placeholder.weather_api_key}
      WEATHER_DATA=$(curl -s "http://api.openweathermap.org/data/2.5/weather?q=$CITY&appid=$API_KEY&units=metric&lang=ru")
      TEMP=$(echo "$WEATHER_DATA" | jq -r ".main.temp" | cut -d. -f1)
      ICON_CODE=$(echo "$WEATHER_DATA" | jq -r ".weather[0].icon")
      case $ICON_CODE in
        01d) ICON="" ;;
        01n) ICON="󰖔" ;;
        02d) ICON="" ;;
        02n) ICON="󰖐" ;;
        03d | 03n) ICON="󰖐" ;;
        04d | 04n) ICON="󰖐" ;;
        09d | 09n) ICON="" ;;
        10d) ICON="" ;;
        10n) ICON="" ;;
        11d | 11n) ICON="" ;;
        13d | 13n) ICON=" " ;;
        50d | 50n) ICON="" ;;
        *) ICON="" ;;
      esac
      echo "$ICON $TEMP°"
    '';
  };

  programs.hyprlock = {

    enable = true;

    settings = {

      general = {

        disable_loading_bar = true;

        hide_cursor = false;

        grace = 0;

        no_fade_in = false;

      };


      background = [

        {

          monitor = "";

          path = "/home/occupiednine220/power-lines-moon-anime-quite-night-4k-pb-1440x900.jpg";

        }

      ];


      label = [

        {

          monitor = "";

          text = ''cmd[update:1000] echo "$(date +'%H:%M')"'';

          color = "rgba(c0caf5ff)";

          font_size = 48;

          font_family = "Monocraft";

          position = "30, 80";

          halign = "left";

          valign = "bottom";

        }

        {

          monitor = "";

          text = ''cmd[update:60000] echo "$(date +'%A, %d %B')"'';

          color = "rgba(a9b1d6ff)";

          font_size = 18;

          font_family = "Monocraft";

          position = "30, 50";

          halign = "left";

          valign = "bottom";

        }

        {

          # Weather below date

          monitor = "";

          text = "cmd[update:300000] ${config.sops.templates."weather.sh".path}";

          color = "rgba(7dcfffff)";

          font_size = 20;

          font_family = "Monocraft";

          position = "30, 20";

          halign = "left";

          valign = "bottom";

        }

      ];


      input-field = [

        {

          monitor = "";

          size = "400, 60";

          outline_thickness = 3;

          dots_size = 0.25;

          dots_spacing = 0.3;

          dots_center = true;

          outer_color = "rgba(7aa2f7ee)";

          inner_color = "rgba(1a1b26dd)";

          font_color = "rgba(c0caf5ff)";

          fade_on_empty = true;

          fade_timeout = 2000;

          placeholder_text = ''<span foreground="##a9b1d6">Password</span>'';
          rounding = 0;
          hide_input = false;

          check_color = "rgba(9ece6aff)";

          fail_color = "rgba(f7768eff)";

          fail_text = ''<span foreground="##f7768e">Incorrect ($ATTEMPTS)</span>'';
          capslock_color = "rgba(f7768eff)";
          position = "0, -100";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
} 
