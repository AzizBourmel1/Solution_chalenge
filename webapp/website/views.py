from flask import Blueprint, render_template, request
from firebase_admin import credentials, firestore, initialize_app
from flask_login import login_required, current_user

cred = credentials.Certificate("website/key.json")
defaultApp = initialize_app(cred)
db = firestore.client()
usersRef = db.collection("users")
orgsRef = db.collection("orgs")
postsRef = db.collection("posts")

views = Blueprint("views", __name__)


@views.route("/")
def home():
    if current_user.is_authenticated:
        infos = [
            doc.to_dict()
            for doc in orgsRef.where("username", "==", current_user.user).stream()
        ]
        return render_template("home.html", user=current_user, userInfos=infos)
    return render_template("home.html", user=current_user)


@login_required
@views.route("/users")
def users():
    allUsers = [doc.to_dict() for doc in usersRef.stream()]
    return render_template("users.html", allUsers=allUsers, user=current_user)


@login_required
@views.route("/posts")
def posts():
    allPosts = [doc.to_dict() for doc in postsRef.stream()]
    return render_template("posts.html", allPosts=allPosts, user=current_user)
