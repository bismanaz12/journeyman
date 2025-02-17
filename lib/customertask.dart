import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mechanic_app/homefunctions.dart';
import 'package:mechanic_app/taskmodel.dart';
import 'package:mechanic_app/taskscreen.dart';
import 'package:mechanic_app/usermodel.dart';

class CusomterTask extends StatelessWidget {
  const CusomterTask({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Customer Tasks',
            style: TextStyle(
                color: Colors.blue[900],
                fontSize: media.size.height * 0.02 * 1.2,
                fontWeight: FontWeight.w600),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        child: Column(
          children: [
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('tasks')
                    .where('takeTask', isEqualTo: false)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var model = snapshot.data!.docs
                        .map((e) => Taskmodel.frommap(e.data()))
                        .toList();

                    return Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            if (snapshot.hasData) {
                              return Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Container(
                                  height: media.size.height * .2 * 1.4,
                                  width: media.size.width * 2,
                                  decoration:
                                      BoxDecoration(color: Colors.grey[200]),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              'Task: #${model[index].task}',
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
                                                  border: Border.all(
                                                      color: Colors
                                                          .grey.shade500)),
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
                                            InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            TaskScreen(
                                                              home: true,
                                                              model:
                                                                  model[index],
                                                            )));
                                              },
                                              child: Container(
                                                height: 33,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                  color: Colors.blue[900],
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text('Open',
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color:
                                                                Colors.white))
                                                  ],
                                                ),
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
                                                    topRight:
                                                        Radius.circular(20),
                                                    bottomRight:
                                                        Radius.circular(20))),
                                          ),
                                          Text(
                                            '- - - - - - - - - - - - - - - - - - - - - - - - - ',
                                            style: TextStyle(
                                                fontSize: 25,
                                                color: Colors.grey.shade500),
                                          ),
                                          Spacer(),
                                          Container(
                                            height: 25,
                                            width: 15,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20),
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
                                            const EdgeInsets.only(left: 15),
                                        child: Text(
                                          model[index].productname,
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: StreamBuilder(
                                            stream: FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(model[index].customerId)
                                                .snapshots(),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                var dat = snapshot.data!.data();
                                                Usermodel user =
                                                    Usermodel.fromMap(dat!);
                                                return Row(
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 25,
                                                      backgroundImage:
                                                          NetworkImage(
                                                              user.image),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            user.name,
                                                            style: TextStyle(
                                                                fontSize: 16),
                                                          ),
                                                          Text(
                                                            user.address,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey
                                                                    .shade500,
                                                                fontSize: 16),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              }
                                              return Text('');
                                            }),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                            return Text('');
                          }),
                    );
                  }
                  return Text('');
                }),
          ],
        ),
      ),
    );
  }
}
