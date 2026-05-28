{ self, ... }:
{
  flake.nixosModules.labwc = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      labwc
      sfwbar
    ];

    home-manager.users.${self.user} = {
      xdg.configFile."labwc/rc.xml".text = ''
        <?xml version="1.0" encoding="UTF-8"?>
        <labwc_config>
          <keyboard>
            <!-- switch windows inside labwc -->
            <keybind key="C-A-J">
              <action name="NextWindow" />
            </keybind>

            <keybind key="C-A-K">
              <action name="PreviousWindow" />
            </keybind>

            <!-- show window list menu -->
            <keybind key="C-A-Space">
              <action name="ShowMenu" menu="client-list-combined-menu" />
            </keybind>

            <!-- snap focused window -->
            <keybind key="C-A-H">
              <action name="SnapToEdge" direction="left" />
            </keybind>

            <keybind key="C-A-L">
              <action name="SnapToEdge" direction="right" />
            </keybind>

            <!-- maximize / unmaximize -->
            <keybind key="C-A-F">
              <action name="ToggleMaximize" />
            </keybind>

            <!-- close focused window -->
            <keybind key="C-A-Q">
              <action name="Close" />
            </keybind>
          </keyboard>
        </labwc_config>
      '';
    };
  };
}
