import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mechanic_app/customertask.dart';
import 'package:mechanic_app/notescreen.dart';
import 'package:mechanic_app/taskmodel.dart';

class CompleteTaskScreen extends StatelessWidget {
  CompleteTaskScreen({super.key, required this.model});
  Taskmodel model;

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
                'Complete Task',
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
          child: Column(
        children: [
          SizedBox(
            height: media.size.height * 0.02,
          ),
          Text(
            'Task',
            style: TextStyle(color: Colors.grey),
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: Card(
              elevation: 3,
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: media.size.height * 0.03),
                color: Colors.grey.shade200,
                height: media.size.height * 0.2,
                child: Column(
                  children: [
                    SizedBox(
                      height: media.size.height * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Task Completion',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: media.size.height * 0.02,
                              fontWeight: FontWeight.w600),
                        ),
                        Icon(Icons.check, color: Colors.green),
                      ],
                    ),
                    SizedBox(
                      height: media.size.height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Customer Approval',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: media.size.height * 0.02,
                              fontWeight: FontWeight.w600),
                        ),
                        Icon(Icons.check, color: Colors.green),
                      ],
                    ),
                    SizedBox(
                      height: media.size.height * 0.01,
                    ),
                    Divider(),
                    SizedBox(
                      height: media.size.height * 0.02,
                    ),
                    Row(
                      children: [
                        Text(
                          'Work Rating',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: media.size.height * 0.02,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          width: media.size.height * 0.1,
                        ),
                        Icon(Icons.star, color: Colors.amber),
                        Icon(Icons.star, color: Colors.amber),
                        Icon(Icons.star, color: Colors.amber),
                        Icon(Icons.star, color: Colors.amber),
                        Icon(Icons.star, color: Colors.amber),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              padding:
                  EdgeInsets.symmetric(horizontal: media.size.height * 0.03),
              width: double.infinity,
              height: media.size.height * 0.4 * 1.2,
              color: Colors.grey.shade200,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: media.size.height * 0.03,
                    ),
                    Text(
                      'Customr Feedback:',
                      style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: media.size.height * 0.02,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      '',
                      textScaleFactor: 7,
                    ),
                    Text(
                      'Technician Note:',
                      style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: media.size.height * 0.02,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      '',
                      textScaleFactor: 7,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Screenover()));
                      },
                      child: Text(
                        'Add Note',
                        style: TextStyle(
                            color: Colors.blue[600],
                            fontSize: media.size.height * 0.02),
                      ),
                    ),
                  ]),
            ),
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(),
                backgroundColor: Colors.blue[600],
                fixedSize:
                    Size(media.size.height * 0.3, media.size.height * 0.04),
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        child: Container(
                          color: Colors.white,
                          height: media.size.height * 0.5 * 1.3,
                          child: Column(
                            children: [
                              SizedBox(height: media.size.height * 0.03),
                              Container(
                                height: media.size.height * 0.4,
                                child: Image.asset(
                                  'assets/images/complete.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(height: media.size.height * 0.03),
                              Text(
                                'Complete this Task?',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: media.size.height * 0.02 * 1.2),
                              ),
                              SizedBox(
                                height: media.size.height * 0.04,
                              ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue[600],
                                      fixedSize: Size(
                                          media.size.height * 0.2 * 1.4,
                                          media.size.height * 0.05),
                                      shape: RoundedRectangleBorder()),
                                  onPressed: () async {
                                    // await FirebaseFirestore.instance
                                    //     .collection('tasks')
                                    //     .doc(model.taskId)
                                    //     .update({'takeTask': true});
                                    await FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(FirebaseAuth
                                            .instance.currentUser!.uid)
                                        .update({
                                      'complete':
                                          FieldValue.arrayUnion([model.taskId])
                                    });
                                    await FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(FirebaseAuth
                                            .instance.currentUser!.uid)
                                        .update({
                                      'process':
                                          FieldValue.arrayRemove([model.taskId])
                                    });
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CusomterTask()));
                                  },
                                  child: Text('Yes! Complete this task',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: media.size.height * 0.02))),
                            ],
                          ),
                        ),
                      );
                    });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Complete Task',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: media.size.height * 0.02),
                  ),
                  SizedBox(
                    width: media.size.height * 0.02,
                  ),
                  Icon(
                    Icons.check_circle,
                    color: Colors.white,
                    size: media.size.height * 0.03,
                  )
                ],
              ))
        ],
      )),
    );
  }
}
