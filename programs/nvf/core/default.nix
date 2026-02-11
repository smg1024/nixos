let
  options = import ./options.nix;
  autocmds = import ./autocmds.nix;
  augroups = import ./augroups.nix;
  keymaps = import ./keymaps.nix;
in
{
  inherit
    options
    autocmds
    keymaps
    augroups
    ;
}
