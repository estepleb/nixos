{ self, ... }:
{
	#  flakes.nixosModules.neovim = {
	#    home-manager.users.${self.user} = { inputs, ... }: {
	#      imports = [ inputs.nixvim.homeModules.nixvim ];
	#
	#      home.sessionVariables = {
	# MANPAGER = "nvim +Man!";
	#      };
	#
	#      programs.nixvim = {
	# opts = {
	#   number = true;         
	#   relativenumber = true;
	#   shiftwidth = 2;      
	# };
	# enable = true;
	# colorschemes.gruvbox.enable = true;
	#      };
	#    };
	#  };
}
