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

filei