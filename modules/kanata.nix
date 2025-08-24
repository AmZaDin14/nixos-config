{
  boot.kernelModules = [ "uinput" ];
  hardware.uinput.enable = true;
  users.groups.uinput = {};
  services.udev.extraRules = ''
    KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput" '';
  systemd.services.kanata-internalKeyboard.serviceConfig = {
    SuplementaryGroups = [ "input" "uinput" ]; };
  services.kanata = {
    enable = true;
    keyboards.internalKeyboard = {
      devices = [
        "/dev/input/by-path/pci-0000:06:00.3-usb-0:2:1.0-event-kbd"
        "/dev/input/by-path/pci-0000:06:00.3-usbv2-0:2:1.0-event-kbd"
        "/dev/input/by-path/pci-0000:06:00.4-usb-0:3:1.0-event-kbd"
        "/dev/input/by-path/pci-0000:06:00.4-usb-0:4:1.0-event-kbd"
        "/dev/input/by-path/pci-0000:06:00.4-usbv2-0:3:1.0-event-kbd"
        "/dev/input/by-path/pci-0000:06:00.4-usbv2-0:4:1.0-event-kbd"
        "/dev/input/by-path/pci-0000:06:00.3-usb-0:2:1.0-event-kbd"
      ];
      configFile = ../.config/kanata.kbd;
    };
  };
}
