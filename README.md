#My dendritic nix config using flake-parts 

# Install Steps
`git clone https://github.com/estepleb/nixos ~/config/nixos` 
`nixos rebuild switch --flake ~/config/nixos#HOSTNAME`

# Hosts
 - nix-vm
 - thinkbook-plus
 - dns

# Credits:
https://github.com/anotherhadi/nixy # First base config
https://codeberg.org/SeniorMatthew/nixos # Base for dendritic flake-parts migration
https://github.com/vimjoyer/nixconf # Secondary dendritic flake-parts reference. import-tree nix function in flake
