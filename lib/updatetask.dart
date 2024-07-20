import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mechanic_app/completetask.dart';
import 'package:mechanic_app/taskmodel.dart';
import 'package:mechanic_app/usermodel.dart';

class UpdateTask extends StatefulWidget {
  UpdateTask({super.key, required this.model});
  Taskmodel model;

  @override
  State<UpdateTask> createState() => _UpdateTaskState();
}

bool ontrip = false;

bool inprocess = false;

bool pending = false;

bool complete = false;

class _UpdateTaskState extends State<UpdateTask> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: media.size.height * 0.07,
        automaticallyImplyLeading: false,
        title: Row(
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
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: media.size.height * 0.1),
              child: Text(
                'Update Task',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: media.size.height * 0.02),
        child: Column(
          children: [
            Container(
              height: media.size.height * .2 * 1.3,
              width: media.size.width * 2,
              decoration: BoxDecoration(color: Colors.grey.shade200),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: media.size.height * 0.01,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: media.size.height * 0.1 * 1.5,
                      ),
                      Text(
                        'Task:${widget.model.task}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade500,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        width: media.size.height * 0.06,
                      ),
                      Container(
                        height: media.size.height * 0.03,
                        width: media.size.height * 0.1,
                        color: Colors.amber,
                        child: Center(
                          child: Text(
                              ontrip
                                  ? 'On Trip'
                                  : inprocess
                                      ? 'In Process'
                                      : complete
                                          ? 'Complete'
                                          : pending
                                              ? 'Pending'
                                              : 'In Process',
                              style: TextStyle(color: Colors.black)),
                        ),
                      )
                    ],
                  ),
                  // Row(
                  //   children: [
                  //     // Container(
                  //     //   height: 25,
                  //     //   width: 15,
                  //     //   decoration: BoxDecoration(
                  //     //       color: const Color.fromARGB(255, 168, 144, 144),
                  //     //       borderRadius: BorderRadius.only(
                  //     //           topRight: Radius.circular(20),
                  //     //           bottomRight: Radius.circular(20))),
                  //     // ),
                  //     // Text(
                  //     //   '- - - - - - - - - - - - - - - - - - - - - -',
                  //     //   style: TextStyle(
                  //     //       fontSize: 25, color: Colors.grey.shade500),
                  //     // ),
                  //     // Spacer(),
                  //     // Container(
                  //     //   height: 25,
                  //     //   width: 15,
                  //     //   decoration: BoxDecoration(
                  //     //       color: Colors.white,
                  //     //       borderRadius: BorderRadius.only(
                  //     //           topLeft: Radius.circular(20),
                  //     //           bottomLeft: Radius.circular(20))),
                  //     // )
                  //   ],
                  // ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      widget.model.productname,
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'time',
                      style: TextStyle(fontSize: 15, color: Colors.red),
                    ),
                  ),
                  SizedBox(
                    height: media.size.height * 0.01,
                  ),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var data = snapshot.data!.data();
                          Usermodel user = Usermodel.fromMap(data!);
                          if (user.process.contains(widget.model.taskId)) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: media.size.height * 0.03,
                                    backgroundImage: NetworkImage(user.image),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          user.name,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize:
                                                  media.size.height * 0.02),
                                        ),
                                        Text(
                                          'ID:${user.techId}',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 194, 193, 193)),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        }
                        return CircularProgressIndicator();
                      }),
                  SizedBox(
                    height: media.size.height * 0.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: InkWell(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => ProductDetail()));
                      },
                      child: Text(
                        'view details',
                        style: TextStyle(
                            color: Colors.blue[600],
                            fontSize: media.size.height * 0.02),
                      ),
                    ),
                  ),
                  // // SizedBox(
                  // //   height: media.size.height * 0.02,
                  // ),
                ],
              ),
            ),
            SizedBox(
              height: media.size.height * 0.02,
            ),
            Container(
              height: media.size.height * .2 * 1.2,
              width: media.size.width * 2,
              decoration: BoxDecoration(color: Colors.grey.shade200),
              child: Column(
                children: [
                  SizedBox(
                    height: media.size.height * 0.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Customer Details',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade500,
                            fontSize: 20),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: media.size.height * 0.02,
                  ),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(widget.model.customerId)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var data = snapshot.data!.data();
                          Usermodel user = Usermodel.fromMap(data!);
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(children: [
                              CircleAvatar(
                                radius: media.size.height * 0.03,
                                backgroundImage: NetworkImage(user.image),
                              ),
                              SizedBox(
                                width: media.size.height * 0.01,
                              ),
                              Text(
                                user.name,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: media.size.height * 0.02),
                              )
                            ]),
                          );
                        }
                        return Text('');
                      }),
                  SizedBox(
                    height: media.size.height * 0.02,
                  ),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(widget.model.customerId)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var data = snapshot.data!.data();
                          Usermodel user = Usermodel.fromMap(data!);
                          return Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.red,
                              ),
                              Text(
                                user.address,
                                style: TextStyle(color: Colors.grey.shade500),
                              ),
                            ],
                          );
                        }
                        return Text('');
                      }),
                ],
              ),
            ),
            SizedBox(
              height: media.size.height * 0.02,
            ),
            Container(
              height: media.size.height * .2 * 1.2,
              width: media.size.width * 2,
              decoration: BoxDecoration(color: Colors.grey.shade200),
              child: Column(
                children: [
                  SizedBox(
                    height: media.size.height * 0.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Customer Note',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade500,
                            fontSize: 20),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.model.note,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: media.size.height * 0.02),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: media.size.height * 0.02,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(),
                  backgroundColor: Colors.blue[600],
                  fixedSize:
                      Size(media.size.height * 0.3, media.size.height * 0.04),
                ),
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(builder:
                            (BuildContext context, StateSetter setState) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: media.size.height * 0.03),
                            height: media.size.height * 0.3 * 1.4,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: media.size.height * 0.03,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Update Task',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize:
                                              media.size.height * 0.02 * 1.2,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Icon(
                                        Icons.cancel_rounded,
                                        color: Colors.black,
                                        size: media.size.height * 0.03 * 1.2,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: media.size.height * 0.02,
                                ),
                                InkWell(
                                  splashColor: Colors.white,
                                  onTap: () {
                                    setState(() {
                                      pending = false;
                                      complete = false;
                                      inprocess = false;
                                      ontrip = !ontrip;
                                    });
                                  },
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'On Trip',
                                          style: TextStyle(
                                              color: ontrip
                                                  ? Colors.blue[600]
                                                  : Colors.black,
                                              fontSize:
                                                  media.size.height * 0.02),
                                        ),
                                        ontrip
                                            ? Icon(
                                                Icons.check,
                                                color: Colors.blue[600],
                                              )
                                            : Text('')
                                      ]),
                                ),
                                SizedBox(
                                  height: media.size.height * 0.02,
                                ),
                                Divider(),
                                SizedBox(
                                  height: media.size.height * 0.02,
                                ),
                                InkWell(
                                  splashColor: Colors.white,
                                  onTap: () {
                                    setState(() {
                                      ontrip = false;
                                      complete = false;
                                      pending = false;
                                      inprocess = !inprocess;
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'In Process',
                                        style: TextStyle(
                                            color: inprocess
                                                ? Colors.blue[600]
                                                : Colors.black,
                                            fontSize: media.size.height * 0.02),
                                      ),
                                      inprocess
                                          ? Icon(
                                              Icons.check,
                                              color: Colors.blue[600],
                                            )
                                          : Text('')
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: media.size.height * 0.02,
                                ),
                                Divider(),
                                SizedBox(
                                  height: media.size.height * 0.02,
                                ),
                                InkWell(
                                  splashColor: Colors.white,
                                  onTap: () {
                                    setState(() {
                                      ontrip = false;
                                      complete = false;
                                      inprocess = false;
                                      pending = !pending;
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Pending',
                                        style: TextStyle(
                                            color: pending
                                                ? Colors.blue[600]
                                                : Colors.black,
                                            fontSize: media.size.height * 0.02),
                                      ),
                                      pending
                                          ? Icon(
                                              Icons.check,
                                              color: Colors.blue[600],
                                            )
                                          : Text('')
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: media.size.height * 0.02,
                                ),
                                Divider(),
                                SizedBox(
                                  height: media.size.height * 0.02,
                                ),
                                InkWell(
                                  splashColor: Colors.white,
                                  onTap: () {
                                    setState(() {
                                      ontrip = false;
                                      inprocess = false;
                                      pending = false;
                                      complete = !complete;
                                    });
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CompleteTaskScreen(
                                                  model: widget.model,
                                                )));
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Complete',
                                        style: TextStyle(
                                            color: complete
                                                ? Colors.blue[600]
                                                : Colors.black,
                                            fontSize: media.size.height * 0.02),
                                      ),
                                      complete
                                          ? Icon(
                                              Icons.check,
                                              color: Colors.blue[600],
                                            )
                                          : Text('')
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: media.size.height * 0.02,
                                ),
                                Divider(),
                              ],
                            ),
                          );
                        });
                      });
                },
                child: Text(
                  'Update Task',
                  style: TextStyle(
                      color: Colors.white, fontSize: media.size.height * 0.02),
                ))
          ],
        ),
      ),
    );
  }
}
