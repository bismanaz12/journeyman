import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mechanic_app/settingfunctions.dart';

class Setting_Screen extends StatelessWidget {
  const Setting_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(child: Text('Settings')),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
                    style: TextStyle(fontSize: 12),
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
                onPressed: () {},
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
      ),
    );
  }
}
