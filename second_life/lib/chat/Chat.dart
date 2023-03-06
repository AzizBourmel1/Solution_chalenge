class Chat {
  final String name, lastMessage, image, time;
  final bool isActive;
  Chat(
      {this.name = "",
      this.lastMessage = "",
      this.image = "",
      this.time = "",
      this.isActive = false});
}

List chatsData = [
  Chat(
    name: "Aziz Bourmel",
    lastMessage: "Hope you are doing well",
    image: "assets/login.png",
    time: "3m ago",
    isActive: false,
  ),
  Chat(
    name: "Root Toor",
    lastMessage: "Hope you are doing well",
    image: "assets/login.png",
    time: "3m ago",
    isActive: false,
  ),
  Chat(
    name: "Amine Selmani",
    lastMessage: "Hope you are doing well",
    image: "assets/login.png",
    time: "1m ago",
    isActive: true,
  ),
  Chat(
    name: "Ramdane Bg",
    lastMessage: "Hope you are doing well",
    image: "assets/login.png",
    time: "3m ago",
    isActive: true,
  ),
];
