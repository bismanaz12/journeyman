import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mechanic_app/chatscreen.dart';
import 'package:mechanic_app/features2.dart';
import 'package:mechanic_app/searchscreen.dart';
import 'package:mechanic_app/taskmodel.dart';
import 'package:mechanic_app/taskscreen.dart';
import 'package:mechanic_app/tasksdetail.dart';
import 'package:mechanic_app/usermodel.dart';

class CustomerProfile extends StatelessWidget {
  CustomerProfile({super.key, this.user, this.task});
  Usermodel? user;
  Usermodel? task;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context);
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Color.fromARGB(255, 235, 234, 234),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: media.size.height * 0.02),
                color: Colors.white,
                height: media.size.height * 0.3 * 1.2,
                child: Column(
                  children: [
                    SizedBox(
                      height: media.size.height * 0.05,
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: media.size.height * 0.04,
                            width: media.size.height * 0.04,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color.fromARGB(255, 19, 18, 18),
                                    width: media.size.height * 0.0002),
                                // color: Colors.pink,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(media.size.height * 0.03))),
                            child: Icon(
                              Icons.arrow_back_ios_new_outlined,
                              color: Colors.blue[900],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: media.size.height * 0.1,
                        ),
                        StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var data = snapshot.data!.data();
                                return Text(
                                  data!['persontype'] == 'customer'
                                      ? ''
                                      : 'Customer Details',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: media.size.height * 0.02),
                                );
                              }
                              return Text('');
                            }),
                      ],
                    ),
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            var data = snapshot.data!.data();
                            return CircleAvatar(
                              radius: media.size.height * 0.05,
                              backgroundImage: NetworkImage(
                                  task != null ? task!.image : data!['image']),
                            );
                          }
                          return Text('');
                        }),
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            var data = snapshot.data!.data();
                            return Text(
                              task != null ? task!.name : data!['name'],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: media.size.height * 0.02),
                            );
                          }
                          return Text('');
                        }),
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            var data = snapshot.data!.data();
                            return Expanded(
                              child: Container(
                                width: media.size.height * 0.2 * 1.3,
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Text(
                                    task != null
                                        ? task!.address
                                        : data!['address'],
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 202, 195, 195),
                                        fontSize: media.size.height * 0.02),
                                  ),
                                ),
                              ),
                            );
                          }
                          return Text('');
                        }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            style: IconButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: CircleBorder(
                                  side: BorderSide(
                                      color: Colors.green,
                                      width: media.size.height * 0.002),
                                )),
                            onPressed: () {},
                            icon: Icon(
                              Icons.call,
                              color: Colors.green,
                            )),
                        IconButton(
                            style: IconButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: CircleBorder(
                                  side: BorderSide(
                                      color: Colors.blue,
                                      width: media.size.height * 0.002),
                                )),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChatScreen(
                                            user: task != null ? task : user,
                                          )));
                            },
                            icon: Icon(
                              Icons.messenger,
                              color: Colors.blue,
                            )),
                        IconButton(
                            style: IconButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: CircleBorder(
                                  side: BorderSide(
                                      color: Colors.pink,
                                      width: media.size.height * 0.002),
                                )),
                            onPressed: () {},
                            icon: Icon(
                              Icons.video_call,
                              color: Colors.pink,
                            ))
                      ],
                    ),
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            var data = snapshot.data!.data();
                            return Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                data!['persontype'] == 'customer'
                                    ? 'adjust direction'
                                    : 'direction',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 202, 195, 195),
                                    fontSize: media.size.height * 0.02),
                              ),
                            );
                          }
                          return Text('');
                        })
                  ],
                ),
              ),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: media.size.height * 0.02),
                child: Column(
                  children: [
                    task != null
                        ? StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('tasks')
                                .where('customerId', isEqualTo: task!.id)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var dat = snapshot.data!.docs
                                    .map((e) => Taskmodel.frommap(e.data()))
                                    .toList();
                                return ListView.builder(
                                    itemCount: snapshot.data!.docs.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                            bottom: media.size.height * 0.02),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  media.size.height * 0.01),
                                          height: media.size.height * 0.3,
                                          color: Colors.white,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height:
                                                    media.size.height * 0.02,
                                              ),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    height: media.size.height *
                                                        0.02,
                                                  ),
                                                  Text(
                                                    'Task #${dat[index].task}',
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 202, 195, 195),
                                                        fontSize:
                                                            media.size.height *
                                                                0.02,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  SizedBox(
                                                    width: media.size.height *
                                                        0.03,
                                                  ),
                                                  ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                          fixedSize: Size(
                                                              media.size
                                                                      .height *
                                                                  0.1,
                                                              media.size
                                                                      .height *
                                                                  0.03),
                                                          shape:
                                                              RoundedRectangleBorder()),
                                                      onPressed: () {},
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons.alarm_sharp,
                                                            color: Colors.black,
                                                          ),
                                                          Text(
                                                            '3h',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black),
                                                          )
                                                        ],
                                                      )),
                                                  // SizedBox(
                                                  //   width: media.size.height * 0.01,
                                                  // ),
                                                  dat[index].techId.isNotEmpty
                                                      ? StreamBuilder(
                                                          stream:
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'users')
                                                                  .doc(dat[index]
                                                                      .techId)
                                                                  .snapshots(),
                                                          builder:
                                                              (context,
                                                                  snapshot) {
                                                            if (snapshot
                                                                .hasData) {
                                                              var tec = snapshot
                                                                  .data!
                                                                  .data();
                                                              Usermodel user =
                                                                  Usermodel
                                                                      .fromMap(
                                                                          tec!);

                                                              return ElevatedButton(
                                                                  style: ElevatedButton.styleFrom(
                                                                      backgroundColor:
                                                                          Colors.amber[
                                                                              400],
                                                                      fixedSize: Size(
                                                                          media.size.height *
                                                                              0.1 *
                                                                              1.5,
                                                                          media.size.height *
                                                                              0.04),
                                                                      shape:
                                                                          RoundedRectangleBorder()),
                                                                  onPressed:
                                                                      () {},
                                                                  child: Text(
                                                                    user.process
                                                                            .contains(dat[index].taskId)
                                                                        ? 'In Process'
                                                                        : user.pending.contains(dat[index].taskId)
                                                                            ? 'Pending'
                                                                            : user.completion.contains(dat[index].taskId)
                                                                                ? 'Complete'
                                                                                : user.ontrip.contains(dat[index].taskId)
                                                                                    ? 'On Trip'
                                                                                    : '',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .red,
                                                                        fontSize: media.size.height *
                                                                            0.01 *
                                                                            1.7),
                                                                  ));
                                                            }
                                                            return Text('');
                                                          })
                                                      : ElevatedButton(
                                                          style: ElevatedButton.styleFrom(
                                                              backgroundColor:
                                                                  Colors.blue[
                                                                      900],
                                                              fixedSize: Size(
                                                                  media.size
                                                                          .height *
                                                                      0.1 *
                                                                      1.5,
                                                                  media.size
                                                                          .height *
                                                                      0.04),
                                                              shape:
                                                                  RoundedRectangleBorder()),
                                                          onPressed: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) => TaskScreen(
                                                                        model: dat[
                                                                            index],
                                                                        home: task!.persontype ==
                                                                                'technician'
                                                                            ? false
                                                                            : true)));
                                                          },
                                                          child: Text(
                                                            'Open',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ))
                                                ],
                                              ),
                                              dat[index].techId.isNotEmpty
                                                  ? StreamBuilder(
                                                      stream: FirebaseFirestore
                                                          .instance
                                                          .collection('users')
                                                          .doc(
                                                              dat[index].techId)
                                                          .snapshots(),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot.hasData) {
                                                          var tech = snapshot
                                                              .data!
                                                              .data();
                                                          Usermodel user =
                                                              Usermodel.fromMap(
                                                                  tech!);

                                                          return Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              SizedBox(
                                                                height: media
                                                                        .size
                                                                        .height *
                                                                    0.01,
                                                              ),
                                                              Text(
                                                                dat[index]
                                                                    .productname,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize: media
                                                                            .size
                                                                            .height *
                                                                        0.02 *
                                                                        1.4),
                                                              ),
                                                              Text(
                                                                '16 hours left',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                            .blue[
                                                                        900],
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                              SizedBox(
                                                                height: media
                                                                        .size
                                                                        .height *
                                                                    0.03,
                                                              ),
                                                              Text(
                                                                'Technician Details',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                            .grey[
                                                                        700],
                                                                    fontSize: media
                                                                            .size
                                                                            .height *
                                                                        0.02,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                              SizedBox(
                                                                height: media
                                                                        .size
                                                                        .height *
                                                                    0.01,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  CircleAvatar(
                                                                    radius: media
                                                                            .size
                                                                            .height *
                                                                        0.03,
                                                                    backgroundImage:
                                                                        NetworkImage(
                                                                            user.image),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                        left: media.size.height *
                                                                            0.01),
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          user.name,
                                                                          style: TextStyle(
                                                                              color: Colors.black,
                                                                              fontSize: media.size.height * 0.02),
                                                                        ),
                                                                        Text(
                                                                          'ID: #${user.techId}',
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.grey[700],
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              Align(
                                                                alignment: Alignment
                                                                    .centerRight,
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (context) => ProductDetail(
                                                                                  model: dat[index],
                                                                                )));
                                                                  },
                                                                  child: Text(
                                                                    'View Details',
                                                                    style: TextStyle(
                                                                        color: Colors.blue[
                                                                            900],
                                                                        fontSize: media.size.height *
                                                                            0.01 *
                                                                            1.7),
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          );
                                                        }
                                                        return Text('');
                                                      })
                                                  : Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          height: media
                                                                  .size.height *
                                                              0.02,
                                                        ),
                                                        Text(
                                                          dat[index]
                                                              .productname,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: media
                                                                      .size
                                                                      .height *
                                                                  0.02 *
                                                                  1.4),
                                                        ),
                                                        SizedBox(
                                                          height: media
                                                                  .size.height *
                                                              0.01,
                                                        ),
                                                        Text(
                                                          '16 hours left',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .blue[900],
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        SizedBox(
                                                          height: media
                                                                  .size.height *
                                                              0.04,
                                                        ),
                                                        Text(
                                                          'Not Assigned!',
                                                          style: TextStyle(
                                                              color: Colors.red,
                                                              fontSize: media
                                                                      .size
                                                                      .height *
                                                                  0.02 *
                                                                  1.1,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        )
                                                      ],
                                                    )
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              }
                              return Text('');
                            })
                        : StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('tasks')
                                .where('customerId',
                                    isEqualTo:
                                        FirebaseAuth.instance.currentUser!.uid)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var data = snapshot.data!.docs
                                    .map((e) => Taskmodel.frommap(e.data()))
                                    .toList();
                                return ListView.builder(
                                    itemCount: snapshot.data!.docs.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                            bottom: media.size.height * 0.02),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  media.size.height * 0.01),
                                          height: media.size.height * 0.3,
                                          color: Colors.white,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height:
                                                    media.size.height * 0.02,
                                              ),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    height: media.size.height *
                                                        0.02,
                                                  ),
                                                  Text(
                                                    'Task #${data[index].task}',
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 202, 195, 195),
                                                        fontSize:
                                                            media.size.height *
                                                                0.02,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  SizedBox(
                                                    width: media.size.height *
                                                        0.03,
                                                  ),
                                                  ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                          fixedSize: Size(
                                                              media.size
                                                                      .height *
                                                                  0.1,
                                                              media.size
                                                                      .height *
                                                                  0.03),
                                                          shape:
                                                              RoundedRectangleBorder()),
                                                      onPressed: () {},
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons.alarm_sharp,
                                                            color: Colors.black,
                                                          ),
                                                          Text(
                                                            '3h',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black),
                                                          )
                                                        ],
                                                      )),
                                                  // SizedBox(
                                                  //   width: media.size.height * 0.01,
                                                  // ),
                                                  data[index].techId.isNotEmpty
                                                      ? StreamBuilder(
                                                          stream: FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'users')
                                                              .doc(data[index]
                                                                  .techId)
                                                              .snapshots(),
                                                          builder: (context,
                                                              snapshot) {
                                                            if (snapshot
                                                                .hasData) {
                                                              var tec = snapshot
                                                                  .data!
                                                                  .data();
                                                              Usermodel user =
                                                                  Usermodel
                                                                      .fromMap(
                                                                          tec!);

                                                              return ElevatedButton(
                                                                  style: ElevatedButton.styleFrom(
                                                                      backgroundColor:
                                                                          Colors.amber[
                                                                              400],
                                                                      fixedSize: Size(
                                                                          media.size.height *
                                                                              0.1 *
                                                                              1.5,
                                                                          media.size.height *
                                                                              0.04),
                                                                      shape:
                                                                          RoundedRectangleBorder()),
                                                                  onPressed:
                                                                      () {},
                                                                  child: Text(
                                                                    user.process
                                                                            .contains(data[index].taskId)
                                                                        ? 'In Process'
                                                                        : user.pending.contains(data[index].taskId)
                                                                            ? 'Pending'
                                                                            : user.completion.contains(data[index].taskId)
                                                                                ? 'Complete'
                                                                                : user.ontrip.contains(data[index].taskId)
                                                                                    ? 'On Trip'
                                                                                    : '',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .red,
                                                                        fontSize: media.size.height *
                                                                            0.01 *
                                                                            1.7),
                                                                  ));
                                                            }
                                                            return Text('');
                                                          })
                                                      : ElevatedButton(
                                                          style: ElevatedButton.styleFrom(
                                                              backgroundColor:
                                                                  Colors.blue[
                                                                      900],
                                                              fixedSize: Size(
                                                                  media.size
                                                                          .height *
                                                                      0.1 *
                                                                      1.5,
                                                                  media.size
                                                                          .height *
                                                                      0.04),
                                                              shape:
                                                                  RoundedRectangleBorder()),
                                                          onPressed: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) => TaskScreen(
                                                                        model: data[
                                                                            index],
                                                                        home: user!.persontype ==
                                                                                'technician'
                                                                            ? false
                                                                            : true)));
                                                          },
                                                          child: Text(
                                                            'Open',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ))
                                                ],
                                              ),
                                              data[index].techId.isNotEmpty
                                                  ? StreamBuilder(
                                                      stream: FirebaseFirestore
                                                          .instance
                                                          .collection('users')
                                                          .doc(data[index]
                                                              .techId)
                                                          .snapshots(),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot.hasData) {
                                                          var tech = snapshot
                                                              .data!
                                                              .data();
                                                          Usermodel user =
                                                              Usermodel.fromMap(
                                                                  tech!);

                                                          return Column(
                                                            children: [
                                                              Text(
                                                                data[index]
                                                                    .productname,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize: media
                                                                            .size
                                                                            .height *
                                                                        0.02 *
                                                                        1.4),
                                                              ),
                                                              Text(
                                                                '16 hours left',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                            .blue[
                                                                        900],
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                              Text(
                                                                'Technician Details',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                            .grey[
                                                                        700],
                                                                    fontSize: media
                                                                            .size
                                                                            .height *
                                                                        0.02,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                              Row(
                                                                children: [
                                                                  CircleAvatar(
                                                                    backgroundImage:
                                                                        NetworkImage(
                                                                            user.image),
                                                                  ),
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        user.name,
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize: media.size.height * 0.02),
                                                                      ),
                                                                      Text(
                                                                        user.techId,
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.grey[700],
                                                                        ),
                                                                      )
                                                                    ],
                                                                  )
                                                                ],
                                                              )
                                                            ],
                                                          );
                                                        }
                                                        return Text('');
                                                      })
                                                  : Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          height: media
                                                                  .size.height *
                                                              0.02,
                                                        ),
                                                        Text(
                                                          data[index]
                                                              .productname,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: media
                                                                      .size
                                                                      .height *
                                                                  0.02 *
                                                                  1.4),
                                                        ),
                                                        SizedBox(
                                                          height: media
                                                                  .size.height *
                                                              0.01,
                                                        ),
                                                        Text(
                                                          '16 hours left',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .blue[900],
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        SizedBox(
                                                          height: media
                                                                  .size.height *
                                                              0.04,
                                                        ),
                                                        Text(
                                                          'Not Assigned!',
                                                          style: TextStyle(
                                                              color: Colors.red,
                                                              fontSize: media
                                                                      .size
                                                                      .height *
                                                                  0.02 *
                                                                  1.1,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        )
                                                      ],
                                                    )
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              }
                              return Text('');
                            })
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
