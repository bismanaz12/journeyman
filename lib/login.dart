import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mechanic_app/editprofile.dart';
import 'package:mechanic_app/forgot.dart';
import 'package:mechanic_app/newpassword.dart';
import 'package:mechanic_app/passupdates.dart';
import 'package:mechanic_app/signup.dart';
import 'package:mechanic_app/technicianprofile.dart';

class Login_Screen_2 extends StatefulWidget {
  Login_Screen_2({super.key});

  @override
  State<Login_Screen_2> createState() => _Login_Screen_2State();
}

class _Login_Screen_2State extends State<Login_Screen_2> {
  TextEditingController email = TextEditingController();

  TextEditingController pass = TextEditingController();

  bool hiddenpass = true;

  @override
  Widget build(BuildContext context) {
    var _mediaQuery = MediaQuery.of(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
            height: double.infinity,
            width: double.infinity,
            // decoration: BoxDecoration(
            //   image: DecorationImage(
            //     image: AssetImage('assets/Images/whitebackground.jpg'),
            //     fit: BoxFit.fill,
            //   ),
            // ),
            child: SafeArea(
                child: Column(
              children: [
                SizedBox(
                  height: _mediaQuery.size.height * .04,
                ),
                Container(
                  height: _mediaQuery.size.height * .2,
                  width: _mediaQuery.size.width * .4,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/logo.png'),
                      fit: BoxFit.cover,
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
                  controller: email,
                  decoration: InputDecoration(
                      focusColor: Colors.white,
                      constraints: BoxConstraints(maxWidth: 282, maxHeight: 50),
                      filled: false,
                      enabledBorder: OutlineInputBorder(
                        // borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        // borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      prefixIcon: Icon(
                        Icons.person_3_outlined,
                        color: Colors.black,
                      ),
                      hintText: 'Email',
                      hintStyle: TextStyle(color: Colors.grey)),
                ),
                SizedBox(
                  height: _mediaQuery.size.height * .04,
                ),
                TextFormField(
                  // controller: controller,
                  obscureText: hiddenpass,
                  controller: pass,
                  decoration: InputDecoration(
                      focusColor: Colors.white,
                      constraints: BoxConstraints(maxWidth: 282, maxHeight: 50),
                      filled: false,
                      enabledBorder: OutlineInputBorder(
                        // borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        // borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
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
                      prefixIcon: Icon(
                        Icons.https_outlined,
                        color: Colors.black,
                      ),
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.grey)),
                ),
                SizedBox(
                  height: _mediaQuery.size.height * .04,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (email.text.isNotEmpty && pass.text.isNotEmpty) {
                      FirebaseAuth auth = FirebaseAuth.instance;
                      UserCredential user =
                          await auth.signInWithEmailAndPassword(
                              email: email.text, password: pass.text);
                      if (user.user != null) {
                        email.clear();
                        pass.clear();
                        // Get.to(() => PasswordUpdated(),
                        //     duration: Duration(seconds: 2));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Editprofile()));
                      }
                    }
                  },
                  child: Text('Login'),
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(285, 46),
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0xff6982ed),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                ),
               
                SizedBox(
                  height: _mediaQuery.size.height * .01,
                ),
                TextButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            backgroundColor: Colors.white,
                            child: Container(
                              color: Colors.white,
                              height: _mediaQuery.size.height * 0.2,
                              width: _mediaQuery.size.height * 0.1,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: _mediaQuery.size.height * 0.03),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ForgotPasswordScreen()));
                                      },
                                      child: Text(
                                        'Forget Password',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize:
                                                _mediaQuery.size.height * 0.02),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: _mediaQuery.size.height * 0.03),
                                    child: Divider(
                                      color: Colors.grey,
                                      thickness:
                                          _mediaQuery.size.height * 0.002,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: _mediaQuery.size.height * 0.03),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ChangePasswordScreen()));
                                      },
                                      child: Text(
                                        'Change Password',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize:
                                                _mediaQuery.size.height * 0.02),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  child: Text(
                    'Forgot Password',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  'or',
                  style: TextStyle(fontSize: 18),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Login with Face ID',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Dont\'n have an account ?',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignupScreen()));
                        },
                        child: Text(
                          'Register here',
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff6982ed),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ))));
  }

  void toggleview() {
    if (hiddenpass == true) {
      hiddenpass = false;
    } else {
      hiddenpass = true;
    }
    setState(() {});
  }
}
