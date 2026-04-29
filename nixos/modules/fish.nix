{ config, pkgs, ... }:

{
  programs.fish = {
    enable = true;
    shellAliases = {
      nqim = "echo nqim";
    };
    loginShellInit = ''
        exec uwsm start -S hyprland-uwsm.desktop
    '';
  };
}

