{ config, pkgs, ... }:
{
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      jellyfin = {
        image = "jellyfin/jellyfin:latest";
        autoStart = true;
        ports = [
          "0.0.0.0:8096:8096"
          "0.0.0.0:7359:7359/udp"
        ];
        volumes = [
          "/mnt/disk1/jellyfin/config:/config"
          "/mnt/disk1/jellyfin/cache:/cache"
          "/mnt/disk1/jellyfin/movies:/data/movies"
          "/mnt/disk1/jellyfin/shows:/data/shows"
          "/mnt/disk1/jellyfin/anime:/data/anime"
        ];
        extraOptions = [
          "--device=nvidia.com/gpu=all"
          "--ipc=host"
        ];
        environment = {
          TZ = "Europe/Kaliningrad";
          PUID = "1000";
          PGID = "100";
        };
      };
      fourget = {
        image = "luuul/4get:latest";
        autoStart = true;
        ports = [
          "0.0.0.0:8080:80"
        ];
        volumes = [
          "/mnt/disk1/4get/banners:/var/www/html/4get/banner"
        ];
        environment = {
          FOURGET_SERVER_NAME = "4get.local";
          FOURGET_PROTO = "http";
        };
      };
      navidrome = {
        image = "deluan/navidrome:latest";
        autoStart = true;
        ports = [
          "0.0.0.0:4533:4533"
        ];
        volumes = [
          "/mnt/disk1/navidrome/data:/data"
          "/mnt/disk1/navidrome/music:/music:ro"
        ];
        environment = {
          ND_LOGLEVEL = "info";
          ND_SESSIONTIMEOUT = "24h";
          ND_BASEURL = "";
          ND_ENABLESHARING = "true";
          TZ = "Europe/Kaliningrad";
        };
      };
    };
  };
  networking.firewall = {
    allowedTCPPorts = [ 8080 8096 4533 ];
    allowedUDPPorts = [ 7359 ];
  };
}
