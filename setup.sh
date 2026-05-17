#!/data/data/com.termux/files/usr/bin/bash

clear

GREEN="\e[32m"
BLUE="\e[34m"
RED="\e[31m"
YELLOW="\e[33m"
RESET="\e[0m"

echo -e "${BLUE}"
echo "=============================================="
echo " Android Linux Desktop Installer"
echo " Ubuntu Personality Edition"
echo "=============================================="
echo -e "${RESET}"

pkg update -y && pkg upgrade -y

echo -e "${GREEN}[*] Enabling repositories...${RESET}"
pkg install -y x11-repo tur-repo root-repo

echo -e "${GREEN}[*] Installing base packages...${RESET}"

pkg install -y \
termux-x11-nightly \
pulseaudio \
virglrenderer-android \
mesa \
mesa-vulkan-icd-freedreno-dri3 \
vulkan-loader-android \
git \
wget \
curl \
python \
python-pip \
nano \
vim \
htop \
zip \
unzip \
tar \
proot-distro \
dbus \
tigervnc \
net-tools \
openssh \
firefox \
pavucontrol \
alsa-utils \
papirus-icon-theme

clear

echo "Choose Desktop Environment:"
echo
echo "1) XFCE"
echo "2) LXQt"
echo "3) MATE"
echo "4) KDE Plasma"

read -p "Selection: " DESKTOP

case $DESKTOP in
  1)
    DE="xfce"
    PKGS="xfce4 xfce4-goodies"
    SESSION="xfce4-session"
    ;;
  2)
    DE="lxqt"
    PKGS="lxqt"
    SESSION="startlxqt"
    ;;
  3)
    DE="mate"
    PKGS="mate-desktop mate-terminal"
    SESSION="mate-session"
    ;;
  4)
    DE="kde"
    PKGS="plasma-desktop konsole dolphin"
    SESSION="startplasma-x11"
    ;;
  *)
    echo "Invalid selection"
    exit 1
    ;;
esac

echo -e "${GREEN}[*] Installing ${DE} desktop...${RESET}"

pkg install -y $PKGS

mkdir -p $HOME/.local/bin
mkdir -p $HOME/.config

echo -e "${GREEN}[*] Creating launch scripts...${RESET}"

cat > $PREFIX/bin/start-desktop <<EOF
#!/data/data/com.termux/files/usr/bin/bash

export XDG_RUNTIME_DIR=\$TMPDIR
export DISPLAY=:0
export PULSE_SERVER=127.0.0.1
export MESA_LOADER_DRIVER_OVERRIDE=zink
export GALLIUM_DRIVER=zink
export ZINK_DESCRIPTORS=lazy
export MESA_GL_VERSION_OVERRIDE=4.0

pulseaudio --start

virgl_test_server_android --angle-gl &

termux-x11 :0 -fullscreen &
sleep 3

am start --user 0 \
-n com.termux.x11/com.termux.x11.MainActivity >/dev/null 2>&1

dbus-launch --exit-with-session ${SESSION}
EOF

chmod +x $PREFIX/bin/start-desktop

cat > $PREFIX/bin/stop-desktop <<EOF
#!/data/data/com.termux/files/usr/bin/bash

pkill -f termux-x11
pkill -f virgl
pkill -f pulseaudio
pkill -f ${SESSION}

echo "Desktop stopped."
EOF

chmod +x $PREFIX/bin/stop-desktop

echo -e "${GREEN}[*] Setting Ubuntu shell personality...${RESET}"

echo 'export PS1="\[\e[32m\]\u@ubuntu-phone:\w\\$ \[\e[0m\]"' >> ~/.bashrc
echo 'neofetch 2>/dev/null' >> ~/.bashrc

pkg install -y neofetch

clear

echo "Choose Linux Container:"
echo
echo "1) Ubuntu"
echo "2) Debian"
echo "3) Kali"

read -p "Selection: " DISTRO

case $DISTRO in
  1) DISTRO_NAME="ubuntu" ;;
  2) DISTRO_NAME="debian" ;;
  3) DISTRO_NAME="kali" ;;
  *) exit 1 ;;
esac

echo -e "${GREEN}[*] Installing $DISTRO_NAME container...${RESET}"

proot-distro install $DISTRO_NAME

cat > $PREFIX/bin/linux <<EOF
#!/data/data/com.termux/files/usr/bin/bash
proot-distro login $DISTRO_NAME --shared-tmp
EOF

chmod +x $PREFIX/bin/linux

echo -e "${GREEN}[*] Creating app sync utility...${RESET}"

cat > $PREFIX/bin/sync-linux-apps <<'EOF'
#!/data/data/com.termux/files/usr/bin/bash

APPDIR="$HOME/.local/share/applications"
mkdir -p $APPDIR

find ~/../usr/var/lib/proot-distro/installed-rootfs -name "*.desktop" 2>/dev/null | while read FILE; do
    cp "$FILE" "$APPDIR/" 2>/dev/null
done

update-desktop-database $APPDIR 2>/dev/null

echo "Linux applications synced."
EOF

chmod +x $PREFIX/bin/sync-linux-apps

echo -e "${GREEN}[*] Creating VNC launcher...${RESET}"

cat > $PREFIX/bin/start-vnc <<EOF
#!/data/data/com.termux/files/usr/bin/bash

vncserver :1 -geometry 1920x1080 -localhost no

echo
echo "VNC running on:"
echo "IP: \$(ip addr show wlan0 | grep inet | awk '{print \$2}')"
echo "Port: 5901"
EOF

chmod +x $PREFIX/bin/start-vnc

echo
echo -e "${BLUE}=============================================="
echo " INSTALL COMPLETE"
echo "=============================================="
echo -e "${RESET}"

echo "Commands:"
echo
echo "start-desktop"
echo "stop-desktop"
echo "linux"
echo "sync-linux-apps"
echo "start-vnc"
echo
echo "Done."