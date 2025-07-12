{ config, pkgs, ...}:
{
	programs.direnv = {
		enable = true;
		# fish integration is auto-enabled
		nix-direnv.enable = true;
	};
}
