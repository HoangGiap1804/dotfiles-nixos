{ config, pkgs, ...}:

{
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    modesetting.enable = true;

    powerManagement.enable = false;

    open = false; # dùng driver proprietary

    nvidiaSettings = true;
  };
  hardware.nvidia.prime = {
    sync.enable = true;

    intelBusId = "PCI:0:2:0";   # check bằng lspci
    nvidiaBusId = "PCI:1:0:0";  # check bằng lspci
  };
  hardware.opengl.enable = true;
}
