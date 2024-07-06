import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mechanic_app/editprofile.dart';
import 'package:mechanic_app/login.dart';
import 'package:mechanic_app/profilelist.dart';

class TechnicianProfile extends StatefulWidget {
  const TechnicianProfile({super.key});

  @override
  State<TechnicianProfile> createState() => _TechnicianProfileState();
}

class _TechnicianProfileState extends State<TechnicianProfile> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
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
              padding: EdgeInsets.only(left: media.size.height * 0.1 * 1.3),
              child: Text(
                'Profile',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: media.size.height * 0.1 * 1.4),
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Editprofile()));
                },
                child: Container(
                    height: media.size.height * 0.03,
                    width: media.size.height * 0.03,
                    decoration: BoxDecoration(),
                    child: Image.asset(
                      'assets/images/edit.png',
                      fit: BoxFit.cover,
                    )),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: media.size.height * 0.02),
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: media.size.height * 0.08),
                    child: Text(
                      '12th',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: media.size.height * 0.01 * 1.8),
                    ),
                  ),
                  Container(
                    height: media.size.height * 0.03,
                    child: Image.asset(
                      'assets/images/position.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/picture.jpeg'),
                      radius: media.size.height * 0.03 * 1.8,
                    ),
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.amber[700],
                  ),
                  Text(
                    '4.7',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: media.size.height * 0.01 * 1.8),
                  )
                ],
              ),
              Text(
                'Name',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: media.size.height * 0.02,
                    fontWeight: FontWeight.w500),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'ID:#00345',
                    style: TextStyle(
                        color: Color.fromARGB(255, 202, 195, 195),
                        fontSize: media.size.height * 0.01 * 1.6,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    ' * HVAC Technician',
                    style: TextStyle(
                        color: Color.fromARGB(255, 202, 195, 195),
                        fontSize: media.size.height * 0.01 * 1.6,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(
                height: media.size.height * 0.1,
              ),
              ProfileList(
                  icon: Icons.account_balance_wallet_outlined,
                  text: 'My Balance',
                  text2: '\$1,560',
                  icon2: Icons.arrow_forward_ios_outlined),
              ProfileList(
                  icon: Icons.leaderboard,
                  text: 'Leaderboard',
                  text2: '\$1,490',
                  icon2: Icons.arrow_forward_ios_outlined),
              ProfileList(
                  icon: Icons.settings,
                  text: 'Settings',
                  text2: '',
                  icon2: Icons.arrow_forward_ios_outlined),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: media.size.height * 0.02),
                    child: Row(
                      children: [
                        Icon(
                          Icons.compare_outlined,
                          color: Colors.black,
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(left: media.size.height * 0.02),
                          child: Expanded(
                            child: Container(
                              width: media.size.height * 0.1 * 1.5,
                              child: Text(
                                'Dark mode',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: media.size.height * 0.02 * 1.3,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(left: media.size.height * 0.04),
                          child: Expanded(
                            child: Container(
                              width: media.size.height * 0.07,
                              child: Text(
                                '',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 211, 205, 205),
                                    fontSize: media.size.height * 0.02),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(left: media.size.height * 0.03),
                          child: Switch(
                              activeTrackColor:
                                  Color.fromARGB(255, 211, 205, 205),
                              inactiveTrackColor:
                                  Color.fromARGB(255, 211, 205, 205),
                              value: value,
                              onChanged: (value) {
                                value = value;
                                setState(() {});
                              }),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: media.size.height * 0.02),
                    child: Divider(
                      color: Color.fromARGB(255, 211, 205, 205),
                      thickness: media.size.height * 0.002,
                    ),
                  )
                ],
              ),

              // ProfileList(
              //     icon: Icons.compare_outlined,
              //     text: 'Dark Mode',
              //     text2: '',
              //     icon2: Icons.switch_access_shortcut),

              ProfileList(
                  icon: Icons.verified_outlined,
                  text: 'Security and Privicy',
                  text2: '',
                  icon2: Icons.arrow_forward_ios_outlined),
              ProfileList(
                  icon: Icons.account_circle,
                  text: 'About',
                  text2: '',
                  icon2: Icons.arrow_forward_ios_outlined),
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: Container(
                            height: media.size.height * 0.2,
                            width: media.size.height * 0.1,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: media.size.height * 0.02,
                                ),
                                Text(
                                  'Are you sure to logout! ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: media.size.height * 0.02 * 1.2),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: media.size.height * 0.03),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          fixedSize: Size(
                                              media.size.height * 0.2,
                                              media.size.height * 0.03),
                                          // backgroundColor: Color(
                                          //   0xff6982ed,
                                          // ),
                                          shape: RoundedRectangleBorder(
                                              // borderRadius: BorderRadius.all(
                                              //     Radius.circular(
                                              //         media.size.height * 0.03)),
                                              side: BorderSide(
                                            width: media.size.height * 0.001,
                                            color: Color(
                                              0xff6982ed,
                                            ),
                                          ))),
                                      onPressed: () async {
                                        FirebaseAuth auth =
                                            FirebaseAuth.instance;
                                        await auth.signOut();
                                        Navigator.pop(context);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Login_Screen_2()));
                                      },
                                      child: Text(
                                        'Yah',
                                        style: TextStyle(color: Colors.black),
                                      )),
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        fixedSize: Size(media.size.height * 0.2,
                                            media.size.height * 0.03),
                                        // backgroundColor: Color(
                                        //   0xff6982ed,
                                        // ),
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: media.size.height * 0.001,
                                            color: Color(
                                              0xff6982ed,
                                            ),
                                          ),
                                          // borderRadius: BorderRadius.all(
                                          //     Radius.circular(
                                          //         media.size.height *
                                          //             0.03))
                                        )),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'No',
                                      style: TextStyle(color: Colors.black),
                                    )),
                              ],
                            ),
                          ),
                        );
                      });
                },
                child: ProfileList(
                    icon: Icons.logout_outlined,
                    text: 'Logout',
                    text2: '',
                    icon2: Icons.arrow_forward_ios_outlined),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
