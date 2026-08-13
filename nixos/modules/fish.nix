{ config, pkgs, ... }:

{
  programs.fish = {
    enable = true;
    shellAliases = {
      nqim = "echo nqim";
    };
  };
}

