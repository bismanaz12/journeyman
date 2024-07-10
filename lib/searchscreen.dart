import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mechanic_app/usermodel.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: media.size.height * 0.1,
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
            SizedBox(
              width: media.size.height * 0.1 * 1.2,
            ),
            Text(
              'Technicians',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: media.size.height * 0.02,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: media.size.height * 0.02),
        color: Color.fromARGB(255, 235, 234, 234),
        child: Column(
          children: [
            SizedBox(
              height: media.size.height * 0.03,
            ),
            SearchBar(
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                side: BorderSide(
                    color: Colors.blue, width: media.size.height * 0.001),
              )),
              backgroundColor: MaterialStatePropertyAll(Colors.white),
              leading: Icon(
                Icons.search,
                color: Colors.blue[600],
              ),
              hintText: 'search for...',
              hintStyle:
                  MaterialStatePropertyAll(TextStyle(color: Colors.black)),
              onChanged: (value) {
                search.text = value;
              },
              controller: search,
              textStyle:
                  MaterialStatePropertyAll(TextStyle(color: Colors.black)),
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .where('persontype', isEqualTo: 'technician')
                    .snapshots(),
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          var data = snapshot.data!.docs
                              .map((e) => Usermodel.fromMap(e.data()))
                              .toList();
                          return Padding(
                            padding:
                                EdgeInsets.only(top: media.size.height * 0.03),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          media.size.height * 0.03))),
                              height: media.size.height * 0.2,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: media.size.height * 0.02,
                                  ),
                                  Row(children: [
                                    SizedBox(
                                      width: media.size.height * 0.02,
                                    ),
                                    CircleAvatar(
                                      radius: media.size.height * 0.04,
                                      backgroundImage:
                                          NetworkImage(data[index].image),
                                    ),
                                    SizedBox(
                                      width: media.size.height * 0.02,
                                    ),
                                    Expanded(
                                      child: Container(
                                        width: media.size.height * 0.3,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data[index].name,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize:
                                                      media.size.height * 0.02),
                                            ),
                                            Text(
                                              data[index].bio,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Color.fromARGB(
                                                    255, 202, 195, 195),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ]),
                                  SizedBox(
                                    height: media.size.height * 0.04,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: media.size.height * 0.07,
                                      ),
                                      Text(
                                        'ID:# ${data[index].techId}',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 202, 195, 195),
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        width: media.size.height * 0.02,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber[600],
                                      ),
                                      Text(
                                        '4.9',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        width: media.size.height * 0.05,
                                      ),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              fixedSize: Size(
                                                  media.size.height * 0.1 * 1.4,
                                                  media.size.height * 0.04),
                                              backgroundColor: Colors.blue[600],
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(media
                                                                  .size.height *
                                                              0.02)))),
                                          onPressed: () {},
                                          child: Center(
                                              child: Text(
                                            'View Tasks',
                                            style:
                                                TextStyle(color: Colors.white),
                                          )))
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  }
                  return Text('');
                }))
          ],
        ),
      ),
    );
  }
}
