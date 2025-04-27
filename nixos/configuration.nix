{ config, pkgs, ... }:

let
  # Zen Browser GitHub source repository
  zenBrowser = pkgs.stdenv.mkDerivation rec {
    name = "zen-browser";
    src = pkgs.fetchgit {
      url = "https://github.com/ZenBrowser/ZenBrowser.git";  # Replace with actual GitHub URL
      rev = "master";  # Or specify a commit hash/tag if you want a specific version
      sha256 = "0vky5fz46p5fql10r5ylisfyjvkkgnif5a0jwgwj46y6v7l96vh6";  # Obtain the correct sha256 hash
    };

    # Build dependencies (If Zen Browser requires nodejs, qt, etc.)
    buildInputs = [ pkgs.nodejs pkgs.qt5 pkgs.gtk3 ];  # Example, adjust according to actual dependencies

    # Installation phase
    installPhase = ''
      mkdir -p $out/bin
      cp -r * $out/bin/
    '';
  };
in
{
  # Basic system configuration
  users.users.AXWTV = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];  # Add user to the 'wheel' group for sudo access
  };

  # System environment settings
  environment.systemPackages = with pkgs; [
    # Essential packages
    alacritty
    curl
    git
    grim
    gvfs
    gvfs-mtp
    ImageMagick
    jq
    kitty
    kvantum
    lsd
    lazygit
    nano
    npm
    network-manager-applet
    neovim
    nautilus
    openssl
    pamixer
    pavucontrol
    pipewire-alsa
    playerctl
    polkit-gnome
    power-profiles-daemon
    python3-requests
    python3-pip
    qt5ct
    qt6ct
    qt6-qtsvg
    rofi-wayland
    slurp
    swappy
    tmux
    wget
    wl-clipboard
    wlogout
    xdg-user-dirs
    xdg-utils
    yad

    # Fonts
    adobe-source-code-pro-fonts
    fira-code-fonts
    fontawesome-fonts-all
    google-droid-sans-fonts
    google-noto-sans-cjk-fonts
    google-noto-color-emoji-fonts
    google-noto-emoji-fonts
    jetbrains-mono-fonts

    # Other packages
    unzip
    gtk-murrine-engine
    hyprland
    hyprland-devel
    hyprlock
    golang
    gtk3
    gtk3-devel
    cairo-devel
    glib-devel
    nu
    starship
    util-linux
    sddm
    qt6-qt5compat
    qt6-qtdeclarative
    qt6-qtsvg

    # Tmux Plugin Manager
    (pkgs.fetchgit {
      url = "https://github.com/tmux-plugins/tpm";
      rev = "master";
      sha256 = "0vky5fz46p5fql10r5ylisfyjvkkgnif5a0jwgwj46y6v7l96vh6";  # Get sha256 hash after fetching repo
    })

    zenBrowser  # Add Zen Browser to system packages after building it
  ];

  # SDDM Configuration (for display manager if using SDDM)
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.sddm.theme = "breeze";

  # Enable Hyprland (Wayland) window manager
  services.xserver.windowManager.hyprland.enable = true;
  
  # Power profile daemon setup
  systemd.services.power-profiles-daemon = {
    enable = true;
    serviceConfig.ExecStart = "${pkgs.power-profiles-daemon}/bin/power-profiles-daemon";
  };

  # XDG Desktop Portals for Hyprland
  environment.systemPackages = with pkgs; [
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
  ];

  # Check for and remove any conflicting xdg-desktop portals if desired
  systemd.services.remove-xdg-portals = {
    description = "Remove conflicting XDG Desktop Portal implementations";
    wantedBy = [ "multi-user.target" ];
    serviceConfig.ExecStart = ''
      if sudo dnf list installed xdg-desktop-portal-wlr &>/dev/null; then
        sudo dnf remove -y xdg-desktop-portal-wlr
      fi
      if sudo dnf list installed xdg-desktop-portal-lxqt &>/dev/null; then
        sudo dnf remove -y xdg-desktop-portal-lxqt
      fi
    '';
  };

  # Enable systemd service for power-profiles-daemon
  systemd.services.power-profiles-daemon = {
    enable = true;
    serviceConfig.ExecStart = "${pkgs.power-profiles-daemon}/bin/power-profiles-daemon";
  };

  # System configuration settings
  nixpkgs.config.allowUnfree = true;  # If using any unfree software

  # Other system settings
  system.stateVersion = "23.05";  # Specify the NixOS version

  # Example for Git-based installation
  environment.systemPackages = with pkgs; [
    zenBrowser  # Install Zen Browser after building from Git
  ];
}
