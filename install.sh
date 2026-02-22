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



# 1. Enable Performance Mode
export MAKEFLAGS="-j$(nproc)" && echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor >/dev/null && (grep -q "NoExtract" /etc/pacman.conf || sudo sed -i '/^#NoExtract  =/c\NoExtract  = usr/share/help/* usr/share/man/* usr/share/doc/* usr/share/info/* usr/share/gtk-doc/* usr/share/locale/*' /etc/pacman.conf) && echo -e "\e[32m[✓] Performance Mode Activated\e[0m"

# 2. Installation Script
sudo pacman -Syu --noconfirm --needed >/dev/null 2>&1 && CPU_VENDOR=$(grep -m1 'vendor_id' /proc/cpuinfo) && IS_LAPTOP=$([ -d /sys/class/power_supply/BAT* ] || [ -d /sys/class/input/mouse* ] && echo 1 || echo 0) && DRIVERS="sof-firmware alsa-firmware tlp thermald mesa lib32-mesa intel-media-driver udisks2 zram-generator" && ([[ "$CPU_VENDOR" =~ "GenuineIntel" ]] && DRIVERS+=" intel-ucode vulkan-intel" || DRIVERS+=" amd-ucode") && ([[ $(lspci -n | grep -c "14e4:") -gt 0 ]] && DRIVERS+=" broadcom-wl" || true) && ([[ $(lspci -n | grep -c "10de:") -gt 0 ]] && DRIVERS+=" nvidia nvidia-utils nvidia-settings lib32-nvidia-utils" || true) && ([[ "$IS_LAPTOP" == "1" ]] && DRIVERS+=" xf86-input-libinput" || true) && sudo pacman -S --noconfirm --needed $DRIVERS openbox lxqt-session lxqt-panel lxqt-config lxqt-qtplugin lxqt-powermanagement lxqt-notificationd lxqt-policykit lxqt-globalkeys lxqt-runner lxqt-themes lximage-qt pcmanfm-qt qterminal breeze-icons gvfs falkon neovim fastfetch htop mpv nano bc ncdu git light-locker xorg-server lightdm lightdm-gtk-greeter pipewire-audio pavucontrol-qt alsa-utils bluez bluez-utils blueman networkmanager network-manager-applet xdg-utils picom >/dev/null 2>&1 && ([ ! -f /etc/systemd/zram-generator.conf ] && echo -e "[zram0]\nzram-size = ram * 0.6\ncompression-algorithm = zstd\nswap-priority = 100\nfs-type = swap" | sudo tee /etc/systemd/zram-generator.conf >/dev/null || true) && sudo systemctl daemon-reload && ([ ! -d ~/.config/openbox ] && mkdir -p ~/.config/openbox && cp /etc/xdg/openbox/rc.xml ~/.config/openbox/ 2>/dev/null || true) && ([ ! -f ~/.xinitrc ] && echo "exec startlxqt" > ~/.xinitrc || true) && sudo usermod -aG video,audio,lp,scanner $USER && sudo systemctl enable lightdm bluetooth NetworkManager tlp thermald >/dev/null 2>&1 && echo -e "\e[32m[✓] Installation Completed\e[0m"

# 3. Cleanup Script
(sudo pacman -Rns $(pacman -Qtdq) --noconfirm >/dev/null 2>&1 || true) && (lscpu | grep -iq "Intel" && echo "Intel found" >/dev/null || sudo rm -rf /usr/lib/firmware/intel* 2>/dev/null || true) && (lspci | grep -iqE "amd|radeon" && echo "AMD found" >/dev/null || sudo rm -rf /usr/lib/firmware/amdgpu /usr/lib/firmware/radeon 2>/dev/null || true) && (lspci | grep -iq "nvidia" && echo "Nvidia found" >/dev/null || sudo rm -rf /usr/lib/firmware/nvidia 2>/dev/null || true) && (sudo rm -rf /usr/lib/firmware/{liquidio,qcom,netronome,nfp,mellanox,kaweth,ti-connectivity,mediatek,marvell,cavium,qed} 2>/dev/null || true) && (sudo find /usr/lib/modules -name "*.ko" -print0 | xargs -0 -P $(nproc) strip --strip-debug 2>/dev/null || true) && (sudo journalctl --vacuum-size=10M >/dev/null 2>&1 || true) && (sudo sed -i 's/#SystemMaxUse=/SystemMaxUse=10M/' /etc/systemd/journald.conf || true) && (sudo systemctl restart systemd-journald >/dev/null 2>&1 || true) && (rm -rf ~/.cache/* 2>/dev/null || true) && (sudo pacman -Scc --noconfirm >/dev/null 2>&1 || true) && echo -e "\e[32m[✓] Cleanup Completed.\e[0m"

# 4. Revert & Reboot
echo powersave | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor >/dev/null && sync && echo -e "\e[32mLXQt Setup Complete... Rebooting.\e[0m" && sleep 5 && sudo reboot
