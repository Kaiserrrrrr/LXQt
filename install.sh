#!/bin/bash


# /$$       /$$   /$$  /$$$$$$    /$$    
# | $$      | $$  / $$ /$$__  $$  | $$    
# | $$      |  $$/ $$/| $$  \ $$ /$$$$$$  
# | $$       \  $$$$/ | $$  | $$|_  $$_/  
# | $$        >$$  $$ | $$  | $$  | $$    
# | $$       /$$/\  $$| $$/$$ $$  | $$ /$$
# | $$$$$$$$| $$  \ $$|  $$$$$$/  |  $$$$/
# |________/|__/  |__/ \____ $$$   \___/  
#                           \__/          


# Enable Performance Mode 
export MAKEFLAGS="-j$(nproc)" && echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor >/dev/null && grep -q "NoExtract" /etc/pacman.conf || sudo sed -i '/^#NoExtract  =/c\NoExtract  = usr/share/help/* usr/share/man/* usr/share/doc/* usr/share/info/* usr/share/gtk-doc/* usr/share/locale/*' /etc/pacman.conf


# Installation Script
sudo pacman -Syu --noconfirm --needed >/dev/null 2>&1 && CPU_VENDOR=$(grep -m1 'vendor_id' /proc/cpuinfo) && IS_LAPTOP=$([ -d /sys/class/power_supply/BAT* ] || [ -d /sys/class/input/mouse* ] && echo 1 || echo 0) && DRIVERS="sof-firmware alsa-firmware tlp thermald mesa lib32-mesa intel-media-driver udisks2 zram-generator" && [[ "$CPU_VENDOR" =~ "GenuineIntel" ]] && DRIVERS+=" intel-ucode vulkan-intel" || DRIVERS+=" amd-ucode" && [[ $(lspci -n | grep -c "14e4:") -gt 0 ]] && DRIVERS+=" broadcom-wl" && [[ $(lspci -n | grep -c "10de:") -gt 0 ]] && DRIVERS+=" nvidia nvidia-utils nvidia-settings lib32-nvidia-utils" && [[ "$IS_LAPTOP" -eq 1 ]] && DRIVERS+=" xf86-input-libinput" && sudo pacman -S --noconfirm --needed $DRIVERS openbox lxqt-session lxqt-panel lxqt-config lxqt-qtplugin lxqt-powermanagement lxqt-notificationd lxqt-policykit lxqt-globalkeys lxqt-runner lxqt-themes lximage-qt pcmanfm-qt qterminal breeze-icons gvfs falkon neovim fastfetch htop mpv nano bc ncdu git light-locker xorg-server lightdm lightdm-gtk-greeter pipewire-audio pavucontrol-qt alsa-utils bluez bluez-utils blueman networkmanager network-manager-applet xdg-utils picom >/dev/null 2>&1 && [ ! -f /etc/systemd/zram-generator.conf ] && echo -e "[zram0]\nzram-size = ram * 0.6\ncompression-algorithm = zstd\nswap-priority = 100\nfs-type = swap" | sudo tee /etc/systemd/zram-generator.conf >/dev/null && sudo systemctl daemon-reload && [ ! -d ~/.config/openbox ] && mkdir -p ~/.config/openbox && cp /etc/xdg/openbox/rc.xml ~/.config/openbox/ 2>/dev/null || true && [ ! -f ~/.xinitrc ] && echo "exec startlxqt" > ~/.xinitrc && sudo usermod -aG video,audio,lp,scanner $USER && sudo systemctl enable lightdm bluetooth NetworkManager tlp thermald >/dev/null 2>&1


# 3. Cleanup Script
pacman -Qtdq >/dev/null && sudo pacman -Rns $(pacman -Qtdq) --noconfirm >/dev/null 2>&1 || true && STAY_INTEL=$(lscpu | grep -ic "Intel") && STAY_AMD=$(lspci | grep -icE "amd|radeon") && STAY_NVIDIA=$(lspci | grep -ic "nvidia") && [[ "$STAY_INTEL" == "0" ]] && sudo rm -rf /usr/lib/firmware/intel* 2>/dev/null || true && [[ "$STAY_AMD" == "0" ]] && sudo rm -rf /usr/lib/firmware/amdgpu /usr/lib/firmware/radeon 2>/dev/null || true && [[ "$STAY_NVIDIA" == "0" ]] && sudo rm -rf /usr/lib/firmware/nvidia 2>/dev/null || true && sudo rm -rf /usr/lib/firmware/{liquidio,qcom,netronome,nfp,mellanox,kaweth,ti-connectivity,mediatek,marvell,cavium,qed} 2>/dev/null && sudo find /usr/lib/modules -name "*.ko" -print0 | xargs -0 -P $(nproc) strip --strip-debug 2>/dev/null && sudo journalctl --vacuum-size=10M >/dev/null && sudo sed -i 's/#SystemMaxUse=/SystemMaxUse=10M/' /etc/systemd/journald.conf && sudo systemctl restart systemd-journald && rm -rf ~/.cache/* 2>/dev/null && sudo pacman -Scc --noconfirm >/dev/null 2>&1


# 4. Disable Performance Mode & Reboot
echo powersave | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor >/dev/null && sync && sleep 2 && sudo reboot
