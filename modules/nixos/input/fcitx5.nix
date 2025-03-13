{pkgs, ...}: {
  i18n.inputMethod = {
    enable = true;
    fcitx5 = {
      addons = [
        pkgs.fcitx5-bamboo
        pkgs.fcitx5-mozc
      ];
      plasma6Support = true;
      settings = {
        globalOptions = {
          "Hotkey/EnumerateForwardKeys"."0" = "Control+Tab";
          "Hotkey/TriggerKeys" = {};
          # Behavior.PreeditEnabledByDefault = "False";
        };
        inputMethod = {
          "Groups/0" = {
            "Default Layout" = "us-altgr-intl";
            DefaultIM = "keyboard-us-altgr-intl";
            Name = "Default";
          };
          "Groups/0/Items/0".Name = "keyboard-us-altgr-intl";
          "Groups/0/Items/1".Name = "bamboo";
          "Groups/0/Items/2".Name = "mozc";
        };
      };
      waylandFrontend = true;
    };
    type = "fcitx5";
  };
}
