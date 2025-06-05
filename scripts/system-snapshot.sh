#!/bin/bash

DEST="/home/tunag/XXXX/docs/system-config"
DATE=$(date '+%Y-%m-%d %H:%M:%S')
TMP_LIST="$DEST/_snapshot.tmp"
README="$DEST/README.md"

echo "[*] Starting system config snapshot..."
mkdir -p "$DEST"
> "$TMP_LIST"

# Taranacak sistem dosyaları ve klasörleri
declare -a TARGETS=(
    "/etc/rc.local"
    "/etc/udev/rules.d/*.rules"
    "/etc/systemd/system/*flask*.service"
    "/etc/hostapd/hostapd.conf"
    "/etc/dnsmasq.conf"
    "/etc/network/interfaces"
    "/etc/wpa_supplicant/*"
    "/etc/modprobe.d/*"
    "/etc/modules"
    "/etc/iptables/rules.v4"
    "/etc/iptables/rules.v6"
)

for path in "${TARGETS[@]}"; do
    for file in $path; do
        if [ -f "$file" ]; then
            rel_path="${file#/}"                                # /etc/rc.local → etc/rc.local
            dest_path="$DEST/$rel_path"                         # full target path
            mkdir -p "$(dirname "$dest_path")"
            sudo cp "$file" "$dest_path"
            echo "[+] Backed up $file → $rel_path"
            echo "$rel_path" >> "$TMP_LIST"
        fi
    done
done

# README.md otomatik yaz
echo "[*] Updating README.md ..."
{
    echo "# 🔐 System Config Snapshots"
    echo ""
    echo "Bu klasör sistem dışı tüm kritik yapılandırma dosyalarının yedeğini içerir."
    echo "**Son güncelleme:** $DATE"
    echo ""
    echo "## 🔍 Dosya Listesi"
    echo ""
    echo "| Dosya Yolu | SHA256 |"
    echo "|------------|--------|"
    while read -r rel; do
        full="$DEST/$rel"
        hash=$(sha256sum "$full" | awk '{print $1}')
        echo "| $rel | $hash |"
    done < "$TMP_LIST"
} > "$README"

rm -f "$TMP_LIST"
echo "[✓] Snapshot tamamlandı. Tüm dosyalar $DEST altında."
