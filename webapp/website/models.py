from . import db
from flask_login import UserMixin


class User(db.Model, UserMixin):
    id = db.Column(db.Integer, unique=True, primary_key=True)
    user = db.Column(db.String(255), unique=True)
    password = db.Column(db.String(255))
