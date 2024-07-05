import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mechanic_app/login.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  void _resetPassword(BuildContext context) async {
    String email = emailController.text.trim();
    if (email.isNotEmpty) {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        // Navigate to a success message or login screen
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login_Screen_2()));
        // Go back to the previous screen (e.g., login screen)
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Password reset email sent! Check your email.'),
          duration: Duration(seconds: 3),
        ));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to send reset email. Please try again later.'),
          duration: Duration(seconds: 3),
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please enter your email.'),
        duration: Duration(seconds: 3),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: media.size.height * 0.03),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: media.size.height * 0.1 * 1.6,
            ),
            Text(
              'Forgot Password',
              style: TextStyle(
                  color: Colors.black, fontSize: media.size.height * 0.03),
            ),
            SizedBox(
              height: media.size.height * 0.3,
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: media.size.height * 0.3),
            ElevatedButton(
              onPressed: () async {
                _resetPassword(context);
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
          ],
        ),
      ),
    );
  }
}
