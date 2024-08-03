import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:mechanic_app/chatbubble.dart';
import 'package:mechanic_app/chatmodel.dart';
import 'package:mechanic_app/customeplayer.dart';
import 'package:mechanic_app/imagepicker.dart';
import 'package:mechanic_app/recentmodel.dart';
import 'package:mechanic_app/usermodel.dart';
import 'package:mechanic_app/userprovider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({Key? key, this.user, this.Id, this.image, this.name})
      : super(key: key);
  final Usermodel? user;
  final String? image;
  final String? Id;
  final String? name;
  final TextEditingController msg = TextEditingController();

  String mergeId(String receiverId) {
    String recId = user == null ? Id! : user!.id;
    return FirebaseAuth.instance.currentUser!.uid.hashCode <= recId.hashCode
        ? '${FirebaseAuth.instance.currentUser!.uid}_$recId'
        : '${recId}_${FirebaseAuth.instance.currentUser!.uid}';
  }

  Future<String> uploadImage(File file) async {
    String id = const Uuid().v4();
    String url = '';
    FirebaseStorage storage = FirebaseStorage.instance;
    TaskSnapshot taskSnapshot =
        await storage.ref().child('chats').child('$id.png').putFile(file);
    url = await taskSnapshot.ref.getDownloadURL();
    return url;
  }

  @override
  Widget build(BuildContext context) {
    String recId = user == null ? Id! : user!.id;
    String recName = user == null ? name! : user!.name;
    String recImage = user == null ? image! : user!.image;
    var media = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue[900],
        title: Row(
          children: [
            CircleAvatar(
              radius: media.size.height * 0.03,
              backgroundImage: NetworkImage(recImage),
            ),
            SizedBox(
              width: media.size.height * 0.02,
            ),
            Text(
              recName,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('chats')
                  .doc(mergeId(recId))
                  .collection('messages')
                  .orderBy('time', descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data!.docs
                      .map((e) => Chatmodel.fromMap(e.data()))
                      .toList();
                  for (var message in data) {
                    if (!message.read &&
                        message.receiverId ==
                            FirebaseAuth.instance.currentUser!.uid) {
                      FirebaseFirestore.instance
                          .collection('chats')
                          .doc(mergeId(recId))
                          .collection('messages')
                          .doc(message.chatId)
                          .update({'read': true});
                    }
                  }

                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return Bubble(
                        read: data[index].read,
                        img: recImage,
                        txt: data[index].message,
                        name: recName,
                        me: data[index].senderId ==
                            FirebaseAuth.instance.currentUser!.uid,
                        type: data[index].type,
                      );
                    },
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
          Consumer<ImagePickerProvider>(
            builder: (context, imagePickerProvider, _) {
              return imagePickerProvider.image != null
                  ? Column(
                      children: [
                        Container(
                          height: media.size.height * 0.3,
                          width: media.size.height * 0.3 * 1.2,
                          child: Image.file(
                            imagePickerProvider.image!,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: media.size.height * 0.3 * 1.2,
                                child: TextField(
                                  controller: msg,
                                  decoration: InputDecoration(
                                    prefixIcon: PopupMenuButton(
                                      icon: Icon(
                                        Icons.image_outlined,
                                        color: Colors.grey[700],
                                        size: media.size.height * 0.04,
                                      ),
                                      onSelected: (value) {
                                        if (value == 'Image') {
                                          imagePickerProvider.Imagepicker();
                                        } else {
                                          imagePickerProvider.pickvideo();
                                        }
                                      },
                                      itemBuilder: (context) {
                                        return [
                                          PopupMenuItem(
                                            child: Text('Image'),
                                            value: 'Image',
                                          ),
                                          PopupMenuItem(
                                            child: Text('Video'),
                                            value: 'Video',
                                          ),
                                        ];
                                      },
                                    ),
                                    hintText: 'Type a message',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                style: IconButton.styleFrom(
                                  backgroundColor: Colors.blue[900],
                                  fixedSize: Size(media.size.height * 0.07,
                                      media.size.height * 0.07),
                                ),
                                iconSize: media.size.height * 0.03,
                                icon: Icon(
                                  Icons.send,
                                  color: Colors.white,
                                ),
                                onPressed: () async {
                                  if (msg.text.isNotEmpty) {
                                    String chatId = Uuid().v4();
                                    var senderUser = Provider.of<UserProvider>(
                                            context,
                                            listen: false)
                                        .user;

                                    Chatmodel model = Chatmodel(
                                      read: false,
                                      Name: recName,
                                      chatId: chatId,
                                      image: recImage,
                                      message: msg.text,
                                      receiverId: recId,
                                      senderId: senderUser!.id,
                                      time: DateTime.now(),
                                      type: messageType.text,
                                    );

                                    var recentlyModel = RecentlyModel(
                                      sendername: senderUser.name,
                                      receivername: recName,
                                      senderimage: senderUser.image,
                                      receiverimage: recImage,
                                      message: msg.text,
                                      receiverId: recId,
                                      senderId: senderUser.id,
                                      time: DateTime.now(),
                                      userschatId: mergeId(recId),
                                      type: messageType.text,
                                    );

                                    String chat = mergeId(recId);
                                    await FirebaseFirestore.instance
                                        .collection('chats')
                                        .doc(chat)
                                        .collection('messages')
                                        .doc(chatId)
                                        .set(model.tomap());
                                    await FirebaseFirestore.instance
                                        .collection('chats')
                                        .doc(chat)
                                        .set(recentlyModel.tomap());

                                    msg.clear();
                                  } else if (imagePickerProvider.image !=
                                      null) {
                                    String chatId = Uuid().v4();
                                    var senderUser = Provider.of<UserProvider>(
                                            context,
                                            listen: false)
                                        .user;
                                    String url = await uploadImage(
                                        imagePickerProvider.image!);

                                    Chatmodel model = Chatmodel(
                                      read: false,
                                      Name: recName,
                                      chatId: chatId,
                                      image: recImage,
                                      message: url,
                                      receiverId: recId,
                                      senderId: senderUser!.id,
                                      time: DateTime.now(),
                                      type: messageType.image,
                                    );

                                    var recentlyModel = RecentlyModel(
                                      sendername: senderUser.name,
                                      receivername: recName,
                                      senderimage: senderUser.image,
                                      receiverimage: recImage,
                                      message: url,
                                      receiverId: recId,
                                      senderId: senderUser.id,
                                      time: DateTime.now(),
                                      userschatId: mergeId(recId),
                                      type: messageType.image,
                                    );

                                    String chat = mergeId(recId);
                                    await FirebaseFirestore.instance
                                        .collection('chats')
                                        .doc(chat)
                                        .collection('messages')
                                        .doc(chatId)
                                        .set(model.tomap());
                                    await FirebaseFirestore.instance
                                        .collection('chats')
                                        .doc(chat)
                                        .set(recentlyModel.tomap());

                                    imagePickerProvider.setimagenull(null);
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : imagePickerProvider.video != null
                      ? Column(
                          children: [
                            Container(
                                height: media.size.height * 0.3,
                                width: media.size.height * 0.3 * 1.2,
                                child: Player(
                                    videoplayer: imagePickerProvider.video!)),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: media.size.height * 0.3 * 1.2,
                                    child: TextField(
                                      controller: msg,
                                      decoration: InputDecoration(
                                        prefixIcon: PopupMenuButton(
                                          icon: Icon(
                                            Icons.image_outlined,
                                            color: Colors.grey[700],
                                            size: media.size.height * 0.04,
                                          ),
                                          onSelected: (value) {
                                            if (value == 'Image') {
                                              imagePickerProvider.Imagepicker();
                                            } else {
                                              imagePickerProvider.pickvideo();
                                            }
                                          },
                                          itemBuilder: (context) {
                                            return [
                                              PopupMenuItem(
                                                child: Text('Image'),
                                                value: 'Image',
                                              ),
                                              PopupMenuItem(
                                                child: Text('Video'),
                                                value: 'Video',
                                              ),
                                            ];
                                          },
                                        ),
                                        hintText: 'Type a message',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    style: IconButton.styleFrom(
                                      backgroundColor: Colors.blue[900],
                                      fixedSize: Size(media.size.height * 0.07,
                                          media.size.height * 0.07),
                                    ),
                                    iconSize: media.size.height * 0.03,
                                    icon: Icon(
                                      Icons.send,
                                      color: Colors.white,
                                    ),
                                    onPressed: () async {
                                      if (msg.text.isNotEmpty) {
                                        String chatId = Uuid().v4();
                                        var senderUser =
                                            Provider.of<UserProvider>(context,
                                                    listen: false)
                                                .user;

                                        Chatmodel model = Chatmodel(
                                          read: false,
                                          Name: recName,
                                          chatId: chatId,
                                          image: recImage,
                                          message: msg.text,
                                          receiverId: recId,
                                          senderId: senderUser!.id,
                                          time: DateTime.now(),
                                          type: messageType.text,
                                        );

                                        var recentlyModel = RecentlyModel(
                                          sendername: senderUser.name,
                                          receivername: recName,
                                          senderimage: senderUser.image,
                                          receiverimage: recImage,
                                          message: msg.text,
                                          receiverId: recId,
                                          senderId: senderUser.id,
                                          time: DateTime.now(),
                                          userschatId: mergeId(recId),
                                          type: messageType.text,
                                        );

                                        String chat = mergeId(recId);
                                        await FirebaseFirestore.instance
                                            .collection('chats')
                                            .doc(chat)
                                            .collection('messages')
                                            .doc(chatId)
                                            .set(model.tomap());
                                        await FirebaseFirestore.instance
                                            .collection('chats')
                                            .doc(chat)
                                            .set(recentlyModel.tomap());

                                        msg.clear();
                                      } else if (imagePickerProvider.video !=
                                          null) {
                                        String chatId = Uuid().v4();
                                        var senderUser =
                                            Provider.of<UserProvider>(context,
                                                    listen: false)
                                                .user;
                                        String url = await uploadImage(
                                            imagePickerProvider.video!);

                                        Chatmodel model = Chatmodel(
                                          read: false,
                                          Name: recName,
                                          chatId: chatId,
                                          image: recImage,
                                          message: url,
                                          receiverId: recId,
                                          senderId: senderUser!.id,
                                          time: DateTime.now(),
                                          type: messageType.video,
                                        );

                                        var recentlyModel = RecentlyModel(
                                          sendername: senderUser.name,
                                          receivername: recName,
                                          senderimage: senderUser.image,
                                          receiverimage: recImage,
                                          message: url,
                                          receiverId: recId,
                                          senderId: senderUser.id,
                                          time: DateTime.now(),
                                          userschatId: mergeId(recId),
                                          type: messageType.video,
                                        );

                                        String chat = mergeId(recId);
                                        await FirebaseFirestore.instance
                                            .collection('chats')
                                            .doc(chat)
                                            .collection('messages')
                                            .doc(chatId)
                                            .set(model.tomap());
                                        await FirebaseFirestore.instance
                                            .collection('chats')
                                            .doc(chat)
                                            .set(recentlyModel.tomap());

                                        imagePickerProvider.setvideonull(null);
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: media.size.height * 0.3 * 1.2,
                                child: TextField(
                                  controller: msg,
                                  decoration: InputDecoration(
                                    prefixIcon: PopupMenuButton(
                                      icon: Icon(
                                        Icons.image_outlined,
                                        color: Colors.grey[700],
                                        size: media.size.height * 0.04,
                                      ),
                                      onSelected: (value) {
                                        if (value == 'Image') {
                                          imagePickerProvider.Imagepicker();
                                        } else {
                                          imagePickerProvider.pickvideo();
                                        }
                                      },
                                      itemBuilder: (context) {
                                        return [
                                          PopupMenuItem(
                                            child: Text('Image'),
                                            value: 'Image',
                                          ),
                                          PopupMenuItem(
                                            child: Text('Video'),
                                            value: 'Video',
                                          ),
                                        ];
                                      },
                                    ),
                                    hintText: 'Type a message',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                style: IconButton.styleFrom(
                                  backgroundColor: Colors.blue[900],
                                  fixedSize: Size(media.size.height * 0.07,
                                      media.size.height * 0.07),
                                ),
                                iconSize: media.size.height * 0.03,
                                icon: Icon(
                                  Icons.send,
                                  color: Colors.white,
                                ),
                                onPressed: () async {
                                  if (msg.text.isNotEmpty) {
                                    String chatId = Uuid().v4();
                                    var senderUser = Provider.of<UserProvider>(
                                            context,
                                            listen: false)
                                        .user;

                                    Chatmodel model = Chatmodel(
                                      read: false,
                                      Name: recName,
                                      chatId: chatId,
                                      image: recImage,
                                      message: msg.text,
                                      receiverId: recId,
                                      senderId: senderUser!.id,
                                      time: DateTime.now(),
                                      type: messageType.text,
                                    );

                                    var recentlyModel = RecentlyModel(
                                      sendername: senderUser.name,
                                      receivername: recName,
                                      senderimage: senderUser.image,
                                      receiverimage: recImage,
                                      message: msg.text,
                                      receiverId: recId,
                                      senderId: senderUser.id,
                                      time: DateTime.now(),
                                      userschatId: mergeId(recId),
                                      type: messageType.text,
                                    );

                                    String chat = mergeId(recId);
                                    await FirebaseFirestore.instance
                                        .collection('chats')
                                        .doc(chat)
                                        .collection('messages')
                                        .doc(chatId)
                                        .set(model.tomap());
                                    await FirebaseFirestore.instance
                                        .collection('chats')
                                        .doc(chat)
                                        .set(recentlyModel.tomap());

                                    msg.clear();
                                  }
                                },
                              ),
                            ],
                          ),
                        );
            },
          ),
        ],
      ),
    );
  }
}
