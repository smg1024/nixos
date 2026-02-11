{
  pkgs,
  username,
  ...
}:
# let
#   # In case .config symlink is needed in the future
#   dotfiles = "${config.home.homeDirectory}/nixos/.config";
#   create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
#
#   configs = {
#     # hypr = "hypr";
#     # nvim = "nvim";
#     # foot = "foot";
#     # waybar = "waybar";
#     # rofi = "rofi";
#   };
# in
{
  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = "25.11";
  };

  imports = [
    ./programs
  ];

  home.packages = with pkgs; [
    (pkgs.writeShellApplication {
      name = "ns";
      runtimeInputs = with pkgs; [
        fzf
        nix-search-tv
      ];
      text = builtins.readFile "${pkgs.nix-search-tv.src}/nixpkgs.sh";
    })
  ];

  # In case .config symlink is needed in the future
  # xdg.configFile = builtins.mapAttrs
  # 	(name: subpath: {
  # 		source = create_symlink "${dotfiles}/${subpath}";
  # 		recursive = true;
  # 	})
  # 	configs;

  programs.home-manager.enable = true;
}
