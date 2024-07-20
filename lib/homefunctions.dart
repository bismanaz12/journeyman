import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class box1 extends StatelessWidget {
  const box1({
    super.key,
    required MediaQueryData mediaQuery,
    required this.text,
    required this.text1,
    required this.icon,
    required this.color,
    required this.color1,
  }) : _mediaQuery = mediaQuery;

  final MediaQueryData _mediaQuery;
  final String text;
  final String text1;
  final IconData icon;
  final Color color;
  final Color color1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: _mediaQuery.size.height * .12,
        width: _mediaQuery.size.width * .42,
        color: color,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: TextStyle(color: Colors.white),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      icon,
                      color: color1,
                    ),
                    SizedBox(
                      width: _mediaQuery.size.width * .03,
                    ),
                    Text(
                      text1,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class customer_task extends StatelessWidget {
  const customer_task({
    super.key,
    required MediaQueryData mediaQuery,
  }) : _mediaQuery = mediaQuery;

  final MediaQueryData _mediaQuery;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: _mediaQuery.size.height * .38,
        width: _mediaQuery.size.width * 2,
        decoration: BoxDecoration(color: Colors.grey.shade200),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'TASK #13424 ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade500,
                        fontSize: 15),
                  ),
                  Container(
                    height: 25,
                    width: 50,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        border: Border.all(color: Colors.grey.shade500)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.watch_later,
                          size: 18,
                        ),
                        Text('3h')
                      ],
                    ),
                  ),
                  Container(
                    height: 25,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Color(0xfffbbe4a),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('In Progress',
                            style: TextStyle(fontSize: 16, color: Colors.white))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Container(
                  height: 25,
                  width: 15,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                ),
                Text(
                  '- - - - - - - - - - - - - - - - - - - - - -',
                  style: TextStyle(fontSize: 25, color: Colors.grey.shade500),
                ),
                Spacer(),
                Container(
                  height: 25,
                  width: 15,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20))),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'AC Servise or filter changed and \nall glass tint',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                '16 hour left',
                style: TextStyle(fontSize: 15, color: Colors.red),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Colors.blue,
                    size: 50,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Auto Extreme Multan',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        '2.5 km',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
 
  }
}
