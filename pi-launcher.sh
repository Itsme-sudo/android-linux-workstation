pi-launcher.sh
#!/bin/bash

PHONE_IP=$(ip neigh | grep "192.168.42" | awk '{print $1}' | head -n1)

if [ -z "$PHONE_IP" ]; then
    echo "Phone not found."
    exit 1
fi

echo "Launching Android desktop from $PHONE_IP"

vncviewer ${PHONE_IP}:1 -FullScreen
