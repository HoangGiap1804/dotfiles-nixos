{ config, pkgs, ... }: 

let
  custom-sddm-astronaut = (pkgs.sddm-astronaut.override {
    embeddedTheme = "pixel_sakura";
    themeConfig = {
      Background = "Backgrounds/wallpaper2.jpeg";
      CropBackground = "true";
      DimBackground = "0.3";
      DimBackgroundColor = "#000000";

      # Text colors — trắng sáng nổi bật trên nền tối
      HeaderTextColor       = "#ffffff";
      DateTextColor         = "#ffffff";
      TimeTextColor         = "#ff4d4d";   # đỏ rực như mặt trời đỏ

      # Form fields
      FormBackgroundColor         = "#0d1117cc";
      BackgroundColor             = "#0d1117";
      LoginFieldBackgroundColor   = "#1a2233";
      PasswordFieldBackgroundColor = "#1a2233";
      LoginFieldTextColor         = "#e0e0e0";
      PasswordFieldTextColor      = "#e0e0e0";
      UserIconColor               = "#ff4d4d";
      PasswordIconColor           = "#ff4d4d";
      PlaceholderTextColor        = "#6a7a8a";
      WarningColor                = "#ff6b6b";

      # Buttons — đỏ crimson nổi bật
      LoginButtonTextColor        = "#ffffff";
      LoginButtonBackgroundColor  = "#cc2222";
      SystemButtonsIconsColor     = "#e0e0e0";
      SessionButtonTextColor      = "#e0e0e0";
      VirtualKeyboardButtonTextColor = "#e0e0e0";

      # Dropdown
      DropdownTextColor                  = "#ffffff";
      DropdownBackgroundColor            = "#1a0d0d";
      DropdownSelectedBackgroundColor    = "#cc2222";

      # Highlight
      HighlightTextColor      = "#ffffff";
      HighlightBackgroundColor = "#cc2222";
      HighlightBorderColor    = "#ff4d4d";

      # Hover — teal/cyan từ wallpaper
      HoverUserIconColor                    = "#00e5cc";
      HoverPasswordIconColor                = "#00e5cc";
      HoverSystemButtonsIconsColor          = "#00e5cc";
      HoverSessionButtonTextColor           = "#00e5cc";
      HoverVirtualKeyboardButtonTextColor   = "#00e5cc";

      HaveFormBackground = "true";
      PartialBlur        = "true";
      BlurMax            = "32";
      Blur               = "1.5";
      FormPosition       = "center";
    };
  }).overrideAttrs (oldAttrs: {
    installPhase = oldAttrs.installPhase + ''
      chmod u+w $out/share/sddm/themes/sddm-astronaut-theme/Backgrounds
      cp ${../wallpapers/wallpaper2.jpeg} \
        $out/share/sddm/themes/sddm-astronaut-theme/Backgrounds/wallpaper2.jpeg
    '';
  });

in {
  services.displayManager.sddm = {
    enable = true;
    wayland = {
      enable = true;
      compositor = "weston";
    };
    autoNumlock = true;
    enableHidpi = true;
    theme = "sddm-astronaut-theme";
    settings = {
      Theme = {
        Current = "sddm-astronaut-theme";
        CursorTheme = "Bibata-Modern-Ice";
        CursorSize = 24;
      };
    };
    extraPackages = with pkgs; [
      custom-sddm-astronaut
    ];
  };

  environment.systemPackages = with pkgs; [
    custom-sddm-astronaut
    kdePackages.qtmultimedia
  ];
}
