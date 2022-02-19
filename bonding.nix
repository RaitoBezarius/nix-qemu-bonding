{ pkgs, ... }:
{
  networking.hostName = "bonding";
  services.openssh.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 ];
  services.getty.autologinUser = "root";

  networking.bonds."bond0" = {
    interfaces = [ "eth1" "eth2" ];
    driverOptions = {
      mode = "balance-rr";
    };
  };

  networking.interfaces."bond0".useDHCP = true;

  environment.systemPackages = with pkgs; [ wget ];

  virtualisation = {
    memorySize = 2048;
    qemu.networkingOptions = [ "-nic tap,mac=02:ca:fe:f0:0d:01,script=no,downscript=no" "-nic tap,mac=02:ca:fe:f0:0d:02,script=no,downscript=no" ];
  };
}
