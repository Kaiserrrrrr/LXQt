#!/bin/bash
sudo pacman -Syu && \
sudo pacman -S --noconfirm xorg-server lightdm lightdm-gtk-greeter \
openbox lxqt-session lxqt-panel lxqt-config lxqt-qtplugin \
pcmanfm-qt qterminal breeze-icons menu-cache && \
sudo pacman -Scc --noconfirm && \
sudo systemctl enable lightdm && \
reboot
