import os

from werkzeug.utils import secure_filename
import enum
import requests

from flask import (
    Flask,
    jsonify,
    send_from_directory,
    request,
    redirect,
    url_for
)
from flask_sqlalchemy import SQLAlchemy
import json

app = Flask(__name__)
app.config.from_object("project.config.Config")
db = SQLAlchemy(app)

class StatusType(enum.Enum):
    AVAILABLE = 'AVAILABLE'
    NOT_AVAILABLE = 'NOT AVAILABLE'

class ServiceStatus(db.Model):
    __tablename__ = "services"

    ip = db.Column(db.String(64), primary_key=True)
    status = db.Column(db.Enum(StatusType))

    def __init__(self, ip, status=StatusType.NOT_AVAILABLE):
        self.ip = ip
        self.status = status

@app.route("/")
def hello_world():
    return jsonify(hello="world")

@app.route("/healthcheck", methods=["GET"])
def healthcheck():
    my_ip = requests.get('http://169.254.169.254/latest/meta-data/public-ipv4')
    
    try:
        db.session.add(ServiceStatus(ip=ip, status=StatusType.AVAILABLE))
        db.session.commit()
    except:
        # do nothing
        a = 10
    
    try:
        query = db.session.query(ServiceStatus).all()
        return jsonify({"ip":my_ip.text, "services": list(map(lambda x: {"ip": x.ip, "status": "AVAILABLE" if x.status == StatusType.AVAILABLE else "NOT AVAILABLE" }, query))})
    except:
        return jsonify(error="Database is unavailable", ip=request.host)