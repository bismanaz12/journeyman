import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TasksDetail extends StatelessWidget {
  const TasksDetail({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: media.size.height * 0.01),
      height: media.size.height * 0.2,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              Text(
                'Task #14304',
                style: TextStyle(
                    color: Color.fromARGB(255, 202, 195, 195),
                    fontSize: media.size.height * 0.02),
              ),
              SizedBox(
                width: media.size.height * 0.06,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(
                          media.size.height * 0.1, media.size.height * 0.04),
                      shape: RoundedRectangleBorder()),
                  onPressed: () {},
                  child: Row(
                    children: [
                      Icon(
                        Icons.alarm_sharp,
                        color: Colors.black,
                      ),
                      Text(
                        '3h',
                        style: TextStyle(color: Colors.black),
                      )
                    ],
                  )),
              SizedBox(
                width: media.size.height * 0.01,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                      fixedSize: Size(media.size.height * 0.1 * 1.5,
                          media.size.height * 0.04),
                      shape: RoundedRectangleBorder()),
                  onPressed: () {},
                  child: Row(
                    children: [
                      Text(
                        'In progress',
                        style: TextStyle(color: Colors.red),
                      )
                    ],
                  ))
            ],
          ),
          Text(
            'AC condencer with 3 outdoor units maintenance',
            style: TextStyle(
                color: Colors.black, fontSize: media.size.height * 0.02 * 1.4),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '16 hours left',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
