# 🪽 LXQt
**A optimized, high-performance LXQt deployment for Arch Linux.**

## ✨ Key Features

* **Seamless Transition: ** Effortlessly moves from a bare-bones Arch base to a polished, fully functional desktop environment.

* **Dynamic Hardware Auditing:** Automatically detects your specific system architecture during the install process.

* **Tailored Microcode:** Installs the precise CPU microcode required for your Intel or AMD processor.

* **GPU Driver Stack:** Full support for Intel, AMD, and NVIDIA (including proprietary drivers and 32-bit `multilib` compatibility).

* **Universal Firmware:** Out-of-the-box support for laptop-specific needs, including Broadcom Wi-Fi and Sound Open Firmware (SOF).

* **Cross-Platform Compatibility:** Optimized for everything from MacBooks and Chromebooks to high-end custom workstations.

## 🛠️ Intelligent Hardware Coverage
The script performs a real-time system audit to tailor the installation to your specific machine:

* **Processor Support:** Detects Intel vs. AMD to apply correct `ucode` security patches and performance optimizations.
* **GPU Optimization:** Auto-configures drivers for **Intel HD/UHD**, **AMD Radeon**, and **NVIDIA** (includes proprietary drivers, settings, and 32-bit `multilib` support).
* **Laptop & Mobile:** Detects battery presence to enable `TLP` power management and `Thermald` for Intel-specific cooling.
* **Apple/Mac Support:** Scans for Broadcom Wi-Fi chips and automatically installs the necessary `broadcom-wl` kernel modules.
* **Modern Audio:** Fully configures the **PipeWire** stack with `sof-firmware` for modern "Smart Sound" laptop audio support.

## 👜 Bundled Software Suite
### 🕊️ Native LXQt Core
* **File Manager:** [pcmanfm-qt](https://github.com/lxqt/pcmanfm-qt) (with gvfs for automounting)
* **Terminal:** [qterminal](https://github.com/lxqt/qterminal)
* **Image Viewer:** [lximage-qt](https://github.com/lxqt/lximage-qt)
* **Desktop:** Notification daemon, Power Management, Global Keys, and Runner.

### 🔮 Curated External Apps
| Category | Application | Description |
| :--- | :--- | :--- |
| **Browser** | [Falkon](https://github.com/KDE/falkon) | Lightweight Qt-based web browsing. |
| **Editor** | [Neovim](https://github.com/neovim/neovim) | Professional CLI-based text editing. |
| **Editor** | [Featherpad](https://github.com/tsujan/FeatherPad) | Lightweight GUI-based text editing. |
| **Media** | [MPV](https://github.com/mpv-player/mpv) | High-performance, minimalist video playback. |
| **Monitor** | [Htop](https://github.com/htop-dev/htop) | Real-time system resource monitoring. |
| **Eye Candy** | [Picom](https://github.com/yshui/picom) | X11 compositor for transparency and shadows. |

## 📜 System Requirements
| Component | Minimum | Recommended |
| :--- | :--- | :--- |
| **Processor** | 64-bit x86-64 | Dual Core or better |
| **RAM** | 1GB | ≥2GB |
| **Storage** | 4GB | ≥8GB |
| **Architecture** | Arch Linux | Post-Archinstall |

## 🚀 Installation (Post-Archinstall)
Run this command after using Archinstall (as a user with `sudo` privileges). 

```bash
curl -fsSL [https://cdn.jsdelivr.net/gh/Kaiserrrrrr/LXQt/install.sh](https://cdn.jsdelivr.net/gh/Kaiserrrrrr/LXQt/install.sh) | sh
```
