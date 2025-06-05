import subprocess
import os
from datetime import datetime

def start_scan(interface="wlan1"):
    # Kayıt klasörü (proje içinde)
    capture_dir = os.path.expanduser("/home/tunag/XXXX/captures")
    os.makedirs(capture_dir, exist_ok=True)

    # Zaman damgası
    timestamp = datetime.now().strftime("%Y%m%d-%H%M%S")
    file_prefix = f"scan-{timestamp}"
    file_path = os.path.join(capture_dir, file_prefix)

    print(f"[*] Starting scan on {interface}")
    print(f"[*] Output will be saved as: {file_path}-01.csv")

    try:
        # Airodump-ng başlat
        subprocess.run([
            "sudo", "airodump-ng", interface,
            "--write", file_path,
            "--output-format", "csv"
        ])
    except KeyboardInterrupt:
        print("\n[!] Scan interrupted by user.")
    finally:
        print(f"[+] Scan completed. Output saved in: {file_path}-01.csv")

if __name__ == "__main__":
    start_scan()
