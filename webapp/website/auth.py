from flask import Blueprint, render_template, request, redirect, url_for, flash
from .models import User
from . import db
from werkzeug.security import generate_password_hash, check_password_hash
from flask_login import login_user, logout_user, login_required, current_user

auth = Blueprint("auth", __name__)


@auth.route("/signup", methods=["POST", "GET"])
def signup():
    if request.method == "POST":
        username = request.form.get("user")
        password = request.form.get("password")
        password = generate_password_hash(password=password, method="sha256")
        user = User(user=username, password=password)
        db.session.add(user)
        db.session.commit()
    return render_template("signup.html")


@auth.route("/login", methods=["POST", "GET"])
def login():
    if request.method == "POST":
        username = request.form.get("user")
        password = request.form.get("password")
        user = User.query.filter_by(user=username).first()
        if not user or not check_password_hash(user.password, password):
            flash("invalid user")
            return redirect(url_for("auth.login"))
        else:
            login_user(user, remember=True)
            return redirect(url_for("views.home"))
    return render_template("home.html", user=current_user)


@auth.route("/logout")
@login_required
def logout():
    logout_user()
    return redirect(url_for("auth.login"))
