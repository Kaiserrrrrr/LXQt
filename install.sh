#!/bin/bash
sudo pacman -Syu --noconfirm && sudo pacman -S --noconfirm xorg-server lightdm lightdm-gtk-greeter lxqt-session lxqt-panel lxqt-config lxqt-qtplugin lxqt-powermanagement lxqt-notificationd lxqt-policykit lxqt-runner pcmanfm-qt qterminal breeze-icons falkon neovim fastfetch htop openbox pavucontrol-qt gvfs && sudo systemctl enable lightdm && sudo pacman -Scc --noconfirm && reboot
