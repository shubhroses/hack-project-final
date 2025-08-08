import logging
import time
from datetime import datetime
from flask import Flask, render_template
from pathlib import Path

app = Flask(__name__)

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)

logger = logging.getLogger(__name__)

file_path = "/etc/os-release"
# file_path = "/Users/interview.candidate/codebase/hack-project-final/requirements.txt"

image_path = "image1.png"

@app.route("/")
def hellp():
    logging.info("Reached default endpoint")
    return "Hello from Flask in kubernetes inside of vagrant."

@app.route("/ping")
def ping():
    logging.info("Reached ping endpoint")
    return "pong"

@app.route("/system-info")
def system_info():
    logging.info("Reached system-info endpoint")
    contents = Path(file_path).read_text()
    logging.info(f"Contents of {file_path}: {contents}")
    return contents

@app.route("/home")
def home():
    return render_template("index.html")

if __name__ == "__main__":
    logging.info("Starting main application...")
    app.run(host="0.0.0.0", port=5000, debug=False)