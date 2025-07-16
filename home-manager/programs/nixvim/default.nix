{ pkgs, lib, ... }:

{
	programs.nixvim = {
		enable = true;

		defaultEditor = true;
		viAlias = true;
		vimAlias = true;

		colorschemes.oxocarbon.enable = true;

		plugins = {
			telescope.enable = true;
			yazi.enable = true;

			nix.enable = true;

			#blink-cmp.enable = true;
		};
	};
}
