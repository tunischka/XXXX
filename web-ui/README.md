# 🔐 Flipper Clone Web UI (Raspberry Pi Zero 2 W)

A modular Flask-based **headless web interface** for a portable cybersecurity device inspired by Flipper Zero.  
Runs offline over its own Access Point and is accessible via browser.

---

## 📁 Project Structure

```
/home/tunag/web-ui/
├── app.py                   # Main Flask app
├── README.md                # This file
├── templates/               # HTML pages
│   ├── home.html            # Entry UI
│   └── system.html          # System info
├── modules/                 # Plug-in tools
│   ├── system.py            # System metrics
│   ├── wifi.py              # (coming soon)
│   ├── rf.py                # (coming soon)
│   └── nfc.py               # (coming soon)
├── static/                  # CSS / JS (optional)
└── flaskpanel.service       # systemd auto-start config
```

---

## 🚀 Features

- Operates **headlessly** (no screen/keyboard)
- Broadcasts **offline Wi-Fi AP** via `ap0`
- Flask-based Web UI at `http://192.168.50.1:8080`
- Displays:
  - CPU/RAM usage
  - Temperature
  - Uptime & OS info
- Auto-starts on reboot via `systemd`
- Fully modular: add `.py` + `.html` → instant tool integration

---

## ⚙️ Installation

```bash
sudo apt update
sudo apt install python3-flask python3-psutil -y
```

---

## ▶️ Manual Run

```bash
cd ~/web-ui
sudo python3 app.py
```

Accessible from phone/PC:  
```
http://192.168.50.1:8080
```

---

## 🔁 Auto-Start Setup

Create systemd service:

```bash
sudo nano /etc/systemd/system/flaskpanel.service
```

Paste:

```ini
[Unit]
Description=Flipper Clone Flask Web UI
After=network.target

[Service]
User=tunag
WorkingDirectory=/home/tunag/web-ui
ExecStart=/usr/bin/python3 /home/tunag/web-ui/app.py
Restart=always

[Install]
WantedBy=multi-user.target
```

Then:

```bash
sudo systemctl daemon-reload
sudo systemctl enable flaskpanel.service
sudo systemctl start flaskpanel.service
```

---

## 🌐 Web Interface

- `/` → Home page with navigation buttons  
- `/status` → System info page  
- `/logs` (coming soon) → View `.log`, `.pcap`, `.json` dumps  
- Modular routes: one per function (`wifi.py`, `rf.py`, etc.)

---

## 🧩 Adding Modules

1. Add a `.py` file in `modules/`
2. Add route in `app.py`
3. Create a corresponding `.html` template
4. Button → Route → Output → Done ✅

---

## 📌 Notes

- Device is designed for **offline use only**
- Access the web panel via device’s AP (`192.168.50.1`)
- Works on Raspberry Pi Zero 2 W (low power, silent)
- No cloud, no logs, no tracking

---

## 👤 Developer

Built by `tunischka`  
Flipper Clone is a DIY educational project. Extend at will.
