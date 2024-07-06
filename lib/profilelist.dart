import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfileList extends StatelessWidget {
  ProfileList(
      {super.key,
      required this.icon,
      required this.text,
      required this.text2,
      required this.icon2});
  IconData icon;
  String text;
  IconData icon2;
  String text2;
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context);
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: media.size.height * 0.02),
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.black,
              ),
              Padding(
                padding: EdgeInsets.only(left: media.size.height * 0.02),
                child: Expanded(
                  child: Container(
                    width: media.size.height * 0.1 * 1.5,
                    child: Text(
                      text,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: media.size.height * 0.02 * 1.3,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: media.size.height * 0.04),
                child: Expanded(
                  child: Container(
                    width: media.size.height * 0.07,
                    child: Text(
                      text2,
                      style: TextStyle(
                          color: Color.fromARGB(255, 211, 205, 205),
                          fontSize: media.size.height * 0.02),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: media.size.height * 0.08),
                child: Icon(icon2, color: Color.fromARGB(255, 211, 205, 205)),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: media.size.height * 0.02),
          child: Divider(
            color: Color.fromARGB(255, 211, 205, 205),
            thickness: media.size.height * 0.002,
          ),
        )
      ],
    );
  }
}
