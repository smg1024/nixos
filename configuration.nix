{
  pkgs,
  hostname,
  username,
  ...
}:
{
  imports = [ ./hardware-configuration.nix ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = hostname;
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22
        5900
      ]; # 5900 for VNC support
    };
  };

  time.timeZone = "Asia/Seoul";

  services = {
    openssh.enable = true;
    printing.enable = true;
    greetd = {
      enable = true;
      settings = {
        initial_session = {
          command = "start-hyprland";
          user = username;
        };
        default_session = {
          command = "start-hyprland";
          user = username;
        };
      };
    };
  };

  users.users.${username} = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      tree
    ];
  };

  programs = {
    zsh.enable = true;
    firefox.enable = true;
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
  };

  environment.shells = with pkgs; [
    bash
    zsh
  ];

  environment.systemPackages = with pkgs; [
    home-manager
    foot # terminal
    hyprpaper # wallpaper
    kitty # terminal for hyprland
    nitch # faster neofetch
    btop # system monitoring
    pcmanfm # file manager
    rofi # application launcher
    vim # text editor
    waybar # status bar
    wayvnc # vnc server
    wl-clipboard # clipboard provider
    wget
  ];

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      nerd-fonts.d2coding
      nerd-fonts.jetbrains-mono
    ];
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.stateVersion = "25.11";
}
