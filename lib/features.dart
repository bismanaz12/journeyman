import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:mechanic_app/imagescreen.dart';
import 'package:mechanic_app/taskmodel.dart';

class SpecificationScreen extends StatefulWidget {
  SpecificationScreen({super.key});

  @override
  State<SpecificationScreen> createState() => _SpecificationScreenState();
}

bool name = false;
bool enginetype = false;
bool horse = false;
bool torque = false;
bool fuel = false;
bool engine = false;

TextEditingController enginetypecont = TextEditingController();
TextEditingController horsecont = TextEditingController();
TextEditingController torquecont = TextEditingController();
TextEditingController fuelcont = TextEditingController();
TextEditingController enginecont = TextEditingController();

TextEditingController namecont = TextEditingController();

class _SpecificationScreenState extends State<SpecificationScreen> {
  @override
  Widget build(BuildContext context) {
    var _mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding:
              EdgeInsets.symmetric(horizontal: _mediaQuery.size.height * 0.03),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: _mediaQuery.size.height * 0.09,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  name
                      ? Container(
                          width: _mediaQuery.size.height * 0.3,
                          child: TextFormField(
                            controller: namecont,
                            decoration: InputDecoration(
                                focusColor: null,
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                                hintText: '...Edit name',
                                hintStyle: TextStyle(
                                    color: Colors.blue[600],
                                    fontSize: _mediaQuery.size.height * 0.02)),
                          ),
                        )
                      : Text(
                          namecont.text.isEmpty
                              ? 'Product Name'
                              : namecont.text,
                          style: TextStyle(color: Colors.black, fontSize: 24),
                        ),
                  IconButton(
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.blue[600],
                        shape: CircleBorder(),
                      ),
                      onPressed: () async {
                        setState(() {
                          name = !name;
                        });
                        if (namecont.text.isNotEmpty) {
                          try {
                            // Toggle 'name' state

                            // Update the UI to reflect the state change

                            // Fetch the task document
                            QuerySnapshot<Map<String, dynamic>> taskSnapshot =
                                await FirebaseFirestore.instance
                                    .collection('tasks')
                                    .where('customerId',
                                        isEqualTo: FirebaseAuth
                                            .instance.currentUser!.uid)
                                    .orderBy('time', descending: true)
                                    .get();
                            print('Error updating document: $taskSnapshot');

                            // If the document exists, update 'productname' field
                            if (taskSnapshot.docs.first.exists) {
                              Taskmodel data = Taskmodel.frommap(
                                  taskSnapshot.docs.first.data());
                              print('Error updating document: $taskSnapshot');
                              await FirebaseFirestore.instance
                                  .collection('tasks')
                                  .doc(data.taskId)
                                  .update({'productname': namecont.text});

                              // Clear text field after successful update
                              namecont.text = '';
                              // Update the UI again after the text field is cleared
                              setState(() {});
                            }
                          } catch (e) {
                            print('Error updating document: $e');
                            // Handle error as needed
                          }
                        }
                      },
                      icon: Icon(
                        name ? Icons.check : Icons.edit,
                        color: Colors.white,
                      )),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection('tasks')
                    .where('customerId',
                        isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                    .orderBy('time', descending: true)
                    .snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  List<Taskmodel> tasks = snapshot.data!.docs
                      .map((doc) => Taskmodel.frommap(doc.data()))
                      .toList();

                  return SizedBox(
                    height: _mediaQuery.size.height * 0.1 * 1.8,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        Taskmodel task = tasks[index];

                        // Assuming task.photo is a List<String> of image URLs
                        return Row(
                          children: List.generate(
                            task.photo.length,
                            (photoIndex) => Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: _mediaQuery.size.height * 0.01),
                              child: Product_Image(
                                mediaQuery: _mediaQuery,
                                image: task.photo[photoIndex],
                              ),
                            ),
                          ).toList(),
                        );
                      },
                    ),
                  );
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: _mediaQuery.size.height * 0.02),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.white),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: _mediaQuery.size.height * 0.02,
                      ),
                      Text(
                        'Performance',
                        style: TextStyle(fontSize: 22),
                      ),
                      SizedBox(
                        height: _mediaQuery.size.height * 0.03,
                      ),
                      Flex(
                        direction: Axis.horizontal,
                        children: [
                          Expanded(
                            child: Text(
                              'Engine Type',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: enginetype
                                ? Container(
                                    width: _mediaQuery.size.height * 0.3,
                                    child: TextFormField(
                                      controller: enginetypecont,
                                      decoration: InputDecoration(
                                          focusColor: null,
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black)),
                                          hintText: '...Edit',
                                          hintStyle: TextStyle(
                                              color: Colors.blue[600],
                                              fontSize:
                                                  _mediaQuery.size.height *
                                                      0.02)),
                                    ),
                                  )
                                : Text(
                                    enginetypecont.text.isNotEmpty
                                        ? enginetypecont.text
                                        : 'V6',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.grey),
                                  ),
                          ),
                          IconButton(
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.blue[600],
                                shape: CircleBorder(),
                              ),
                              onPressed: () async {
                                setState(() {
                                  enginetype = !enginetype;
                                });
                                if (enginetypecont.text.isNotEmpty) {
                                  QuerySnapshot<Map<String, dynamic>>
                                      taskSnapshot = await FirebaseFirestore
                                          .instance
                                          .collection('tasks')
                                          .where('customerId',
                                              isEqualTo: FirebaseAuth
                                                  .instance.currentUser!.uid)
                                          .orderBy('time', descending: true)
                                          .get();

                                  // If the document exists, update 'productname' field
                                  if (taskSnapshot.docs.first.exists) {
                                    Taskmodel data = Taskmodel.frommap(
                                        taskSnapshot.docs.first.data());

                                    await FirebaseFirestore.instance
                                        .collection('tasks')
                                        .doc(data.taskId)
                                        .update({
                                      'enginetype': enginetypecont.text
                                    });
                                    enginetypecont.text = '';
                                  }
                                }
                              },
                              icon: Icon(
                                enginetype ? Icons.check : Icons.edit,
                                color: Colors.white,
                              )),
                        ],
                      ),
                      SizedBox(
                        height: _mediaQuery.size.height * 0.02,
                      ),
                      Flex(
                        direction: Axis.horizontal,
                        children: [
                          Expanded(
                            child: Text(
                              'HorsePower',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: horse
                                ? Container(
                                    width: _mediaQuery.size.height * 0.3,
                                    child: TextFormField(
                                      controller: horsecont,
                                      decoration: InputDecoration(
                                          focusColor: null,
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black)),
                                          hintText: '...Edit ',
                                          hintStyle: TextStyle(
                                              color: Colors.blue[600],
                                              fontSize:
                                                  _mediaQuery.size.height *
                                                      0.02)),
                                    ),
                                  )
                                : Text(
                                    horsecont.text.isNotEmpty
                                        ? horsecont.text
                                        : '300HP',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.grey),
                                  ),
                          ),
                          IconButton(
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.blue[600],
                                shape: CircleBorder(),
                              ),
                              onPressed: () async {
                                setState(() {
                                  horse = !horse;
                                });
                                if (horsecont.text.isNotEmpty) {
                                  QuerySnapshot<Map<String, dynamic>>
                                      taskSnapshot = await FirebaseFirestore
                                          .instance
                                          .collection('tasks')
                                          .where('customerId',
                                              isEqualTo: FirebaseAuth
                                                  .instance.currentUser!.uid)
                                          .orderBy('time', descending: true)
                                          .get();

                                  // If the document exists, update 'productname' field
                                  if (taskSnapshot.docs.first.exists) {
                                    Taskmodel data = Taskmodel.frommap(
                                        taskSnapshot.docs.first.data());
                                    await FirebaseFirestore.instance
                                        .collection('tasks')
                                        .doc(data.taskId)
                                        .update({'horsepower': horsecont.text});
                                    horsecont.text = '';
                                  }
                                }
                              },
                              icon: Icon(
                                horse ? Icons.check : Icons.edit,
                                color: Colors.white,
                              )),
                        ],
                      ),
                      SizedBox(
                        height: _mediaQuery.size.height * 0.02,
                      ),
                      Flex(
                        direction: Axis.horizontal,
                        children: [
                          Expanded(
                            child: Text(
                              'Torque',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: torque
                                ? Container(
                                    width: _mediaQuery.size.height * 0.3,
                                    child: TextFormField(
                                      controller: torquecont,
                                      decoration: InputDecoration(
                                          focusColor: null,
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black)),
                                          hintText: '...Edit',
                                          hintStyle: TextStyle(
                                              color: Colors.blue[600],
                                              fontSize:
                                                  _mediaQuery.size.height *
                                                      0.02)),
                                    ),
                                  )
                                : Text(
                                    torquecont.text.isNotEmpty
                                        ? torquecont.text
                                        : '300ml',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.grey),
                                  ),
                          ),
                          IconButton(
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.blue[600],
                                shape: CircleBorder(),
                              ),
                              onPressed: () async {
                                torque = !torque;
                                setState(() {});
                                if (torquecont.text.isNotEmpty) {
                                  QuerySnapshot<Map<String, dynamic>>
                                      taskSnapshot = await FirebaseFirestore
                                          .instance
                                          .collection('tasks')
                                          .where('customerId',
                                              isEqualTo: FirebaseAuth
                                                  .instance.currentUser!.uid)
                                          .orderBy('time', descending: true)
                                          .get();

                                  // If the document exists, update 'productname' field
                                  if (taskSnapshot.docs.first.exists) {
                                    Taskmodel data = Taskmodel.frommap(
                                        taskSnapshot.docs.first.data());
                                    await FirebaseFirestore.instance
                                        .collection('tasks')
                                        .doc(data.taskId)
                                        .update({'torque': torquecont.text});
                                    torquecont.text = '';
                                  }
                                }
                              },
                              icon: Icon(
                                torque ? Icons.check : Icons.edit,
                                color: Colors.white,
                              )),
                        ],
                      ),
                      SizedBox(
                        height: _mediaQuery.size.height * 0.02,
                      ),
                      Flex(
                        direction: Axis.horizontal,
                        children: [
                          Expanded(
                            child: Text(
                              'Fuel Efficiency',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: fuel
                                ? Container(
                                    width: _mediaQuery.size.height * 0.3,
                                    child: TextFormField(
                                      controller: fuelcont,
                                      decoration: InputDecoration(
                                          focusColor: null,
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black)),
                                          hintText: '...Edit',
                                          hintStyle: TextStyle(
                                              color: Colors.blue[600],
                                              fontSize:
                                                  _mediaQuery.size.height *
                                                      0.02)),
                                    ),
                                  )
                                : Text(
                                    fuelcont.text.isNotEmpty
                                        ? fuelcont.text
                                        : '200mpg',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.grey),
                                  ),
                          ),
                          IconButton(
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.blue[600],
                                shape: CircleBorder(),
                              ),
                              onPressed: () async {
                                fuel = !fuel;
                                setState(() {});
                                if (fuelcont.text.isNotEmpty) {
                                  QuerySnapshot<Map<String, dynamic>>
                                      taskSnapshot = await FirebaseFirestore
                                          .instance
                                          .collection('tasks')
                                          .where('customerId',
                                              isEqualTo: FirebaseAuth
                                                  .instance.currentUser!.uid)
                                          .orderBy('time', descending: true)
                                          .get();

                                  // If the document exists, update 'productname' field
                                  if (taskSnapshot.docs.first.exists) {
                                    Taskmodel data = Taskmodel.frommap(
                                        taskSnapshot.docs.first.data());
                                    await FirebaseFirestore.instance
                                        .collection('tasks')
                                        .doc(data.taskId)
                                        .update(
                                            {'fuelefficiency': fuelcont.text});
                                    fuelcont.text = '';
                                  }
                                }
                              },
                              icon: Icon(
                                fuel ? Icons.check : Icons.edit,
                                color: Colors.white,
                              )),
                        ],
                      ),
                      SizedBox(
                        height: _mediaQuery.size.height * 0.02,
                      ),
                      Flex(
                        direction: Axis.horizontal,
                        children: [
                          Expanded(
                            child: Text(
                              'Engine Oil Level',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: engine
                                ? Container(
                                    width: _mediaQuery.size.height * 0.3,
                                    child: TextFormField(
                                      controller: enginecont,
                                      decoration: InputDecoration(
                                          focusColor: null,
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black)),
                                          hintText: '...Edit',
                                          hintStyle: TextStyle(
                                              color: Colors.blue[600],
                                              fontSize:
                                                  _mediaQuery.size.height *
                                                      0.02)),
                                    ),
                                  )
                                : Text(
                                    enginecont.text.isNotEmpty
                                        ? enginecont.text
                                        : 'good',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.grey),
                                  ),
                          ),
                          IconButton(
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.blue[600],
                                shape: CircleBorder(),
                              ),
                              onPressed: () async {
                                engine = !engine;
                                setState(() {});
                                if (enginecont.text.isNotEmpty) {
                                  QuerySnapshot<Map<String, dynamic>>
                                      taskSnapshot = await FirebaseFirestore
                                          .instance
                                          .collection('tasks')
                                          .where('customerId',
                                              isEqualTo: FirebaseAuth
                                                  .instance.currentUser!.uid)
                                          .orderBy('time', descending: true)
                                          .get();

                                  // If the document exists, update 'productname' field
                                  if (taskSnapshot.docs.first.exists) {
                                    Taskmodel data = Taskmodel.frommap(
                                        taskSnapshot.docs.first.data());
                                    await FirebaseFirestore.instance
                                        .collection('tasks')
                                        .doc(data.taskId)
                                        .update({'engineoil': enginecont.text});
                                    enginecont.text = '';
                                  }
                                }
                              },
                              icon: Icon(
                                engine ? Icons.check : Icons.edit,
                                color: Colors.white,
                              )),
                        ],
                      ),
                      SizedBox(
                        height: _mediaQuery.size.height * 0.1 * 1.2,
                      ),
                      Center(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue[600],
                                fixedSize: Size(_mediaQuery.size.height * 0.3,
                                    _mediaQuery.size.height * 0.04),
                                shape: RoundedRectangleBorder()),
                            onPressed: () {},
                            child: Text(
                              'Next',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: _mediaQuery.size.height * 0.02),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Performance_List extends StatelessWidget {
  const Performance_List({super.key, required this.text, required this.text2});
  final String text;
  final String text2;
  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: [
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            text2,
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}

class Product_Image extends StatelessWidget {
  const Product_Image({
    super.key,
    required MediaQueryData mediaQuery,
    required this.image,
  }) : _mediaQuery = mediaQuery;

  final MediaQueryData _mediaQuery;
  final String image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => FullScreenImage(image: image),
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
        );
      },
      child: Container(
        height: _mediaQuery.size.height * .22,
        width: _mediaQuery.size.width * .45,
        decoration: BoxDecoration(
            image:
                DecorationImage(image: NetworkImage(image), fit: BoxFit.fill)),
      ),
    );
  }
}
