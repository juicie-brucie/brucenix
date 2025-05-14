{ pkgs, inputs, ... }:
let
    python-packages = pkgs.python3.withPackages {
        ps:
            with ps; [
                requests
                pyquery # hyprland weather script

            ]


    };



in { #start

    environment.systemPackages = with pkgs; [
        ags # desktop overview
        btop
        brightnessctl # for brightness control
        cava
        cliphist
        loupe
        gnome-system-monitor
        grim
        gtk-engine-murrine #for gtk themes
        hypridle
        imagemagick
        inxi
        jq
        kitty
        libsForQt5.qtstyleplugin-kvantum #kvantum
        networkmanagerapplet
        nwg-displays
        nwg-look
        nvtopPackages.full
        pamixer
        pavucontrol
        playerctl
        polkit_gnome
        libsForQt5.qt5ct
        kdePackages.qt6ct
        kdePackages.qtwayland
        kdePackages.qtstyleplugin-kvantum #kvantum
        rofi-wayland
        slurp
        swappy
        swaynotificationcenter
        swww
        unzip
        wallust
        wl-clipboard
        wlogout
        xarchiver
        yad
        yt-dlp


    ];



} #end
