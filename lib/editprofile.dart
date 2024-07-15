import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mechanic_app/customerprofile.dart';

import 'package:mechanic_app/imagepicker.dart';
import 'package:mechanic_app/searchscreen.dart';
import 'package:mechanic_app/technicianprofile.dart';
import 'package:mechanic_app/usermodel.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class Editprofile extends StatefulWidget {
  Editprofile({super.key});

  @override
  State<Editprofile> createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
  bool yes = false;
  bool name = false;
  TextEditingController namecont = TextEditingController();
  TextEditingController addresscon = TextEditingController();
  TextEditingController biocon = TextEditingController();

  bool no = false;
  bool rep = false;
  bool dia = false;
  bool elec = false;
  bool tech = false;
  bool safety = false;
  bool all = false;
  String service = '';
  Future<String> downloadurl(File file) async {
    String id = const Uuid().v4();
    String url = '';
    FirebaseStorage firestor = FirebaseStorage.instance;
    await firestor
        .ref()
        .child('users')
        .child('$id.png')
        .putFile(file)
        .then((p0) async {
      url = await p0.ref.getDownloadURL();
    });
    return url;
  }

  String randomid() {
    Random random = Random();
    int randomNumber = 10000 + random.nextInt(90000);
    return randomNumber.toString();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                'Edit Profile',
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
        height: double.infinity,
        padding: EdgeInsets.symmetric(
            horizontal: media.size.height * 0.03 * 1.3,
            vertical: media.size.height * 0.02),
        width: double.infinity,
        color: Color.fromARGB(255, 235, 234, 234),
        child: SingleChildScrollView(
          child: Consumer<ImagePickerProvider>(builder: (context, pro, _) {
            return Column(
              children: [
                Stack(children: [
                  Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.white,
                              width: media.size.height * 0.002),
                          shape: BoxShape.circle),
                      child: pro.image != null
                          ? CircleAvatar(
                              radius: media.size.height * 0.07,
                              backgroundImage: FileImage(pro.image!),
                            )
                          : CircleAvatar(
                              radius: media.size.height * 0.07,
                            )),
                  Positioned(
                    top: media.size.height * 0.09,
                    left: media.size.height * 0.09,
                    child: IconButton(
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.blue[600],
                          shape: CircleBorder(),
                        ),
                        onPressed: () {
                          pro.Imagepicker();
                        },
                        icon: Icon(
                          Icons.edit,
                          color: Colors.white,
                        )),
                  ),
                ]),
                Padding(
                  padding: EdgeInsets.only(top: media.size.height * 0.03),
                  child: Flex(direction: Axis.horizontal, children: [
                    Expanded(
                        child: Container(
                      width: media.size.height * 0.02,
                      child: Text(
                        'Name:',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: media.size.height * 0.02 * 1.2,
                        ),
                      ),
                    )),
                    Expanded(
                      flex: 1,
                      child: name
                          ? Container(
                              child: TextFormField(
                                controller: namecont,
                                decoration: InputDecoration(
                                    focusColor: null,
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                    hintText: 'Edit name',
                                    hintStyle: TextStyle(
                                        color: Colors.blue[600],
                                        fontSize: media.size.height * 0.02)),
                              ),
                            )
                          : StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    namecont.text.isNotEmpty
                                        ? namecont.text
                                        : snapshot.data!.data()!['name'],
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize:
                                            media.size.height * 0.02 * 1.2),
                                  );
                                }
                                return Text('');
                              }),
                    ),
                    IconButton(
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.blue[600],
                          shape: CircleBorder(),
                        ),
                        onPressed: () {
                          name = !name;
                          setState(() {});
                        },
                        icon: Icon(
                          name ? Icons.check : Icons.edit,
                          color: Colors.white,
                        )),
                  ]),
                ),
                Container(
                  color: Colors.black,
                  height: media.size.height * 0.001,
                ),
                Padding(
                  padding: EdgeInsets.only(top: media.size.height * 0.04),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Are you Customer or Mechanic:',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: media.size.height * 0.02),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: media.size.height * 0.02),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          no = false;
                          yes = !yes;
                          setState(() {});
                        },
                        child: Icon(
                          yes ? Icons.circle : Icons.circle_outlined,
                          color: Colors.blue[600],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: media.size.height * 0.02),
                        child: Text(
                          'Customer',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: media.size.height * 0.02),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          yes = false;
                          no = !no;
                          setState(() {});
                        },
                        child: Icon(
                          no ? Icons.circle : Icons.circle_outlined,
                          color: Colors.blue[600],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: media.size.height * 0.02),
                        child: Text(
                          'Technician',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
                yes
                    ? Padding(
                        padding: EdgeInsets.only(top: media.size.height * 0.03),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Address:',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: media.size.height * 0.02),
                          ),
                        ),
                      )
                    : no
                        ? Padding(
                            padding:
                                EdgeInsets.only(top: media.size.height * 0.03),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Which type of services you Provide:',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: media.size.height * 0.02),
                              ),
                            ),
                          )
                        : Text(''),
                yes
                    ? Container(
                        child: TextFormField(
                          controller: addresscon,
                          maxLength: 60,
                        ),
                      )
                    : no
                        ? Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: media.size.height * 0.02),
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        rep = !rep;
                                        service = 'repairing';
                                        tech = false;
                                        elec = false;
                                        dia = false;
                                        all = false;
                                        safety = false;
                                        setState(() {});
                                      },
                                      child: Icon(
                                        rep
                                            ? Icons.circle
                                            : Icons.circle_outlined,
                                        color: Colors.blue[600],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: media.size.height * 0.02),
                                      child: Text(
                                        'Repairing equipments',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: media.size.height * 0.02),
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        rep = false;
                                        tech = false;
                                        elec = false;
                                        dia = !dia;
                                        service = 'diagnostic';
                                        all = false;
                                        safety = false;
                                        setState(() {});
                                      },
                                      child: Icon(
                                        dia
                                            ? Icons.circle
                                            : Icons.circle_outlined,
                                        color: Colors.blue[600],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: media.size.height * 0.02),
                                      child: Text(
                                        'Diagnostic Skills',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: media.size.height * 0.02),
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        rep = false;
                                        tech = false;
                                        elec = !elec;
                                        service = 'electrician';
                                        dia = false;
                                        all = false;
                                        safety = false;
                                        setState(() {});
                                      },
                                      child: Icon(
                                        elec
                                            ? Icons.circle
                                            : Icons.circle_outlined,
                                        color: Colors.blue[600],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: media.size.height * 0.02),
                                      child: Text(
                                        'Electrician',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: media.size.height * 0.02),
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        rep = false;
                                        tech = !tech;
                                        service = 'technician';
                                        elec = false;
                                        dia = false;
                                        all = false;
                                        safety = false;
                                        setState(() {});
                                      },
                                      child: Icon(
                                        tech
                                            ? Icons.circle
                                            : Icons.circle_outlined,
                                        color: Colors.blue[600],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: media.size.height * 0.02),
                                      child: Text(
                                        'Technical',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: media.size.height * 0.02),
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        rep = false;
                                        tech = false;
                                        elec = false;
                                        dia = false;
                                        all = false;
                                        safety = !safety;
                                        service = 'safety compliance';
                                        setState(() {});
                                      },
                                      child: Icon(
                                        safety
                                            ? Icons.circle
                                            : Icons.circle_outlined,
                                        color: Colors.blue[600],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: media.size.height * 0.02),
                                      child: Text(
                                        'Safety Compliance',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: media.size.height * 0.02),
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        rep = false;
                                        tech = false;
                                        elec = false;
                                        dia = false;
                                        all = !all;
                                        service = 'all';
                                        safety = false;
                                        setState(() {});
                                      },
                                      child: Icon(
                                        all
                                            ? Icons.circle
                                            : Icons.circle_outlined,
                                        color: Colors.blue[600],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: media.size.height * 0.02),
                                      child: Text(
                                        'All',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : Text(''),
                no
                    ? Padding(
                        padding: EdgeInsets.only(top: media.size.height * 0.03),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Bio:',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: media.size.height * 0.02),
                          ),
                        ),
                      )
                    : Text(''),
                no
                    ? Container(
                        child: TextFormField(
                          controller: biocon,
                          maxLength: 60,
                        ),
                      )
                    : Text(''),
                Padding(
                  padding: EdgeInsets.only(top: media.size.height * 0.03),
                  child: ElevatedButton(
                    onPressed: () async {
                      Usermodel model = await FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .get()
                          .then((value) => Usermodel.fromMap(value.data()!));
                      String url = pro.image != null
                          ? await downloadurl(pro.image!)
                          : '';

                      if (yes == true) {
                        if (addresscon.text.isNotEmpty) {
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .update({
                            'name': namecont.text.isNotEmpty
                                ? namecont.text
                                : model.name,
                            'address': addresscon.text,
                            'persontype': 'customer',
                            'bio': '',
                            'service': '',
                            'image': pro.image != null ? url : ''
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CustomerProfile()));
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  backgroundColor: Colors.white,
                                  child: Container(
                                    height: media.size.height * 0.2,
                                    width: media.size.height * 0.2,
                                    color: Colors.white,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: media.size.height * 0.01,
                                        ),
                                        Container(
                                            height: media.size.height * 0.04,
                                            child: Image.asset(
                                              'assets/images/wrong.png',
                                              fit: BoxFit.cover,
                                            )),
                                        SizedBox(
                                          height: media.size.height * 0.02,
                                        ),
                                        Text(
                                          'Enter required fields',
                                          style: TextStyle(
                                              color: Colors.redAccent,
                                              fontSize:
                                                  media.size.height * 0.02),
                                        ),
                                        SizedBox(
                                          height: media.size.height * 0.03,
                                        ),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.white,
                                                foregroundColor: Colors.white,
                                                fixedSize: Size(
                                                    media.size.height *
                                                        0.1 *
                                                        1.5,
                                                    media.size.height * 0.04),
                                                shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                        color: Colors.redAccent,
                                                        width:
                                                            media.size.height *
                                                                0.002))),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              'OK',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ))
                                      ],
                                    ),
                                  ),
                                );
                              });
                        }
                      } else if (no == true) {
                        if (biocon.text.isNotEmpty && service.isNotEmpty) {
                          String Id = randomid();
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .update({
                            'name': namecont.text.isNotEmpty
                                ? namecont.text
                                : model.name,
                            'bio': biocon.text,
                            'persontype': 'technician',
                            'service': service,
                            'address': '',
                            'image': pro.image != null ? url : '',
                            'techId': Id
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TechnicianProfile()));
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  backgroundColor: Colors.white,
                                  child: Container(
                                    height: media.size.height * 0.2,
                                    width: media.size.height * 0.2,
                                    color: Colors.white,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: media.size.height * 0.01,
                                        ),
                                        Container(
                                            height: media.size.height * 0.04,
                                            child: Image.asset(
                                              'assets/images/wrong.png',
                                              fit: BoxFit.cover,
                                            )),
                                        SizedBox(
                                          height: media.size.height * 0.02,
                                        ),
                                        Text(
                                          'Enter required fields',
                                          style: TextStyle(
                                              color: Colors.redAccent,
                                              fontSize:
                                                  media.size.height * 0.02),
                                        ),
                                        SizedBox(
                                          height: media.size.height * 0.03,
                                        ),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.white,
                                                foregroundColor: Colors.white,
                                                fixedSize: Size(
                                                    media.size.height *
                                                        0.1 *
                                                        1.5,
                                                    media.size.height * 0.04),
                                                shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                        color: Colors.redAccent,
                                                        width:
                                                            media.size.height *
                                                                0.002))),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              'OK',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ))
                                      ],
                                    ),
                                  ),
                                );
                              });
                        }
                      } else if (yes == false && no == false) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                backgroundColor: Colors.white,
                                child: Container(
                                  height: media.size.height * 0.2,
                                  width: media.size.height * 0.2,
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: media.size.height * 0.01,
                                      ),
                                      Container(
                                          height: media.size.height * 0.04,
                                          child: Image.asset(
                                            'assets/images/wrong.png',
                                            fit: BoxFit.cover,
                                          )),
                                      SizedBox(
                                        height: media.size.height * 0.02,
                                      ),
                                      Text(
                                        'Enter required fields',
                                        style: TextStyle(
                                            color: Colors.redAccent,
                                            fontSize: media.size.height * 0.02),
                                      ),
                                      SizedBox(
                                        height: media.size.height * 0.03,
                                      ),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white,
                                              foregroundColor: Colors.white,
                                              fixedSize: Size(
                                                  media.size.height * 0.1 * 1.5,
                                                  media.size.height * 0.04),
                                              shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                      color: Colors.redAccent,
                                                      width: media.size.height *
                                                          0.002))),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            'OK',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ))
                                    ],
                                  ),
                                ),
                              );
                            });
                      }
                    },
                    child: Text('Save'),
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(285, 46),
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue[600],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: media.viewInsets.bottom,
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
