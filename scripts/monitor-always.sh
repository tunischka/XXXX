#!/bin/bash

ADAPTER="wlan1"

check_mode() {
    iw dev "$ADAPTER" info 2>/dev/null | grep -q "type monitor"
    return $?
}

force_monitor_mode() {
    ip link set "$ADAPTER" down
    iw "$ADAPTER" set monitor control
    ip link set "$ADAPTER" up
    echo "[+] Forced $ADAPTER into monitor mode"
}

# Sonsuz döngü: her 10 dakikada bir kontrol
while true; do
    check_mode
    if [ $? -ne 0 ]; then
        echo "[!] $ADAPTER not in monitor mode — fixing..."
        force_monitor_mode
    else
        echo "[*] $ADAPTER already in monitor mode"
    fi
    sleep 600  # 10 dakika
done
