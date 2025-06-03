# 🔐 Flipper Clone Web UI (Raspberry Pi Zero 2 W)

This project is a modular Flask-based **headless web interface** designed for a portable cybersecurity device inspired by Flipper Zero. The system runs offline, broadcasts its own Wi-Fi Access Point, and can be managed through a browser interface.

## 📁 Project Structure

```
/home/tunag/web-ui/
├── app.py                   # Main Flask application
├── README.md                # Documentation
├── templates/               # HTML interface templates
│   ├── home.html
│   └── system.html
├── modules/                 # Functional modules (plug-and-play)
│   ├── __init__.py
│   ├── system.py
│   ├── wifi.py              # (placeholder)
│   ├── rf.py                # (placeholder)
│   └── nfc.py               # (placeholder)
└── static/                  # Reserved for frontend assets (CSS/JS)
```

## 🚀 Features

- Runs headlessly on Raspberry Pi Zero 2 W
- Operates as an **offline Wi-Fi Access Point**
- Lightweight web UI for system status monitoring
- Auto-starts on reboot via systemd service
- Modular architecture — easy to extend with new modules

## 🛠 Installation

### 1. Install Flask and dependencies

```bash
sudo apt update
sudo apt install python3-flask python3-psutil -y
```

### 2. Run the Flask app manually

```bash
cd ~/web-ui
sudo python3 app.py
```

## 🔁 Auto-start Setup (Systemd)

### Create service file

```bash
sudo nano /etc/systemd/system/flaskpanel.service
```

Paste the following:

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

### Enable and start the service

```bash
sudo systemctl daemon-reload
sudo systemctl enable flaskpanel.service
sudo systemctl start flaskpanel.service
```

After reboot, the Flask UI will be automatically served over `http://192.168.50.1`.

## 🌐 Web Interface

### `/` Home Page

- Header: `Welcome to XXXXXXX`
- Button: “System Requirements”

### `/status` System Info Page

- CPU usage
- RAM usage
- System temperature
- Uptime
- OS version
- Refresh + Back buttons

## 🧩 How to Add a New Module

To add new functionality:

1. Create a new file under `modules/`, e.g. `bluetooth.py`
2. Create a new route in `app.py`
3. Add an HTML template in `templates/`

## 📌 Notes

- Intended for **educational and offline pentest environments** only.
- Web panel is only accessible through the device's AP (e.g. `192.168.50.1`)
- Future expansions: login authentication, .pcap/.log manager, module dashboard

## 👤 Developer: `tunag`

This interface is part of a personal, modular DIY cybersecurity toolkit. You are free to expand it with your own tools and services.
