{globals, ...}: {
  environment.persistence."/persist/system" = {
    hideMounts = true;
    directories = [
      "/etc"
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/var/lib/tailscale"
    ];
    files = [
    ];
    users.${globals.username} = {
      directories = [
        ".config/BetterDiscord"
        ".config/Caprine"
        ".config/discord"
        ".config/libreoffice"
        ".config/qBittorrent"
        ".config/rclone"
        ".config/spotify"
        ".local/share/fish"
        ".local/share/honkers-railway-launcher"
        ".local/share/kwalletd"
        ".local/share/qBittorrent"
        ".local/share/Steam"
        ".ssh"
        ".steam"
        ".zen"
        "Desktop"
        "Documents"
        "Downloads"
        "Music"
        "Pictures"
        "Videos"
      ];
      files = [
        ".config/nix/nix.conf"
      ];
    };
  };
}
