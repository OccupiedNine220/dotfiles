{ config, pkgs, ... }:
{
  programs.nixcord = {
    enable = true;
    config = {
        plugins = {
            alwaysAnimate.enable = true;
            alwaysTrust.enable = true;
            blurNsfw.enable = true;
            callTimer.enable = true;
            commandPalette = {
              hotkey = [ ];
            };
            customTimestamps = {
              formats = {
                enabled = false;
              };
            };
            messageLogger = {
              ignoreBots = false;
            };
            moreUserTags = {
              tagSettings = {
                administrator = {
                  enabled = false;
                };
                chatModerator = {
                  enabled = false;
                };
                moderator = {
                  enabled = false;
                };
                moderatorStaff = {
                  enabled = false;
                };
                owner = {
                  enabled = false;
                };
                voiceModerator = {
                  enabled = false;
                };
                webhook = {
                  enabled = false;
                };
                enabled = false;
              };
            };
            noDevtoolsWarning.enable = true;
            noF1.enable = true;
            openInApp.enable = true;
            randomVoice = {
              keybind = [ ];
            };
            timezones = {
              enable = true;
              askedTimezone = true;
            };
            translate = {
              enable = true;
              receivedOutput = "ru";
            };
            userMessagesPronouns.enable = true;
            vcNarrator = {
              voice = null;
            };
            youtubeAdblock.enable = true;
          };
    };
    extraConfig.plugins = {
            betterCommands = {
              allowNewlinesInCommands = true;
            };
            channelTabs = {
              noPomeloNames = false;
            };
            fontLoader = {
              applyOnClodeBlocks = false;
            };
            globalBadges = {
              showRa1ncord = true;
            };
            musicRichPresence = {
              showLastFmLogo = true;
            };
            noBlockedMessages = {
              ignoreBlockedMessages = false;
            };
            Soggy = {
              boopLink = "https://github.com/Equicord/Equibored/raw/main/sounds/soggy/honk.wav?raw=true";
              boopVolume = 0.2;
              imageLink = "https://equicord.org/assets/plugins/soggy/cat.png";
              songLink = "https://github.com/Equicord/Equibored/raw/main/sounds/soggy/song.mp3?raw=true";
              songVolume = 0.25;
              tooltipText = "the soggy";
            };
            translate = {
              shavian = true;
              sitelen = true;
              target = "en";
              toki = true;
            };

          };
    settings = {
        hardwareAcceleration = true;
      };
    discord = {
        branches = [ "canary" ];
        equicord.enable = true;
        openASAR.enable = true;
        krisp.enable = true;
    };
  };
}
