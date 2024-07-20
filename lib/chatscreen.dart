import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 89, 91, 179),
          title: Text('Daisy'),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 105, 79, 201),
                  Color.fromARGB(255, 212, 176, 235),
                  Color(0xffdbd5e0),
                ],
                begin: FractionalOffset(1.0, .02),
                end: FractionalOffset(1, 0.8)),
          ),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: 10, // example message count
                  itemBuilder: (context, index) {
                    bool isMe = index % 2 ==
                        0; // example condition to differentiate user messages
                    return Align(
                      alignment:
                          isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isMe ? Colors.blue : Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'Message $index', // example message text
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Type a message',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send),
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