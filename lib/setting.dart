import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mechanic_app/forgot.dart';
import 'package:mechanic_app/newpassword.dart';
import 'package:mechanic_app/settingfunctions.dart';

class Setting_Screen extends StatelessWidget {
  const Setting_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: media.size.height * 0.07,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
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
              padding: EdgeInsets.only(left: media.size.height * 0.1 * 1.2),
              child: Text(
                'Settings',
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
        color: Color.fromARGB(255, 235, 234, 234),
        padding: EdgeInsets.symmetric(
            horizontal: media.size.height * 0.03,
            vertical: media.size.height * 0.02),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Enable_Buttom(
              text: 'Enable Notification',
            ),
            Divider(),
            SizedBox(
              height: 10,
            ),
            Enable_Buttom(text: 'Show Password'),
            Divider(),
            SizedBox(
              height: 10,
            ),
            Enable_Buttom(text: 'Turn off camera when start a\n vedio call'),
            Divider(),
            SizedBox(
              height: 10,
            ),
            Text(
              'Setting item list 01',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              height: 10,
            ),
            // Text('Setting item list 01'),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.radio_button_checked,
                  color: Colors.blue,
                  size: 30,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Option 01',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            Divider(),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'App Version',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  '1.0.1.9 (27)',
                  style: TextStyle(
                      fontSize: media.size.height * 0.01 * 1.5,
                      color: Color.fromARGB(255, 166, 164, 164)),
                ),
              ],
            ),
            Divider(),
            SizedBox(
              height: 10,
            ),
            Text(
              'Password',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'you can reset your passsword if you want or using pin ',
              style: TextStyle(fontSize: 13),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        backgroundColor: Colors.white,
                        child: Container(
                          color: Colors.white,
                          height: media.size.height * 0.2,
                          width: media.size.height * 0.1,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: media.size.height * 0.03),
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
                                        fontSize: media.size.height * 0.02),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: media.size.height * 0.03),
                                child: Divider(
                                  color: Colors.grey,
                                  thickness: media.size.height * 0.002,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: media.size.height * 0.03),
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
                                        fontSize: media.size.height * 0.02),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              },

              // onPressed: () async {
              //   if (email.text.isNotEmpty && pass.text.isNotEmpty) {
              //     FirebaseAuth auth = FirebaseAuth.instance;
              //     UserCredential user =
              //         await auth.signInWithEmailAndPassword(
              //             email: email.text, password: pass.text);
              //     if (user.user != null) {
              //       email.clear();
              //       pass.clear();
              //       // Get.to(() => PasswordUpdated(),
              //       //     duration: Duration(seconds: 2));
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => ChangePasswordScreen()));
              //     }
              //   }
              // },
              child: Text(
                'Reset Password',
                style: TextStyle(fontSize: 20),
              ),
              style: ElevatedButton.styleFrom(
                side: BorderSide(color: Colors.blue, width: 1.5),
                fixedSize: const Size(200, 46),
                foregroundColor: Color(0xff6982ed),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
