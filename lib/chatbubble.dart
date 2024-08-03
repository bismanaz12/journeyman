import 'package:flutter/material.dart';
import 'package:mechanic_app/chatmodel.dart';
import 'package:mechanic_app/customeplayer.dart';

class Bubble extends StatelessWidget {
  Bubble(
      {super.key,
      required this.img,
      required this.txt,
      required this.name,
      required this.me,
      required this.read,
      required this.type});
  bool me;
  String name;
  String img;
  String txt;
  bool read;
  messageType type;
  @override
  Widget build(BuildContext context) {
    return me
        ? Padding(
            padding: const EdgeInsets.only(left: 50.0),
            child: type == messageType.text
                ? Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
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
                                    color: Color.fromARGB(255, 225, 221, 221),
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.elliptical(-30, 50),
                                      topLeft: Radius.circular(15),
                                      bottomLeft: Radius.circular(15),
                                      bottomRight: Radius.circular(15),
                                    )),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      txt,
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 20),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          'time',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Color.fromARGB(
                                                  255, 19, 27, 105)),
                                        ),
                                        Icon(
                                          read
                                              ? Icons.done_all_rounded
                                              : Icons.check,
                                          color: read
                                              ? Colors.green
                                              : Colors.black,
                                        ),
                                      ],
                                    )
                                  ],
                                ))),
                      ],
                    ),
                  )
                : type == messageType.video
                    ? Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 16),
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 10),
                                      height: 200,
                                      width: 170,
                                      child: CustomPlayer(
                                        videoPlayer: txt,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          'time',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Color.fromARGB(
                                                  255, 19, 27, 105)),
                                        ),
                                        Icon(
                                          read
                                              ? Icons.done_all_rounded
                                              : Icons.check,
                                          color: read
                                              ? Colors.green
                                              : Colors.black,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    // : type == messageType.voice
                    //     ? VoiceMessageView(
                    //         activeSliderColor: Colors.black54,
                    //         controller: VoiceController(
                    //           audioSrc: txt,
                    //           maxDuration: const Duration(seconds: 60),
                    //           isFile: false,
                    //           onComplete: () {},
                    //           onPause: () {},
                    //           onPlaying: () {},
                    //           onError: (err) {},
                    //         ),
                    // )
                    : Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 16),
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 10),
                                      height: 200,
                                      child: Image.network(txt),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          'time',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Color.fromARGB(
                                                  255, 19, 27, 105)),
                                        ),
                                        Icon(
                                          read
                                              ? Icons.done_all_rounded
                                              : Icons.check,
                                          color: read
                                              ? Colors.green
                                              : Colors.black,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ))
        : Padding(
            padding: const EdgeInsets.only(right: 50),
            child: type == messageType.text
                ? Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                    //     margin: const EdgeInsets.symmetric(vertical: 4),
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // CircleAvatar(
                        //   backgroundImage: NetworkImage(img),
                        //   radius: 27,
                        // ),
                        // const SizedBox(
                        //   width: 3,
                        // ),
                        Expanded(
                          child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 16),
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 163, 160, 160),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.elliptical(-30, 50),
                                    topRight: Radius.circular(15),
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                  )),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Text(name,
                                  //     style: const TextStyle(
                                  //         color: Colors.yellow,
                                  //         fontFamily: 'Simple',
                                  //         fontSize: 20)),
                                  Text(
                                    txt,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      'time',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color:
                                              Color.fromARGB(255, 19, 27, 105)),
                                    ),
                                  )
                                ],
                              )),
                        ),
                      ],
                    ),
                  )
                : type == messageType.video
                    ? Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 16),
                          //     margin: const EdgeInsets.symmetric(vertical: 4),
                          alignment: Alignment.centerRight,

                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // CircleAvatar(
                                //   backgroundImage: NetworkImage(img),
                                //   radius: 27,
                                // ),
                                // const SizedBox(
                                //   width: 3,
                                // ),
                                Expanded(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 10),
                                      height: 240,
                                      width: 170,
                                      child: Column(
                                        children: [
                                          CustomPlayer(
                                            videoPlayer: txt,
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              'time',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Color.fromARGB(
                                                      255, 19, 27, 105)),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                              ]),
                        ),
                      )
                    // : type == messageType.voice
                    //     ? VoiceMessageView(
                    //         activeSliderColor: Colors.green,
                    //         controller: VoiceController(
                    //           audioSrc: txt,
                    //           maxDuration: const Duration(seconds: 60),
                    //           isFile: false,
                    //           onComplete: () {},
                    //           onPause: () {},
                    //           onPlaying: () {},
                    //           onError: (err) {},
                    //         ),
                    //       )
                    : Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 16),
                          //     margin: const EdgeInsets.symmetric(vertical: 4),
                          alignment: Alignment.centerRight,

                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // CircleAvatar(
                                //   backgroundImage: NetworkImage(img),
                                //   radius: 27,
                                // ),
                                // const SizedBox(
                                //   width: 3,
                                // ),
                                Expanded(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 10),
                                      height: 240,
                                      width: 170,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.network(
                                            txt,
                                            height: 200,
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              'time',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Color.fromARGB(
                                                      255, 19, 27, 105)),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                              ]),
                        ),
                      ));
  }
}
