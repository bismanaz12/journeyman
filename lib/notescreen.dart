import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Screenover extends StatelessWidget {
  Screenover({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var hiddenpass = false;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              maxLength: 600,
              // controller:
              // controller,
              // obscureText: hiddenpass,
              // controller: pass,
              decoration: InputDecoration(
                  focusColor: Colors.white,
                  constraints: BoxConstraints(
                    maxWidth: 400,
                    maxHeight: 80,
                  ),
                  filled: false,
                  enabledBorder: OutlineInputBorder(
                    // borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    // borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  // suffixIcon: InkWell(
                  //     // onTap: toggleview,
                  //     child:
                  //         // hiddenpass
                  //         //     ? Icon(
                  //         //         Icons.remove_red_eye,
                  //         //         color: Colors.black,
                  //         //       )
                  //         Icon(
                  //   Icons.visibility_off,
                  //   color: Colors.black,
                  // )),
                  // prefixIcon: Icon(
                  //   Icons.https_outlined,
                  //   color: Colors.black,
                  // ),
                  hintText: '...note',
                  hintStyle: TextStyle(color: Colors.grey)),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                'Add Note',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(300, 46),
                foregroundColor: Colors.white,
                backgroundColor: Color(0xff6982ed),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
