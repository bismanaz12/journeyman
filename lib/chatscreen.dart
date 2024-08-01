import 'package:flutter/material.dart';
import 'package:mechanic_app/usermodel.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({Key? key, this.user}) : super(key: key);
  Usermodel? user;
  TextEditingController msg = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.blue[900],
          title: Row(
            children: [
              CircleAvatar(
                radius: media.size.height * 0.03,
                backgroundImage: NetworkImage(user!.image),
              ),
              SizedBox(
                width: media.size.height * 0.02,
              ),
              Text(
                user!.name,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white,
          // decoration: const BoxDecoration(
          //   gradient: LinearGradient(
          //       colors: [
          //         Color.fromARGB(255, 105, 79, 201),
          //         Color.fromARGB(255, 212, 176, 235),
          //         Color(0xffdbd5e0),
          //       ],
          //       begin: FractionalOffset(1.0, .02),
          //       end: FractionalOffset(1, 0.8)),
          // ),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: 10, // example message count
                  itemBuilder: (context, index) {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: msg,
                        decoration: InputDecoration(
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
                          fixedSize: Size(media.size.height * 0.06,
                              media.size.height * 0.06)),
                      iconSize: media.size.height * 0.03,
                      icon: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        // send message functionality
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
