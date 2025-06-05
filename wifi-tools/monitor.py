import subprocess

def enable_monitor_mode(interface="wlan1"):
    # Sadece belirtilen adaptörle çalış, diğerlerine dokunma
    print(f"[*] Switching {interface} to monitor mode...")

    subprocess.run(["sudo", "ip", "link", "set", interface, "down"])
    subprocess.run(["sudo", "iw", interface, "set", "monitor", "control"])
    subprocess.run(["sudo", "ip", "link", "set", interface, "up"])

    print(f"[+] {interface} is now in monitor mode.")

if __name__ == "__main__":
    enable_monitor_mode("wlan1")
