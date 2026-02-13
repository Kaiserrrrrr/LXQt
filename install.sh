#!/bin/bash
sudo pacman -Syu && \
sudo pacman -S --noconfirm xorg-server lightdm lightdm-gtk-greeter openbox lxqt-session lxqt-panel lxqt-config lxqt-qtplugin pcmanfm-qt qterminal breeze-icons menu-cache falkon fastfetch && \
sudo pacman -Scc --noconfirm && \
sudo systemctl enable lightdm && \
mkdir -p ~/.config/pcmanfm-qt/lxqt/; echo -e "[General]\ntrust_all_desktop_files=true" >> ~/.config/pcmanfm-qt/lxqt/settings.conf && \
reboot
