from flask import Flask, render_template
from modules import system

app = Flask(__name__)

@app.route('/')
def home():
    return render_template('home.html')

@app.route('/status')
def status():
    return system.get_status()

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
