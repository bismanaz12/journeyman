import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mechanic_app/passupdates.dart';
import 'package:mechanic_app/usermodel.dart';
import 'package:mechanic_app/userprovider.dart';
import 'package:provider/provider.dart';

class ChangePasswordScreen extends StatefulWidget {
  ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  TextEditingController prevpass = TextEditingController();

  TextEditingController newpass = TextEditingController();

  bool hidenpassword = true;
  bool hiddenpass2 = true;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: media.size.height * 0.04,
        backgroundColor: Colors.white,
      ),
      body: Container(
        width: double.infinity,
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: media.size.height * 0.02),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
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
            ),
            Padding(
              padding: EdgeInsets.only(top: media.size.height * 0.05),
              child: Text(
                'Create Your New Password',
                style: TextStyle(
                    color: Color.fromARGB(255, 39, 36, 36),
                    fontSize: media.size.height * 0.05),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: media.size.height * 0.01 * 1.3),
              child: Center(
                child: Text(
                  'Your new password must be different from previous password',
                  style: TextStyle(
                      color: Color.fromARGB(255, 182, 177, 177),
                      // fontFamily: 'Font',
                      fontSize: media.size.height * 0.02 * 1.2),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: media.size.height * 0.02),
              child: TextFormField(
                controller: prevpass,
                obscureText: hidenpassword,
                decoration: InputDecoration(
                  constraints: BoxConstraints(maxWidth: 310, maxHeight: 50),
                  suffixIcon: InkWell(
                      onTap: toggleview,
                      child: hidenpassword
                          ? Icon(
                              Icons.remove_red_eye,
                              color: Color.fromARGB(255, 210, 198, 198),
                            )
                          : Icon(
                              Icons.visibility_off,
                              color: Color.fromARGB(255, 210, 198, 198),
                            )),
                  hintText: 'Currentpassword',
                  hintStyle: TextStyle(
                      color: Color.fromARGB(255, 210, 198, 198),
                      fontSize: media.size.height * 0.02 * 1.1),
                  prefixIcon: Icon(
                    Icons.lock_outline_sharp,
                    size: media.size.height * 0.03,
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 210, 205, 205))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 53, 146, 247),
                          width: media.size.height * 0.002)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: media.size.height * 0.02),
              child: TextFormField(
                controller: newpass,
                obscureText: hiddenpass2,
                decoration: InputDecoration(
                  constraints: BoxConstraints(maxWidth: 310, maxHeight: 50),
                  suffixIcon: InkWell(
                    onTap: toggleview2,
                    child: hidenpassword
                        ? Icon(
                            Icons.remove_red_eye,
                            color: Color.fromARGB(255, 210, 198, 198),
                          )
                        : Icon(
                            Icons.visibility_off,
                            color: Color.fromARGB(255, 210, 198, 198),
                          ),
                  ),
                  hintText: 'Password',
                  hintStyle: TextStyle(
                      color: Color.fromARGB(255, 210, 198, 198),
                      fontSize: media.size.height * 0.02 * 1.1),
                  prefixIcon: Icon(
                    Icons.lock_outline_sharp,
                    size: media.size.height * 0.03,
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 210, 205, 205))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 53, 146, 247),
                          width: media.size.height * 0.002)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: media.size.height * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    color: Color.fromARGB(255, 20, 123, 207),
                  ),
                  Text(
                    'Must not contain your email or password',
                    style: TextStyle(
                        color: Color.fromARGB(255, 20, 123, 207),
                        fontSize: media.size.height * 0.02),
                  )
                ],
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.check_circle_outline,
                  color: Color.fromARGB(255, 182, 177, 177),
                ),
                Padding(
                  padding: EdgeInsets.only(left: media.size.height * 0.02),
                  child: Text(
                    'At least 8 characters',
                    style: TextStyle(
                        color: Color.fromARGB(255, 182, 177, 177),
                        fontSize: media.size.height * 0.02),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.check_circle_outline,
                  color: Color.fromARGB(255, 182, 177, 177),
                ),
                Padding(
                  padding: EdgeInsets.only(left: media.size.height * 0.02),
                  child: Text(
                    'Contain a symbol or a number',
                    style: TextStyle(
                        color: Color.fromARGB(255, 182, 177, 177),
                        fontSize: media.size.height * 0.02),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: media.size.height * 0.2 * 1.3),
              child: ElevatedButton(
                onPressed: () async {
                  Usermodel data = await FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .get()
                      .then((value) => Usermodel.fromMap(value.data()!));

                  if (prevpass.text == data.pass) {
                    //Create an instance of the current user.
                    // FirebaseUser user =
                    //     await FirebaseAuth.instance.currentUser!();

                    // //Pass in the password to updatePassword.
                    // user.updatePassword(newpass.text).then((_) {
                    //   print("Successfully changed password");
                    // }).catchError((error) {
                    //   print("Password can't be changed" + error.toString());
                    //   //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
                    // });

                    // Get the current user
                    User? usermo = FirebaseAuth.instance.currentUser;

                    // Re-authenticate user (if necessary)
                    // For security reasons, Firebase requires re-authentication before updating the password
                    // This step may be needed if the user's session has expired or is considered not valid
                    // Uncomment the following lines if re-authentication is required
                    // AuthCredential credential = EmailAuthProvider.credential(email: user!.email!, password: 'current-password');
                    // await user.reauthenticateWithCredential(credential);

                    // Update the user password
                    await usermo!.updatePassword(newpass.text);
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(usermo.uid)
                        .update({'password': newpass.text});
                  }
                  newpass.clear();
                  prevpass.clear();

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PasswordUpdated()));
                },
                child: Text('RESET PASSWORD'),
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
          ],
        ),
      ),
    );
  }

  void toggleview() {
    if (hidenpassword == true) {
      hidenpassword = false;
    } else {
      hidenpassword = true;
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
