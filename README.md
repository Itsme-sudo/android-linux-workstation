README.md
# Android Linux Desktop

Turn your Android phone into a Linux desktop using Termux.

## Requirements

1. Install Termux from F-Droid
2. Install Termux:X11 APK
3. Open Termux
4. Run:

pkg install git
git clone YOUR_REPO
cd android-linux-desktop
chmod +x setup.sh
./setup.sh

## Start Desktop

start-desktop

## Stop Desktop

stop-desktop

## Open Linux Container

linux

## VNC Access

start-vnc

Connect with:
PHONE_IP:5901

## GPU Acceleration

Uses:
- VirGL
- Zink
- Vulkan loader

Best support:
- Qualcomm Adreno GPUs

Mali support varies.

## Troubleshooting

### Black Screen

Try:

termux-x11 :0 -legacy-drawing

### Swapped Colors

Try:

termux-x11 :0 -force-bgra

### No GPU Acceleration

Check:

ps aux | grep virgl

### No Audio

Run:

pulseaudio --start

### KDE Slow

XFCE recommended for phones.

## Recommended Desktops

XFCE:
Fast and stable

LXQt:
Lightest option

MATE:
Traditional desktop

KDE:
Best visuals, heavier

if having trouble try this:-

 Recommended Install Flow

1. Install:

   * [F-Droid](https://f-droid.org/?utm_source=chatgpt.com)
   * [Termux](https://f-droid.org/packages/com.termux/?utm_source=chatgpt.com)
   * [Termux:X11](https://github.com/termux/termux-x11/releases?utm_source=chatgpt.com)

2. Run setup

3. Launch:

```bash
start-desktop
```

---

# Notes About GPU Support

Current Termux GPU acceleration works best on:

* Snapdragon / Adreno devices
* VirGL + Zink setups

References:

* [Termux:X11 Docs](https://github.com/termux/termux-x11?utm_source=chatgpt.com)
* [Mesa Zink for Termux](https://github.com/alexvorxx/zink-xlib-termux?utm_source=chatgpt.com)

Mali GPUs may need ANGLE fallback. ([Reddit][1])

---

# Recommended Improvements

You can later add:

* Wayland session support
* Wine + Box64
* Steam Link
* Android notification integration
* External monitor auto-detect
* Bluetooth keyboard auto-mapping
* Battery-aware CPU governor tweaks
* WireGuard remote desktop access
* Auto-start on boot

---

# Audio Improvements Included

The setup already:

* launches PulseAudio
* exports Pulse server
* includes ALSA tools
* includes pavucontrol

For better latency:

```bash
pulseaudio --start --exit-idle-time=-1
```

For Bluetooth headphones:

```bash
pkg install pulseaudio-module-bluetooth
```

---

# Suggested GitHub Repo Name

```text
termux-ubuntu-desktop
```

or

```text
android-linux-workstation
```

[1]: https://www.reddit.com/r/termux/comments/16zqs11?utm_source=chatgpt.com "VirGL cannot be run on udroid."
