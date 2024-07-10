import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mechanic_app/searchscreen.dart';
import 'package:mechanic_app/tasksdetail.dart';

class CustomerProfile extends StatelessWidget {
  const CustomerProfile({super.key});

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
                            // Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchScreen()));
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
                                  data!['persontype'] == 'customer'
                                      ? data['image']
                                      : ''),
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
                              data!['persontype'] == 'customer'
                                  ? data['name']
                                  : 'Name',
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
                                    data!['persontype'] == 'customer'
                                        ? data['address']
                                        : 'Address',
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
                            onPressed: () {},
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
              SizedBox(
                height: media.size.height * 0.02,
              ),
              TasksDetail(),
              SizedBox(
                height: media.size.height * 0.02,
              ),
              TasksDetail(),
              SizedBox(
                height: media.size.height * 0.02,
              ),
              TasksDetail(),
            ],
          ),
        ),
      ),
    );
  }
}
