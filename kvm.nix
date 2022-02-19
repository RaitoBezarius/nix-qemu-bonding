{ system ? builtins.currentSystem }:

let
  loadCfg = cfgFile: { config, pkgs, ...}: {
    imports = [ <nixpkgs/nixos/modules/virtualisation/qemu-vm.nix> cfgFile ];
    config = {
      virtualisation = {
        graphics = false;
      };
    };
  };
  mkCfg = cfgFile:
    import <nixpkgs/nixos/lib/eval-config.nix> {
      inherit system;
      modules = [ (loadCfg cfgFile) ];
    };
in {
  bonding = (mkCfg ./bonding.nix).config.system.build.vm;
}
