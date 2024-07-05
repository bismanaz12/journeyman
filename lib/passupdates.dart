import 'package:flutter/material.dart';
import 'package:mechanic_app/login.dart';

class PasswordUpdated extends StatelessWidget {
  const PasswordUpdated({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context);
    return Scaffold(
      // backgroundColor: Colors.white,
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
            Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: media.size.height * 0.08),
                  child: Container(
                    color: Colors.white,
                    width: media.size.height * 0.2,
                    padding: EdgeInsets.only(
                      right: media.size.height * 0.05,
                    ),
                    child: Container(
                      padding: EdgeInsets.only(
                          top: media.size.height * 0.02,
                          bottom: media.size.height * 0.001),
                      height: media.size.height * 0.1 * 1.3,
                      width: media.size.height * 0.07,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 236, 240, 242),
                          borderRadius: BorderRadius.all(
                              Radius.circular(media.size.height * 0.07))),
                      child: Image.asset(
                        'assets/images/mobile.pic.png',
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: media.size.height * 0.1 * 1.5,
                  left: media.size.height * 0.06,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                            Radius.circular(media.size.height * 0.01))),
                    height: media.size.height * 0.05,
                    width: media.size.height * 0.1 * 1.3,
                    child: Row(
                      children: [
                        // Padding(
                        //   padding:
                        //       EdgeInsets.only(left: media.size.height * 0.01),
                        //   child: Container(
                        //     height: media.size.height * 0.03 * 1.4,
                        //     child: Image.asset(
                        //       'assets/images/verified.png',
                        //       fit: BoxFit.cover,
                        //     ),
                        //   ),
                        // ),
                        Icon(
                          Icons.verified_user,
                          color: Colors.blue,
                          size: media.size.height * 0.03,
                        ),

                        Padding(
                          padding:
                              EdgeInsets.only(left: media.size.height * 0.01),
                          child: Icon(
                            Icons.star,
                            color: Colors.black,
                            size: media.size.height * 0.01 * 1.3,
                          ),
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.black,
                          size: media.size.height * 0.01 * 1.3,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.black,
                          size: media.size.height * 0.01 * 1.3,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.black,
                          size: media.size.height * 0.01 * 1.3,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: media.size.height * 0.04),
              child: Text(
                'Password Updated!',
                style: TextStyle(
                    color: Color.fromARGB(255, 39, 36, 36),
                    fontFamily: 'Font',
                    fontSize: media.size.height * 0.02 * 1.3),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: media.size.height * 0.01 * 1.3),
              child: Center(
                child: Text(
                  'Your password has been updated \n               successfully',
                  style: TextStyle(
                      color: Color.fromARGB(255, 182, 177, 177),
                      // fontFamily: 'Font',
                      fontSize: media.size.height * 0.02),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: media.size.height * 0.4),
              child: ElevatedButton(
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Login_Screen_2()));
                },
                child: Text('BACK TO LOGIN'),
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
}
