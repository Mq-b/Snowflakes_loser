{ config, pkgs,lib, ...}:

{
	home.username = "tritium";
	home.homeDirectory = /home/tritium;
	xresources.properties = {
		"Xcursor.size" = 16;
		"Xft.dpi" = 172;
	};
	programs.git = {
		enable =true;
		userName = "OpenTritium";
		userEmail = "tritium404@hotmail.com";
	};
	home.packages = with pkgs; [
		neofetch
		firefox
	];
	home.stateVersion = "23.11";
	programs.home-manager.enable = true;
}
