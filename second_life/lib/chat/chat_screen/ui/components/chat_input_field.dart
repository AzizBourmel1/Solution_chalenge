import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:secondlife/chat/chat_screen/modele/chat_message.dart';

class ChatInputField extends StatefulWidget {
  const ChatInputField({super.key});
  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  final messageContoller = TextEditingController();
  @override
  void initState() {
    super.initState();
    messageContoller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.green[200],
        borderRadius: BorderRadius.circular(30),
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.sentiment_satisfied_alt,
                      color: Colors.grey[800],
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: TextField(
                        controller: messageContoller,
                        decoration: InputDecoration(
                            hintText: "Type a message",
                            border: InputBorder.none),
                      ),
                    ),
                    messageContoller.text.isEmpty
                        ? IconButton(
                            onPressed: () async {
                              print("Gallary Clicked");
                              XFile? file = await ImagePicker()
                                  .pickImage(source: ImageSource.gallery);
                              print(file!.path);

                              final message = ChatMessage(
                                  messageType: ChatMessageType.image,
                                  messageStatus: MessageStatus.viewed,
                                  isSender: true,
                                  imageUrl: file.path);
                              //final storage = FirebaseStorage.instance;
                              //final firestore = FirebaseFirestore.instance;
                              //final user = FirebaseAuth.instance.currentUser;
                              // final ref = storage.ref().child('images').child(
                              //           DateTime.now().toIso8601String() + file.name);
                              //       await ref.putFile(File(file.path));
                              //       final url = await ref.getDownloadURL();
                              //       print(url);
                              // Map<String, dynamic> document = {
                              //         'image': url,
                              //         'senderId': user?.uid,
                              //         'senderName': user?.displayName,
                              //         'senderImage': user?.photoURL,
                              //         'type': 1,
                              //         'timestamp': DateTime.now(),
                              //       };
                              // firestore
                              //           .collection('messages')
                              //           .add(document)
                              //           .then((value) => print(value.id));
                              //     },
                            },
                            icon: Icon(
                              Icons.attach_file_outlined,
                              color: Colors.grey[800],
                            ),
                          )
                        : SizedBox(),
                    messageContoller.text.isEmpty
                        ? SizedBox(
                            width: 5.0,
                          )
                        : SizedBox(),
                    messageContoller.text.isEmpty
                        ? IconButton(
                            onPressed: () async {
                              print("Camera Clicked");
                              XFile? file = await ImagePicker()
                                  .pickImage(source: ImageSource.camera);
                              print(file!.path);
                              final message = ChatMessage(
                                messageType: ChatMessageType.image,
                                messageStatus: MessageStatus.viewed,
                                isSender: true,
                                imageUrl: file.path,
                              );

                              //   final storage = FirebaseStorage.instance;
                              //   final firestore = FirebaseFirestore.instance;
                              //   final user = FirebaseAuth.instance.currentUser;

                              //   final ref = storage.ref().child('images').child(
                              //       DateTime.now().toIso8601String() + file.name);
                              //   await ref.putFile(File(file.path));
                              //   final url = await ref.getDownloadURL();
                              //   print(url);

                              //   Map<String, dynamic> document = {
                              //     'image': url,
                              //     'senderId': user?.uid,
                              //     'senderName': user?.displayName,
                              //     'senderImage': user?.photoURL,
                              //     'type': 1,
                              //     'timestamp': DateTime.now(),
                              //   };
                              //   firestore
                              //       .collection('messages')
                              //       .add(document)
                              //       .then((value) => print(value.id));
                            },
                            icon: Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.grey[800],
                            ))
                        : SizedBox(),
                    messageContoller.text.isNotEmpty
                        ? SizedBox(
                            width: 5.0,
                          )
                        : SizedBox(),
                    messageContoller.text.isNotEmpty
                        ? IconButton(
                            onPressed: () async {
                              final user = FirebaseAuth.instance.currentUser;
                              final message = messageContoller.text;
                              print(message);
                              final messageDoc = {
                                'message': message,
                                'id': user!.uid,
                                'sender': user.displayName,
                                'time': DateTime.now(),
                              };
                              //  final doc = await FirebaseFirestore.instance.collection('messages').add(messageDoc);
                              //  print(doc.path);
                              //  print(doc.id);
                            },
                            icon: Icon(
                              Icons.send,
                              color: Colors.green,
                            ),
                          )
                        : SizedBox(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
