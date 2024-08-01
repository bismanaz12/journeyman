import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mechanic_app/customerprofile.dart';
import 'package:mechanic_app/features.dart';
import 'package:mechanic_app/features2.dart';
import 'package:mechanic_app/homefunctions.dart';
import 'package:mechanic_app/taskmodel.dart';
import 'package:mechanic_app/updatetask.dart';
import 'package:mechanic_app/usermodel.dart';

class TaskScreen extends StatelessWidget {
  TaskScreen({super.key, required this.model, required this.home});
  Taskmodel model;
  bool home;

  @override
  Widget build(BuildContext context) {
    var _mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: _mediaQuery.size.height * 0.04,
                width: _mediaQuery.size.height * 0.04,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Color.fromARGB(255, 19, 18, 18),
                        width: _mediaQuery.size.height * 0.0002),
                    // color: Colors.pink,
                    borderRadius: BorderRadius.all(
                        Radius.circular(_mediaQuery.size.height * 0.03))),
                child: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Colors.blue[900],
                ),
              ),
            ),
            SizedBox(
              width: _mediaQuery.size.height * 0.1 * 1.2,
            ),
            Text(
              'Task Details',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.blue[900],
              ),
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: _mediaQuery.size.height * .3 * 1.3,
                width: _mediaQuery.size.width * 2,
                decoration: BoxDecoration(color: Colors.grey.shade200),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: _mediaQuery.size.height * 0.02,
                    ),
                    Center(
                      child: Text(
                        'TASK #${model.task}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade500,
                            fontSize: 15),
                      ),
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
                      height: _mediaQuery.size.height * 0.02,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        model.productname,
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'time',
                        style: TextStyle(fontSize: 15, color: Colors.red),
                      ),
                    ),
                    SizedBox(
                      height: _mediaQuery.size.height * 0.02,
                    ),
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('tasks')
                            .doc(model.taskId)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            var data = snapshot.data!.data();
                            Taskmodel task = Taskmodel.frommap(data!);
                            return SizedBox(
                              height: _mediaQuery.size.height * 0.1 * 1.7,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: data.length,
                                  itemBuilder: (context, index) {
                                    if (snapshot.hasData) {
                                      return Row(
                                        children: List.generate(
                                          task.photo.length,
                                          (photoIndex) => Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    _mediaQuery.size.height *
                                                        0.01),
                                            child: Product_Image(
                                              mediaQuery: _mediaQuery,
                                              image: task.photo[photoIndex],
                                            ),
                                          ),
                                        ).toList(),
                                      );
                                    }
                                    return Text('');
                                  }),
                            );
                          }
                          return Text('');
                        }),
                    SizedBox(
                      height: _mediaQuery.size.height * 0.03,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductDetail(
                                        model: model,
                                      )));
                        },
                        child: Text(
                          'view details',
                          style: TextStyle(
                              color: Colors.blue[900],
                              fontSize: _mediaQuery.size.height * 0.02),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: _mediaQuery.size.height * 0.03,
              ),
              Container(
                height: _mediaQuery.size.height * .2 * 1.2,
                width: _mediaQuery.size.width * 2,
                decoration: BoxDecoration(color: Colors.grey.shade200),
                child: Column(
                  children: [
                    SizedBox(
                      height: _mediaQuery.size.height * 0.02,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Customer Details',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[900],
                              fontSize: 20),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: _mediaQuery.size.height * 0.02,
                    ),
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .doc(model.customerId)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            var data = snapshot.data!.data();
                            Usermodel user = Usermodel.fromMap(data!);
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CustomerProfile(
                                                  task: user,
                                                )));
                                  },
                                  child: CircleAvatar(
                                    radius: _mediaQuery.size.height * 0.03,
                                    backgroundImage: NetworkImage(user.image),
                                  ),
                                ),
                                SizedBox(
                                  width: _mediaQuery.size.height * 0.01,
                                ),
                                Text(
                                  user.name,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: _mediaQuery.size.height * 0.02),
                                )
                              ]),
                            );
                          }
                          return Text('');
                        }),
                    SizedBox(
                      height: _mediaQuery.size.height * 0.02,
                    ),
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .doc(model.customerId)
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
                        })
                  ],
                ),
              ),
              SizedBox(
                height: _mediaQuery.size.height * 0.03,
              ),
              Container(
                height: _mediaQuery.size.height * .2 * 1.2,
                width: _mediaQuery.size.width * 2,
                decoration: BoxDecoration(color: Colors.grey.shade200),
                child: Column(
                  children: [
                    SizedBox(
                      height: _mediaQuery.size.height * 0.02,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Customer Note',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[900],
                              fontSize: 20),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          model.note,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: _mediaQuery.size.height * 0.02),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: _mediaQuery.size.height * 0.02,
              ),
              home
                  ? Center(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue[900],
                              fixedSize: Size(_mediaQuery.size.height * 0.3,
                                  _mediaQuery.size.height * 0.04),
                              shape: RoundedRectangleBorder()),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    child: Container(
                                      color: Colors.white,
                                      height:
                                          _mediaQuery.size.height * 0.5 * 1.3,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                              height: _mediaQuery.size.height *
                                                  0.03),
                                          Container(
                                            height:
                                                _mediaQuery.size.height * 0.4,
                                            child: Image.asset(
                                              'assets/images/mechanic.png',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          SizedBox(
                                              height: _mediaQuery.size.height *
                                                  0.03),
                                          Text(
                                            'Take this Task?',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize:
                                                    _mediaQuery.size.height *
                                                        0.02 *
                                                        1.2),
                                          ),
                                          SizedBox(
                                            height:
                                                _mediaQuery.size.height * 0.04,
                                          ),
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.blue[900],
                                                  fixedSize: Size(
                                                      _mediaQuery.size.height *
                                                          0.2 *
                                                          1.3,
                                                      _mediaQuery.size.height *
                                                          0.05),
                                                  shape:
                                                      RoundedRectangleBorder()),
                                              onPressed: () async {
                                                await FirebaseFirestore.instance
                                                    .collection('tasks')
                                                    .doc(model.taskId)
                                                    .update({'takeTask': true});
                                                await FirebaseFirestore.instance
                                                    .collection('tasks')
                                                    .doc(model.taskId)
                                                    .update({
                                                  'techId': FirebaseAuth
                                                      .instance.currentUser!.uid
                                                });
                                                await FirebaseFirestore.instance
                                                    .collection('users')
                                                    .doc(FirebaseAuth.instance
                                                        .currentUser!.uid)
                                                    .update({
                                                  'process':
                                                      FieldValue.arrayUnion(
                                                          [model.taskId])
                                                });
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            UpdateTask(
                                                                model: model)));
                                              },
                                              child: Text('Yes! Take this task',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: _mediaQuery
                                                              .size.height *
                                                          0.02))),
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  elevation: 0,
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                          255, 230, 226, 226),
                                                  fixedSize: Size(
                                                      _mediaQuery.size.height *
                                                          0.2 *
                                                          1.3,
                                                      _mediaQuery.size.height *
                                                          0.04),
                                                  shape:
                                                      RoundedRectangleBorder()),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                'Cancle',
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ))
                                        ],
                                      ),
                                    ),
                                  );
                                });

                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => CusomterTask()));
                          },
                          child: Text(
                            'Take Task',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: _mediaQuery.size.height * 0.02),
                          )),
                    )
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[900],
                          fixedSize: Size(_mediaQuery.size.height * 0.3,
                              _mediaQuery.size.height * 0.04),
                          shape: RoundedRectangleBorder()),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) =>
                                    ProductDetail(model: model))));
                      },
                      child: Text(
                        'View Details',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: _mediaQuery.size.height * 0.02),
                      ))
            ],
          ),
        ),
      ),
    );
  }
}
