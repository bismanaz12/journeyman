import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:mechanic_app/homefunctions.dart';
import 'package:mechanic_app/taskmodel.dart';
import 'package:mechanic_app/usermodel.dart';

class Home_Screen extends StatelessWidget {
  const Home_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    var _mediaQuery = MediaQuery.of(context);
    return Scaffold(
        appBar: AppBar(
          // title: RichText(
          //     text: TextSpan(
          //         text: 'Welcome,',
          //         style: TextStyle(color: Colors.black, fontSize: 18),
          //         children: [
          //       TextSpan(
          //           text: 'Hamza\'s Garage',
          //           style: TextStyle(color: Colors.blue, fontSize: 18))
          //     ])),
          title: Text(
            'Welcome, Hamza\'s Garage ',
            style: TextStyle(fontSize: 18),
          ),
          backgroundColor: Colors.white,
        ),
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
                      StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('tasks')
                              .where('takeTask', isEqualTo: true)
                              .snapshots(),
                          builder: (context, snapshot) {
                            return Expanded(
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      var data = snapshot.data!.docs
                                          .map((e) =>
                                              Taskmodel.frommap(e.data()))
                                          .toList();

                                      return Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Container(
                                          height: _mediaQuery.size.height * .38,
                                          width: _mediaQuery.size.width * 2,
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade200),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text(
                                                      'Task: #${data[index].task}',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors
                                                              .grey.shade500,
                                                          fontSize: 15),
                                                    ),
                                                    Container(
                                                      height: 25,
                                                      width: 50,
                                                      decoration: BoxDecoration(
                                                          color: Colors
                                                              .grey.shade300,
                                                          border: Border.all(
                                                              color: Colors.grey
                                                                  .shade500)),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
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
                                                        color:
                                                            Color(0xfffbbe4a),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          StreamBuilder(
                                                              stream: FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'users')
                                                                  .doc(data[
                                                                          index]
                                                                      .techId)
                                                                  .snapshots(),
                                                              builder: (context,
                                                                  snapshot) {
                                                                var dara =
                                                                    snapshot
                                                                        .data!
                                                                        .data();
                                                                Usermodel
                                                                    model =
                                                                    Usermodel
                                                                        .fromMap(
                                                                            dara!);
                                                                return Text(
                                                                    model.process.contains(data[index]
                                                                            .taskId)
                                                                        ? 'In Process'
                                                                        : model.pending.contains(data[index]
                                                                                .taskId)
                                                                            ? 'Pending'
                                                                            : model.ontrip.contains(data[index]
                                                                                    .taskId)
                                                                                ? 'on Trip'
                                                                                : '',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        color: Colors
                                                                            .white));
                                                              })
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
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        20),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        20))),
                                                  ),
                                                  Text(
                                                    '- - - - - - - - - - - - - - - - - - - - - - - - - -',
                                                    style: TextStyle(
                                                        fontSize: 25,
                                                        color: Colors
                                                            .grey.shade500),
                                                  ),
                                                  Spacer(),
                                                  Container(
                                                    height: 25,
                                                    width: 15,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        20),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        20))),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: Text(
                                                  data[index].productname,
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.black),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: Text(
                                                  '16 hour left',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.red),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              StreamBuilder(
                                                  stream: FirebaseFirestore
                                                      .instance
                                                      .collection('users')
                                                      .doc(data[index]
                                                          .customerId)
                                                      .snapshots(),
                                                  builder: (context, snapshot) {
                                                    var data =
                                                        snapshot.data!.data();
                                                    Usermodel cus =
                                                        Usermodel.fromMap(
                                                            data!);
                                                    return Padding(
                                                      padding: EdgeInsets.only(
                                                          left: _mediaQuery
                                                                  .size.height *
                                                              0.02),
                                                      child: Row(
                                                        children: [
                                                          CircleAvatar(
                                                            radius: _mediaQuery
                                                                    .size
                                                                    .height *
                                                                0.03,
                                                            backgroundImage:
                                                                NetworkImage(
                                                                    cus.image),
                                                          ),
                                                          SizedBox(
                                                            width: _mediaQuery
                                                                    .size
                                                                    .height *
                                                                0.01,
                                                          ),
                                                          Text(
                                                            cus.name,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: _mediaQuery
                                                                        .size
                                                                        .height *
                                                                    0.02),
                                                          )
                                                        ],
                                                      ),
                                                    );
                                                  }),
                                              SizedBox(
                                                height:
                                                    _mediaQuery.size.height *
                                                        0.04,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: _mediaQuery
                                                            .size.height *
                                                        0.01),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.location_on,
                                                      color: Colors.blue,
                                                      size: 50,
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        StreamBuilder(
                                                            stream: FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'users')
                                                                .doc(data[index]
                                                                    .customerId)
                                                                .snapshots(),
                                                            builder: (context,
                                                                snapshot) {
                                                              var dataa =
                                                                  snapshot.data!
                                                                      .data();
                                                              Usermodel cus =
                                                                  Usermodel
                                                                      .fromMap(
                                                                          dataa!);
                                                              return Container(
                                                                width: _mediaQuery
                                                                        .size
                                                                        .height *
                                                                    0.1 *
                                                                    1.5,
                                                                child: Text(
                                                                  cus.address,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16),
                                                                ),
                                                              );
                                                            }),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      width: _mediaQuery
                                                              .size.height *
                                                          0.08,
                                                    ),
                                                    Text(
                                                      'View Details',
                                                      style: TextStyle(
                                                          fontSize: _mediaQuery
                                                                  .size.height *
                                                              0.02,
                                                          color:
                                                              Colors.blue[600]),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }));
                          })
                    ])))));
  }
}
