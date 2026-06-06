# Virtual Machine Settings
{ self, ... }:
{
  flake.nixosModules."vm-guest" =
    { ... }:
    {
      services.qemuGuest.enable = true;
      services.spice-vdagentd.enable = true;
    };
}
