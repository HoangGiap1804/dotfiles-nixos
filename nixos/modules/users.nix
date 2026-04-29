{ config, pkgs, ... }:

{
  users.users.nqim = {
    isNormalUser = true;
    description = "nqim";
    extraGroups = [ 
      "networkmanager"
      "wheel" 
      "storage" 
      "plugdev" 
      "disk"
      "adbusers"
      "kvm"
    ];
    packages = with pkgs; [];
  };

  users.defaultUserShell = pkgs.fish;
}
