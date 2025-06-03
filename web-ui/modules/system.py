from flask import render_template
import psutil
import platform

def get_status():
    cpu = psutil.cpu_percent(interval=1)
    ram = psutil.virtual_memory()
    try:
        with open("/sys/class/thermal/thermal_zone0/temp", "r") as f:
            temp = round(int(f.readline()) / 1000, 1)
    except:
        temp = "N/A"

    try:
        with open("/proc/uptime", "r") as f:
            uptime = int(float(f.readline().split()[0]))
    except:
        uptime = "N/A"

    return render_template("system.html",
                           cpu_percent=cpu,
                           ram_used=ram.used // (1024 * 1024),
                           ram_total=ram.total // (1024 * 1024),
                           temperature=temp,
                           uptime=uptime,
                           system=platform.system(),
                           release=platform.release())
