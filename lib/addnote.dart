import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mechanic_app/features.dart';
import 'package:mechanic_app/taskmodel.dart';
import 'package:uuid/uuid.dart';

class Addnote extends StatefulWidget {
  Addnote({super.key, required this.image});
  List<File> image;

  @override
  State<Addnote> createState() => _AddnoteState();
}

class _AddnoteState extends State<Addnote> {
  TextEditingController note = TextEditingController();

  String txt = '';

  Future<List<String>> uploadImages(List<File> images) async {
    List<String> downloadUrls = [];

    for (File image in images) {
      String id = const Uuid().v4();
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child('images').child('$id.png');

      try {
        // Upload image to Firebase Storage
        await ref.putFile(image);

        // Get download URL of uploaded image
        String imageUrl = await ref.getDownloadURL();
        downloadUrls.add(imageUrl);
      } catch (e) {
        print('Error uploading image: $e');
        // Handle error as per your application's requirement
      }
    }

    return downloadUrls;
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: InkWell(
            onTap: () async {
              if (txt.isNotEmpty && widget.image.isNotEmpty) {
                String id = Uuid().v4();
                List url = await uploadImages(widget.image);
                Taskmodel model = Taskmodel(photo: url, note: txt);

                await FirebaseFirestore.instance
                    .collection('tasks')
                    .doc(id)
                    .set(model.tomap());

                setState(() {
                  txt = '';
                });
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Camera()));
              }
            },
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Next',
                style: TextStyle(
                    color: Colors.blue[600],
                    fontWeight: FontWeight.bold,
                    fontSize: media.size.height * 0.03),
              ),
            )),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: media.size.height * 0.02),
        child: Column(
          children: [
            Expanded(
                child: Container(
              child: Column(
                children: [
                  txt.isNotEmpty
                      ? Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // CircleAvatar(backgroundImage:NetworkImage(img),radius: 20,),
                              Expanded(
                                  child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 16),
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 223, 218, 218),
                                          borderRadius: const BorderRadius.only(
                                            topRight:
                                                Radius.elliptical(-30, 50),
                                            topLeft: Radius.circular(15),
                                            bottomLeft: Radius.circular(15),
                                            bottomRight: Radius.circular(15),
                                          )),
                                      child: Text(
                                        txt,
                                        style: const TextStyle(
                                            color: Colors.blue, fontSize: 20),
                                      ))),
                            ],
                          ),
                        )
                      : Text('')
                ],
              ),
            )),
            Row(children: [
              Container(
                width: media.size.height * 0.3 * 1.2,
                child: TextFormField(
                  controller: note,
                  decoration: InputDecoration(
                    hintText: 'Addnote.....',
                    hintStyle: TextStyle(
                        color: Colors.blue[600],
                        fontSize: media.size.height * 0.02),
                    filled: true,
                    fillColor: Color.fromARGB(255, 231, 225, 225),
                    constraints: BoxConstraints(
                      maxHeight: 50,
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                  ),
                ),
              ),
              IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.blue[600],
                    shape: CircleBorder(),
                  ),
                  onPressed: () {
                    txt = note.text;
                    setState(() {});
                    note.clear();
                  },
                  icon: Icon(
                    Icons.send,
                    color: Colors.white,
                    size: media.size.height * 0.03 * 1.2,
                  ))
            ]),
          ],
        ),
      ),
    );
  }
}
