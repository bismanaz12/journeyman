import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mechanic_app/login.dart';
import 'package:mechanic_app/passupdates.dart';
import 'package:mechanic_app/usermodel.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController email = TextEditingController();

  TextEditingController pass = TextEditingController();

  TextEditingController name = TextEditingController();

  TextEditingController confirmpass = TextEditingController();

  bool hiddenpass = true;
  bool hiddenpass2 = true;

  @override
  Widget build(BuildContext context) {
    var _mediaQuery = MediaQuery.of(context);
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Container(
              height: _mediaQuery.size.height,
              width: _mediaQuery.size.width,
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: _mediaQuery.size.height * .04,
                  ),
                  Container(
                    height: _mediaQuery.size.height * .2,
                    width: _mediaQuery.size.width * .4,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/logo.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Text(
                    'Hamza\'s Garage',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: _mediaQuery.size.height * .10,
                  ),
                  TextFormField(
                    // controller: controller,
                    controller: name,
                    decoration: InputDecoration(
                        focusColor: Colors.white,
                        constraints:
                            BoxConstraints(maxWidth: 282, maxHeight: 50),
                        filled: false,
                        enabledBorder: OutlineInputBorder(
                          // borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          // borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        prefixIcon: Icon(
                          Icons.person_3_outlined,
                          color: Colors.black,
                        ),
                        hintText: 'Username',
                        hintStyle: TextStyle(color: Colors.grey)),
                  ),
                  SizedBox(
                    height: _mediaQuery.size.height * .02,
                  ),
                  TextFormField(
                    // controller: controller,
                    controller: email,
                    decoration: InputDecoration(
                        focusColor: Colors.white,
                        constraints:
                            BoxConstraints(maxWidth: 282, maxHeight: 50),
                        filled: false,
                        enabledBorder: OutlineInputBorder(
                          // borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          // borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Colors.black,
                        ),
                        hintText: 'email',
                        hintStyle: TextStyle(color: Colors.grey)),
                  ),
                  SizedBox(
                    height: _mediaQuery.size.height * .02,
                  ),
                  TextFormField(
                    obscureText: hiddenpass,
                    controller: pass,
                    decoration: InputDecoration(
                        focusColor: Colors.white,
                        constraints:
                            BoxConstraints(maxWidth: 282, maxHeight: 50),
                        filled: false,
                        enabledBorder: OutlineInputBorder(
                          // borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          // borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: Colors.black,
                        ),
                        suffixIcon: InkWell(
                            onTap: toggleview,
                            child: hiddenpass
                                ? Icon(
                                    Icons.remove_red_eye,
                                    color: Colors.black,
                                  )
                                : Icon(
                                    Icons.visibility_off,
                                    color: Colors.black,
                                  )),
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.grey)),
                  ),
                  SizedBox(
                    height: _mediaQuery.size.height * .02,
                  ),
                  TextFormField(
                    // controller: controller,
                    obscureText: hiddenpass2,
                    controller: confirmpass,
                    decoration: InputDecoration(
                        focusColor: Colors.white,
                        constraints:
                            BoxConstraints(maxWidth: 282, maxHeight: 50),
                        filled: false,
                        enabledBorder: OutlineInputBorder(
                          // borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          // borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: Colors.black,
                        ),
                        suffixIcon: InkWell(
                            onTap: toggleview2,
                            child: hiddenpass
                                ? Icon(
                                    Icons.remove_red_eye,
                                    color: Colors.black,
                                  )
                                : Icon(
                                    Icons.visibility_off,
                                    color: Colors.black,
                                  )),
                        hintText: 'ConfirmPassword',
                        hintStyle: TextStyle(color: Colors.grey)),
                  ),
                  SizedBox(
                    height: _mediaQuery.size.height * .02,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: _mediaQuery.size.height * 0.1),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (email.text.isNotEmpty &&
                              pass.text.isNotEmpty &&
                              confirmpass.text.isNotEmpty &&
                              name.text.isNotEmpty) {
                            if (pass.text == confirmpass.text) {
                              FirebaseAuth auth = FirebaseAuth.instance;
                              FirebaseFirestore fire =
                                  FirebaseFirestore.instance;

                              UserCredential user =
                                  await auth.createUserWithEmailAndPassword(
                                      email: email.text, password: pass.text);
                              Usermodel model = Usermodel(
                                  email: email.text,
                                  id: user.user!.uid,
                                  name: name.text,
                                  pass: pass.text);
                              fire
                                  .collection('users')
                                  .doc(user.user!.uid)
                                  .set(model.toMap());
                            }
                            email.clear();
                            pass.clear();
                            confirmpass.clear();
                            name.clear();
                            // Get.to(() => Login_Screen_2(),
                            //     duration: Duration(seconds: 2));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login_Screen_2()));
                          }
                        },
                        child: Text('Signup'),
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(285, 46),
                          foregroundColor: Colors.white,
                          backgroundColor: Color(0xff6982ed),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'If have an account ?',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login_Screen_2()));
                          },
                          child: Text(
                            'Login here',
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(0xff6982ed),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: _mediaQuery.viewInsets.bottom),
                ],
              )),
        ));
  }

  void toggleview() {
    if (hiddenpass == true) {
      hiddenpass = false;
    } else {
      hiddenpass = true;
    }
    setState(() {});
  }

  void toggleview2() {
    if (hiddenpass2 == true) {
      hiddenpass2 = false;
    } else {
      hiddenpass2 = true;
    }
    setState(() {});
  }
}
