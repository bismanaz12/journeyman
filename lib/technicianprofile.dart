import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mechanic_app/editprofile.dart';
import 'package:mechanic_app/flowchart.dart';
import 'package:mechanic_app/login.dart';
import 'package:mechanic_app/profilelist.dart';
import 'package:mechanic_app/security.dart';
import 'package:mechanic_app/setting.dart';
import 'package:mechanic_app/taskmodel.dart';
import 'package:mechanic_app/taskscreen.dart';
import 'package:mechanic_app/usermodel.dart';

class TechnicianProfile extends StatefulWidget {
  TechnicianProfile({super.key, this.tech});
  Usermodel? tech;

  @override
  State<TechnicianProfile> createState() => _TechnicianProfileState();
}

class _TechnicianProfileState extends State<TechnicianProfile> {
  bool value1 = true;
  bool all = true;
  bool complete = false;
  bool process = false;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
              width: media.size.height * 0.05,
            ),
            Text(
              widget.tech != null ? 'Technician Details' : 'Profile',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.blue[900],
              ),
            ),
            SizedBox(
              width: media.size.height * 0.05,
            ),
            widget.tech != null
                ? Text('')
                : InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Editprofile()));
                    },
                    child: Container(
                        height: media.size.height * 0.03,
                        width: media.size.height * 0.03,
                        decoration: BoxDecoration(),
                        child: Image.asset(
                          'assets/images/edit.png',
                          fit: BoxFit.cover,
                        )),
                  ),
          ],
        ),
      ),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data!.data();
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '12th',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: media.size.height * 0.01 * 1.8),
                          ),
                          Container(
                            height: media.size.height * 0.03,
                            child: Image.asset(
                              'assets/images/position.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Column(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                    widget.tech != null
                                        ? widget.tech!.image
                                        : data!['image']),
                                radius: media.size.height * 0.03 * 1.8,
                              ),
                              Text(
                                widget.tech != null
                                    ? widget.tech!.name
                                    : data!['name'],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: media.size.height * 0.02,
                                    fontWeight: FontWeight.w500),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'ID:${widget.tech != null ? widget.tech!.techId : data!['techId']} * ',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 202, 195, 195),
                                        fontSize:
                                            media.size.height * 0.01 * 1.6,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    widget.tech != null
                                        ? widget.tech!.bio
                                        : data!['bio'],
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 202, 195, 195),
                                        fontSize:
                                            media.size.height * 0.01 * 1.6,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.amber[700],
                          ),
                          Text(
                            '4.7',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: media.size.height * 0.01 * 1.8),
                          )
                        ],
                      ),
                      SizedBox(
                        height: media.size.height * 0.05,
                      ),
                      widget.tech != null
                          ? Column(
                              children: [
                                Row(
                                  children: [
                                    all
                                        ? Expanded(
                                            child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical:
                                                    media.size.height * 0.01),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        media.size.height *
                                                            0.04),
                                                color: Colors.blue[900]),
                                            child: Center(
                                              child: Text(
                                                'All',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize:
                                                        media.size.height *
                                                            0.02),
                                              ),
                                            ),
                                          ))
                                        : Expanded(
                                            child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                all = true;
                                                process = false;
                                                complete = false;
                                              });
                                            },
                                            child: Container(
                                              child: Center(
                                                child: Text(
                                                  'All',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize:
                                                          media.size.height *
                                                              0.02),
                                                ),
                                              ),
                                            ),
                                          )),
                                    complete
                                        ? Expanded(
                                            child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical:
                                                    media.size.height * 0.01),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        media.size.height *
                                                            0.04),
                                                color: Colors.blue[900]),
                                            child: Center(
                                              child: Text(
                                                'Completed',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize:
                                                        media.size.height *
                                                            0.01 *
                                                            1.7),
                                              ),
                                            ),
                                          ))
                                        : Expanded(
                                            flex: 2,
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  process = false;
                                                  all = false;
                                                  complete = true;
                                                });
                                              },
                                              child: Container(
                                                child: Center(
                                                  child: Text(
                                                    'Completed',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize:
                                                            media.size.height *
                                                                0.01 *
                                                                1.7),
                                                  ),
                                                ),
                                              ),
                                            )),
                                    process
                                        ? Expanded(
                                            child: Container(
                                            padding: EdgeInsets.all(
                                                media.size.height * 0.01),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        media.size.height *
                                                            0.04),
                                                color: Colors.blue[900]),
                                            child: Center(
                                              child: Text(
                                                'Working',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize:
                                                        media.size.height *
                                                            0.01 *
                                                            1.7),
                                              ),
                                            ),
                                          ))
                                        : Expanded(
                                            child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                process = true;
                                                all = false;
                                                complete = false;
                                              });
                                            },
                                            child: Container(
                                              child: Center(
                                                child: Text(
                                                  'Working',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize:
                                                          media.size.height *
                                                              0.01 *
                                                              1.7),
                                                ),
                                              ),
                                            ),
                                          ))
                                  ],
                                ),
                                all
                                    ? StreamBuilder(
                                        stream: FirebaseFirestore.instance
                                            .collection('tasks')
                                            .where('techId',
                                                isEqualTo: widget.tech!.id)
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            var data = snapshot.data!.docs
                                                .map((e) =>
                                                    Taskmodel.frommap(e.data()))
                                                .toList();

                                            return ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: data.length,
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            16.0),
                                                    child: Container(
                                                      height:
                                                          media.size.height *
                                                              .2 *
                                                              1.5,
                                                      width:
                                                          media.size.width * 2,
                                                      decoration: BoxDecoration(
                                                          color: Colors
                                                              .grey.shade200),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(16.0),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                Text(
                                                                  'Task: #${data[index].task}',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .grey
                                                                          .shade500,
                                                                      fontSize:
                                                                          15),
                                                                ),
                                                                Container(
                                                                  height: 25,
                                                                  width: 50,
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .grey
                                                                          .shade300,
                                                                      border: Border.all(
                                                                          color: Colors
                                                                              .grey
                                                                              .shade500)),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceEvenly,
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .watch_later,
                                                                        size:
                                                                            18,
                                                                      ),
                                                                      Text('3h')
                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 33,
                                                                  width: media
                                                                          .size
                                                                          .height *
                                                                      0.1 *
                                                                      1.2,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                            .blue[
                                                                        600],
                                                                  ),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceEvenly,
                                                                    children: [
                                                                      Text(
                                                                          widget.tech!.process.contains(data[index].taskId)
                                                                              ? 'In Process'
                                                                              : widget.tech!.pending.contains(data[index].taskId)
                                                                                  ? 'Pending'
                                                                                  : widget.tech!.ontrip.contains(data[index].taskId)
                                                                                      ? 'On Trip'
                                                                                      : widget.tech!.completion.contains(data[index].taskId)
                                                                                          ? 'Complete'
                                                                                          : '',
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
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius: BorderRadius.only(
                                                                        topRight:
                                                                            Radius.circular(
                                                                                20),
                                                                        bottomRight:
                                                                            Radius.circular(20))),
                                                              ),
                                                              Text(
                                                                '- - - - - - - - - - - - - - - - - - - - - - - - - ',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        25,
                                                                    color: Colors
                                                                        .grey
                                                                        .shade500),
                                                              ),
                                                              Spacer(),
                                                              Container(
                                                                height: 25,
                                                                width: 15,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius: BorderRadius.only(
                                                                        topLeft:
                                                                            Radius.circular(
                                                                                20),
                                                                        bottomLeft:
                                                                            Radius.circular(20))),
                                                              )
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 15),
                                                            child: Text(
                                                              data[index]
                                                                  .productname,
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 20,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 20),
                                                            child:
                                                                StreamBuilder(
                                                                    stream: FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'users')
                                                                        .doc(data[index]
                                                                            .customerId)
                                                                        .snapshots(),
                                                                    builder:
                                                                        (context,
                                                                            snapshot) {
                                                                      if (snapshot
                                                                          .hasData) {
                                                                        var data = snapshot
                                                                            .data!
                                                                            .data();
                                                                        Usermodel
                                                                            user =
                                                                            Usermodel.fromMap(data!);
                                                                        return Row(
                                                                          children: [
                                                                            CircleAvatar(
                                                                              radius: 25,
                                                                              backgroundImage: NetworkImage(user.image),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Column(
                                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Text(
                                                                                    user.name,
                                                                                    style: TextStyle(fontSize: 16),
                                                                                  ),
                                                                                  Text(
                                                                                    user.address,
                                                                                    style: TextStyle(color: Colors.grey.shade500, fontSize: 16),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            )
                                                                          ],
                                                                        );
                                                                      }
                                                                      return Text(
                                                                          '');
                                                                    }),
                                                          ),
                                                          SizedBox(
                                                            height: media.size
                                                                    .height *
                                                                0.01,
                                                          ),
                                                          Align(
                                                            alignment: Alignment
                                                                .centerRight,
                                                            child: InkWell(
                                                              onTap: () {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) => TaskScreen(
                                                                            model:
                                                                                data[index],
                                                                            home: false)));
                                                              },
                                                              child: Text(
                                                                'View Details    ',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .blue,
                                                                    fontSize: media
                                                                            .size
                                                                            .height *
                                                                        0.02),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                });
                                          }
                                          return Text('No Task Here');
                                        })
                                    : complete
                                        ? StreamBuilder(
                                            stream: FirebaseFirestore.instance
                                                .collection('tasks')
                                                .where('techId',
                                                    isEqualTo: widget.tech!.id)
                                                .snapshots(),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                var data = snapshot.data!.docs
                                                    .map((e) =>
                                                        Taskmodel.frommap(
                                                            e.data()))
                                                    .toList();

                                                return ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount: data.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      if (widget
                                                          .tech!.completion
                                                          .contains(data[index]
                                                              .taskId)) {
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(16.0),
                                                          child: Container(
                                                            height: media.size
                                                                    .height *
                                                                .2 *
                                                                1.5,
                                                            width: media.size
                                                                    .width *
                                                                2,
                                                            decoration:
                                                                BoxDecoration(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade200),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
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
                                                                                FontWeight.bold,
                                                                            color: Colors.grey.shade500,
                                                                            fontSize: 15),
                                                                      ),
                                                                      Container(
                                                                        height:
                                                                            25,
                                                                        width:
                                                                            50,
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                Colors.grey.shade300,
                                                                            border: Border.all(color: Colors.grey.shade500)),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceEvenly,
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
                                                                        height:
                                                                            33,
                                                                        width: media.size.height *
                                                                            0.1 *
                                                                            1.2,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Colors.blue[600],
                                                                        ),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceEvenly,
                                                                          children: [
                                                                            Text('Complete',
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
                                                                      height:
                                                                          25,
                                                                      width: 15,
                                                                      decoration: BoxDecoration(
                                                                          color: Colors
                                                                              .white,
                                                                          borderRadius: BorderRadius.only(
                                                                              topRight: Radius.circular(20),
                                                                              bottomRight: Radius.circular(20))),
                                                                    ),
                                                                    Text(
                                                                      '- - - - - - - - - - - - - - - - - - - - - - - - - ',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              25,
                                                                          color: Colors
                                                                              .grey
                                                                              .shade500),
                                                                    ),
                                                                    Spacer(),
                                                                    Container(
                                                                      height:
                                                                          25,
                                                                      width: 15,
                                                                      decoration: BoxDecoration(
                                                                          color: Colors
                                                                              .white,
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
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              15),
                                                                  child: Text(
                                                                    data[index]
                                                                        .productname,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            20,
                                                                        color: Colors
                                                                            .black),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 20,
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              20),
                                                                  child:
                                                                      StreamBuilder(
                                                                          stream: FirebaseFirestore
                                                                              .instance
                                                                              .collection('users')
                                                                              .doc(data[index].customerId)
                                                                              .snapshots(),
                                                                          builder: (context, snapshot) {
                                                                            if (snapshot.hasData) {
                                                                              var data = snapshot.data!.data();
                                                                              Usermodel user = Usermodel.fromMap(data!);
                                                                              return Row(
                                                                                children: [
                                                                                  CircleAvatar(
                                                                                    radius: 25,
                                                                                    backgroundImage: NetworkImage(user.image),
                                                                                  ),
                                                                                  Padding(
                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                    child: Column(
                                                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        Text(
                                                                                          user.name,
                                                                                          style: TextStyle(fontSize: 16),
                                                                                        ),
                                                                                        Text(
                                                                                          user.address,
                                                                                          style: TextStyle(color: Colors.grey.shade500, fontSize: 16),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              );
                                                                            }
                                                                            return Text('');
                                                                          }),
                                                                ),
                                                                SizedBox(
                                                                  height: media
                                                                          .size
                                                                          .height *
                                                                      0.01,
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerRight,
                                                                  child:
                                                                      InkWell(
                                                                    onTap: () {
                                                                      Navigator.push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                              builder: (context) => TaskScreen(model: data[index], home: false)));
                                                                    },
                                                                    child: Text(
                                                                      'View Details    ',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .blue,
                                                                          fontSize:
                                                                              media.size.height * 0.02),
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                    });
                                              }
                                              return Text('No Task Here');
                                            })
                                        : process
                                            ? StreamBuilder(
                                                stream: FirebaseFirestore
                                                    .instance
                                                    .collection('tasks')
                                                    .where('techId',
                                                        isEqualTo:
                                                            widget.tech!.id)
                                                    .snapshots(),
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    var data = snapshot
                                                        .data!.docs
                                                        .map((e) =>
                                                            Taskmodel.frommap(
                                                                e.data()))
                                                        .toList();

                                                    return ListView.builder(
                                                        shrinkWrap: true,
                                                        itemCount: data.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          if (!widget
                                                              .tech!.completion
                                                              .contains(data[
                                                                      index]
                                                                  .taskId)) {
                                                            return Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(
                                                                      16.0),
                                                              child: Container(
                                                                height: media
                                                                        .size
                                                                        .height *
                                                                    .2 *
                                                                    1.5,
                                                                width: media
                                                                        .size
                                                                        .width *
                                                                    2,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade200),
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          16.0),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceEvenly,
                                                                        children: [
                                                                          Text(
                                                                            'Task: #${data[index].task}',
                                                                            style: TextStyle(
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.grey.shade500,
                                                                                fontSize: 15),
                                                                          ),
                                                                          Container(
                                                                            height:
                                                                                25,
                                                                            width:
                                                                                50,
                                                                            decoration:
                                                                                BoxDecoration(color: Colors.grey.shade300, border: Border.all(color: Colors.grey.shade500)),
                                                                            child:
                                                                                Row(
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
                                                                            height:
                                                                                33,
                                                                            width: media.size.height *
                                                                                0.1 *
                                                                                1.2,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Colors.blue[600],
                                                                            ),
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                              children: [
                                                                                Text(
                                                                                    widget.tech!.process.contains(data[index].taskId)
                                                                                        ? 'In Process'
                                                                                        : widget.tech!.pending.contains(data[index].taskId)
                                                                                            ? 'Pending'
                                                                                            : widget.tech!.ontrip.contains(data[index].taskId)
                                                                                                ? 'On Trip'
                                                                                                : '',
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
                                                                          height:
                                                                              25,
                                                                          width:
                                                                              15,
                                                                          decoration: BoxDecoration(
                                                                              color: Colors.white,
                                                                              borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20))),
                                                                        ),
                                                                        Text(
                                                                          '- - - - - - - - - - - - - - - - - - - - - - - - - ',
                                                                          style: TextStyle(
                                                                              fontSize: 25,
                                                                              color: Colors.grey.shade500),
                                                                        ),
                                                                        Spacer(),
                                                                        Container(
                                                                          height:
                                                                              25,
                                                                          width:
                                                                              15,
                                                                          decoration: BoxDecoration(
                                                                              color: Colors.white,
                                                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20))),
                                                                        )
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              15),
                                                                      child:
                                                                          Text(
                                                                        data[index]
                                                                            .productname,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                20,
                                                                            color:
                                                                                Colors.black),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          20,
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              20),
                                                                      child: StreamBuilder(
                                                                          stream: FirebaseFirestore.instance.collection('users').doc(data[index].customerId).snapshots(),
                                                                          builder: (context, snapshot) {
                                                                            if (snapshot.hasData) {
                                                                              var data = snapshot.data!.data();
                                                                              Usermodel user = Usermodel.fromMap(data!);
                                                                              return Row(
                                                                                children: [
                                                                                  CircleAvatar(
                                                                                    radius: 25,
                                                                                    backgroundImage: NetworkImage(user.image),
                                                                                  ),
                                                                                  Padding(
                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                    child: Column(
                                                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        Text(
                                                                                          user.name,
                                                                                          style: TextStyle(fontSize: 16),
                                                                                        ),
                                                                                        Text(
                                                                                          user.address,
                                                                                          style: TextStyle(color: Colors.grey.shade500, fontSize: 16),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              );
                                                                            }
                                                                            return Text('');
                                                                          }),
                                                                    ),
                                                                    SizedBox(
                                                                      height: media
                                                                              .size
                                                                              .height *
                                                                          0.01,
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerRight,
                                                                      child:
                                                                          InkWell(
                                                                        onTap:
                                                                            () {
                                                                          Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(builder: (context) => TaskScreen(model: data[index], home: false)));
                                                                        },
                                                                        child:
                                                                            Text(
                                                                          'View Details    ',
                                                                          style: TextStyle(
                                                                              color: Colors.blue,
                                                                              fontSize: media.size.height * 0.02),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                        });
                                                  }
                                                  return Text('No Task Here');
                                                })
                                            : Text('No Task Here'),
                              ],
                            )
                          : Container(
                              child: Column(
                              children: [
                                BarChartSample8(),
                                SizedBox(
                                  height: media.size.height * 0.01,
                                ),
                                ProfileList(
                                    icon: Icons.account_balance_wallet_outlined,
                                    text: 'Number of Tasks',
                                    text2: '0',
                                    icon2: Icons.arrow_forward_ios_outlined),
                                ProfileList(
                                    icon: Icons.leaderboard,
                                    text: 'Leadership',
                                    text2: '0',
                                    icon2: Icons.arrow_forward_ios_outlined),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Setting_Screen()));
                                  },
                                  child: ProfileList(
                                      icon: Icons.settings,
                                      text: 'Settings',
                                      text2: '',
                                      icon2: Icons.arrow_forward_ios_outlined),
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: media.size.height * 0.02),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.compare_outlined,
                                            color: Colors.black,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: media.size.height * 0.02),
                                            child: Expanded(
                                              child: Container(
                                                width: media.size.height *
                                                    0.1 *
                                                    1.5,
                                                child: Text(
                                                  'Dark mode',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize:
                                                          media.size.height *
                                                              0.02,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: media.size.height * 0.04),
                                            child: Expanded(
                                              child: Container(
                                                width: media.size.height * 0.07,
                                                child: Text(
                                                  '',
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 211, 205, 205),
                                                      fontSize:
                                                          media.size.height *
                                                              0.02),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: media.size.height * 0.03),
                                            child: Switch(
                                                activeTrackColor:
                                                    Color.fromARGB(
                                                        255, 211, 205, 205),
                                                inactiveTrackColor:
                                                    Color.fromARGB(
                                                        255, 211, 205, 205),
                                                value: value1,
                                                onChanged: (value) {
                                                  value1 = value;
                                                  setState(() {});
                                                }),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: media.size.height * 0.02),
                                      child: Divider(
                                        color:
                                            Color.fromARGB(255, 211, 205, 205),
                                        thickness: media.size.height * 0.002,
                                      ),
                                    )
                                  ],
                                ),

                                // ProfileList(
                                //     icon: Icons.compare_outlined,
                                //     text: 'Dark Mode',
                                //     text2: '',
                                //     icon2: Icons.switch_access_shortcut),

                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PrivacyScreen()));
                                  },
                                  child: ProfileList(
                                      icon: Icons.verified_outlined,
                                      text: 'Security and Privicy',
                                      text2: '',
                                      icon2: Icons.arrow_forward_ios_outlined),
                                ),
                                ProfileList(
                                    icon: Icons.account_circle,
                                    text: 'About',
                                    text2: '',
                                    icon2: Icons.arrow_forward_ios_outlined),
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Dialog(
                                            child: Container(
                                              height: media.size.height * 0.2,
                                              width: media.size.height * 0.1,
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: media.size.height *
                                                        0.02,
                                                  ),
                                                  Text(
                                                    'Are you sure to logout! ',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize:
                                                            media.size.height *
                                                                0.02 *
                                                                1.2),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: media.size.height *
                                                            0.03),
                                                    child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                fixedSize: Size(
                                                                    media.size
                                                                            .height *
                                                                        0.2,
                                                                    media.size
                                                                            .height *
                                                                        0.03),
                                                                // backgroundColor: Color(
                                                                //   0xff6982ed,
                                                                // ),
                                                                shape: RoundedRectangleBorder(
                                                                    // borderRadius: BorderRadius.all(
                                                                    //     Radius.circular(
                                                                    //         media.size.height * 0.03)),
                                                                    side: BorderSide(
                                                                  width: media
                                                                          .size
                                                                          .height *
                                                                      0.001,
                                                                  color: Color(
                                                                    0xff6982ed,
                                                                  ),
                                                                ))),
                                                        onPressed: () async {
                                                          FirebaseAuth auth =
                                                              FirebaseAuth
                                                                  .instance;
                                                          await auth.signOut();
                                                          Navigator.pop(
                                                              context);
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          Login_Screen_2()));
                                                        },
                                                        child: Text(
                                                          'Yah',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black),
                                                        )),
                                                  ),
                                                  ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              fixedSize: Size(
                                                                  media.size
                                                                          .height *
                                                                      0.2,
                                                                  media.size
                                                                          .height *
                                                                      0.03),
                                                              // backgroundColor: Color(
                                                              //   0xff6982ed,
                                                              // ),
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                side:
                                                                    BorderSide(
                                                                  width: media
                                                                          .size
                                                                          .height *
                                                                      0.001,
                                                                  color: Color(
                                                                    0xff6982ed,
                                                                  ),
                                                                ),
                                                                // borderRadius: BorderRadius.all(
                                                                //     Radius.circular(
                                                                //         media.size.height *
                                                                //             0.03))
                                                              )),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text(
                                                        'No',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      )),
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  child: ProfileList(
                                      icon: Icons.logout_outlined,
                                      text: 'Logout',
                                      text2: '',
                                      icon2: Icons.arrow_forward_ios_outlined),
                                ),
                              ],
                            )),
                    ],
                  );
                }
                return Text('');
              }),
        ),
      ),
    );
  }
}
