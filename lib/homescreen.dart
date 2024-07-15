import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:mechanic_app/homefunctions.dart';

class Home_Screen extends StatelessWidget {
  const Home_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    var _mediaQuery = MediaQuery.of(context);
    return Scaffold(
        // appBar: AppBar(
        //   // title: RichText(
        //   //     text: TextSpan(
        //   //         text: 'Welcome,',
        //   //         style: TextStyle(color: Colors.black, fontSize: 18),
        //   //         children: [
        //   //       TextSpan(
        //   //           text: 'Hamza\'s Garage',
        //   //           style: TextStyle(color: Colors.blue, fontSize: 18))
        //   //     ])),
        //   // title: Text(
        //   //   'Welcome, Hamza\'s Garage ',
        //   //   style: TextStyle(fontSize: 18),
        //   // ),
        //   backgroundColor: Colors.white,
        // ),
        body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/whitebackground.jpg'),
                fit: BoxFit.fill,
              ),
            ),
            child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/Images/whitebackground.jpg'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 60,
                        width: double.infinity,
                        color: Colors.grey.shade300,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/brand.jpg'),
                                        fit: BoxFit.fill)),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            RichText(
                                text: TextSpan(
                                    text: 'Welcome,',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18),
                                    children: [
                                  TextSpan(
                                      text: 'Hamza\'s Garage',
                                      style: TextStyle(
                                          color: Colors.blue, fontSize: 18))
                                ])),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.roofing_outlined),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: _mediaQuery.size.height * .02,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              box1(
                                mediaQuery: _mediaQuery,
                                text1: 'Active',
                                text: 'My status',
                                icon: Icons.radio_button_checked,
                                color1: Color(0xff9bf9d3),
                                color: Color(0xff3db692),
                              ),
                              box1(
                                mediaQuery: _mediaQuery,
                                text1: '32 h',
                                text: 'Total work hour',
                                icon: Icons.watch_later_outlined,
                                color1: Colors.white,
                                color: Color(0xff5476fd),
                              ),
                              box1(
                                mediaQuery: _mediaQuery,
                                text1: '1 min ago',
                                text: 'Complete task',
                                icon: Icons.task,
                                color1: Colors.white,
                                color: Color(0xff2b9bed),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Active Task',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: 5,
                          itemBuilder: (context, index) =>
                              customer_task(mediaQuery: _mediaQuery),
                        ),
                      )
                    ],
                  ),
                ))));
  }
}
