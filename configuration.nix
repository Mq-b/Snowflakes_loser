{ config, lib, pkgs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
    ];
  boot.loader = {
    efi.canTouchEfiVariables = true;
    efi.efiSysMountPoint = "/boot";
    grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
    extraEntries = ''
      menuentry "Windows 11" {
        search --file --no-floppy --set=root /EFI/Microsoft/Boot/bootmgfw.efi
        chainloader (''${root})/EFI/Microsoft/Boot/bootmgfw.efi
      }
     '';
    };
  };
  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  time.timeZone = "Asia/Shanghai";
  i18n.defaultLocale = "en_US.UTF-8";
  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  environment.systemPackages = with pkgs; [
  neovim alacritty git curl
];
users.users.tritium = {
	isNormalUser = true;
	home = /home/tritium;
	description = "Tritium's home";
	extraGroups = [ "wheel" "networkmanager" ];
};
sound.enable = true;
hardware.pulseaudio.enable = true;
nix.settings.trusted-users = [ "tritium" ];
nix.settings.substituters = [ "https://mirror.sjtu.edu.cn/nix-channels/store" ];
nix.settings.experimental-features = [ "nix-command" "flakes"];
  system.stateVersion = "23.11"; # Did you read the comment?

}

