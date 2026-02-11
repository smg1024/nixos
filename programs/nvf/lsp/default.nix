let
  lsp = import ./lsp.nix;
  autocomplete = import ./autocomplete.nix;
  languages = import ./languages;
in
{
  inherit lsp autocomplete languages;
}
