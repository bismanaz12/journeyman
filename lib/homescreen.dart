import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mechanic_app/customerprofile.dart';

import 'package:mechanic_app/homefunctions.dart';
import 'package:mechanic_app/notificationscreen.dart';

import 'package:mechanic_app/taskmodel.dart';
import 'package:mechanic_app/taskscreen.dart';
import 'package:mechanic_app/technicianprofile.dart';
import 'package:mechanic_app/usermodel.dart';
import 'package:mechanic_app/userprovider.dart';
import 'package:provider/provider.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key});

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  @override
  void initState() {
    Provider.of<UserProvider>(context, listen: false).getuser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<UserProvider>(context).user;
    var _mediaQuery = MediaQuery.of(context);
    return prov == null
        ? Center(
            child: SpinKitChasingDots(
            color: Colors.blue,
            duration: Duration(seconds: 2),
          ))
        : Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              // title: RichText(
              //     text: TextSpan(
              //         text: 'Welcome,',
              //         style: TextStyle(color: Colors.black, fontSize: 18),
              //         children: [
              //       TextSpan(
              //           text: 'Hamza\'s Garage',
              //           style: TextStyle(color: Colors.blue, fontSize: 18))
              //     ])),
              title: Row(
                children: [
                  InkWell(
                    onTap: () {
                      prov.persontype == 'customer'
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CustomerProfile(
                                        user: prov,
                                      )))
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TechnicianProfile()));
                    },
                    child: CircleAvatar(
                      radius: _mediaQuery.size.height * 0.03,
                      backgroundImage: NetworkImage(prov.image),
                    ),
                  ),
                  Text(
                    '  Welcome,  Hamza\'s Garage ',
                    style: TextStyle(
                        fontSize: _mediaQuery.size.height * 0.02,
                        color: Colors.blue[900],
                        fontFamily: 'MyFont',
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    width: _mediaQuery.size.height * 0.07,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NotificationScreen()));
                    },
                    child: Icon(
                      Icons.notifications_none_outlined,
                      color: Colors.black,
                      size: _mediaQuery.size.height * 0.04,
                    ),
                  )
                ],
              ),
              backgroundColor: Colors.white,
            ),
            body: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                    // image: DecorationImage(
                    //   image: AssetImage('assets/Images/whitebackground.jpg'),
                    //   fit: BoxFit.fill,
                    // ),
                    ),
                child: SafeArea(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      SizedBox(
                        height: _mediaQuery.size.height * .02,
                      ),
                      prov.persontype == 'customer'
                          ? StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('users')
                                  .where('persontype', isEqualTo: 'technician')
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  var data = snapshot.data!.docs
                                      .map((e) => Usermodel.fromMap(e.data()))
                                      .toList();

                                  return SizedBox(
                                    height: _mediaQuery.size.height * 0.1 * 1.3,
                                    child: ListView.builder(
                                        itemCount: data.length,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          TechnicianProfile(
                                                            tech: data[index],
                                                          )));
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    child: CircleAvatar(
                                                        radius: _mediaQuery
                                                                .size.height *
                                                            0.04,
                                                        backgroundImage:
                                                            NetworkImage(
                                                                data[index]
                                                                    .image)),
                                                  ),
                                                  Text(
                                                    data[index].name,
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                  );
                                }
                                return Text('');
                              })
                          : Padding(
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
                          style: TextStyle(
                              fontSize: _mediaQuery.size.height * 0.02 * 1.2,
                              fontFamily: 'Font'),
                        ),
                      ),
                      StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('tasks')
                              .where('takeTask', isEqualTo: true)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
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
                                            height:
                                                _mediaQuery.size.height * .38,
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
                                                  padding: const EdgeInsets.all(
                                                      16.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Text(
                                                        'Task: #${data[index].task}',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Colors
                                                                .grey[600],
                                                            fontSize: 15),
                                                      ),
                                                      Container(
                                                        height: 25,
                                                        width: 50,
                                                        decoration: BoxDecoration(
                                                            color: Colors
                                                                .grey.shade300,
                                                            border: Border.all(
                                                                color: Colors
                                                                    .grey)),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Icon(
                                                              Icons.watch_later,
                                                              size: 18,
                                                            ),
                                                            Text('3h'),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        height: _mediaQuery
                                                                .size.height *
                                                            0.03,
                                                        width: _mediaQuery
                                                                .size.height *
                                                            0.1 *
                                                            1.2,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Colors.blue[900],
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
                                                                  if (snapshot
                                                                      .hasData) {
                                                                    var dara =
                                                                        snapshot
                                                                            .data!
                                                                            .data();
                                                                    Usermodel
                                                                        model =
                                                                        Usermodel.fromMap(
                                                                            dara!);
                                                                    return Text(
                                                                        model.process.contains(data[index].taskId)
                                                                            ? 'In Process'
                                                                            : model.pending.contains(data[index].taskId)
                                                                                ? 'Pending'
                                                                                : model.ontrip.contains(data[index].taskId)
                                                                                    ? 'on Trip'
                                                                                    : '',
                                                                        style: TextStyle(fontSize: 16, color: Colors.white));
                                                                  }
                                                                  return CircularProgressIndicator();
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
                                                                  bottomRight:
                                                                      Radius.circular(
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
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: Text(
                                                    data[index].productname,
                                                    style: TextStyle(
                                                        fontSize: _mediaQuery
                                                                .size.height *
                                                            0.02 *
                                                            1.2,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
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
                                                        .doc(data[index].techId)
                                                        .snapshots(),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot.hasData) {
                                                        var data = snapshot
                                                            .data!
                                                            .data();
                                                        Usermodel tech =
                                                            Usermodel.fromMap(
                                                                data!);
                                                        return Padding(
                                                          padding: EdgeInsets.only(
                                                              left: _mediaQuery
                                                                      .size
                                                                      .height *
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
                                                                        tech.image),
                                                              ),
                                                              SizedBox(
                                                                width: _mediaQuery
                                                                        .size
                                                                        .height *
                                                                    0.01,
                                                              ),
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    tech.name,
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            _mediaQuery.size.height *
                                                                                0.02),
                                                                  ),
                                                                  Text(
                                                                    'ID: #${tech.techId}',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                              .grey[
                                                                          600],
                                                                    ),
                                                                  )
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        );
                                                      }
                                                      return CircularProgressIndicator();
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
                                                                  .doc(data[
                                                                          index]
                                                                      .customerId)
                                                                  .snapshots(),
                                                              builder: (context,
                                                                  snapshot) {
                                                                if (snapshot
                                                                    .hasData) {
                                                                  var dataa =
                                                                      snapshot
                                                                          .data!
                                                                          .data();
                                                                  Usermodel
                                                                      cus =
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
                                                                }
                                                                return CircularProgressIndicator();
                                                              }),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        width: _mediaQuery
                                                                .size.height *
                                                            0.08,
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      TaskScreen(
                                                                          home:
                                                                              false,
                                                                          model:
                                                                              data[index])));
                                                        },
                                                        child: Text(
                                                          'View Details',
                                                          style: TextStyle(
                                                              fontSize: _mediaQuery
                                                                      .size
                                                                      .height *
                                                                  0.02,
                                                              color: Colors
                                                                  .blue[600]),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }));
                            }
                            return Text('');
                          })
                    ]))));
  }
}
