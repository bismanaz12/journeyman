import 'package:flutter/material.dart';

class PrivacyScreen extends StatefulWidget {
  PrivacyScreen({super.key});

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  bool value1 = false;
  bool value2 = true;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: media.size.height * 0.06,
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
                'Security & Privacy',
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
          padding: EdgeInsets.symmetric(
              horizontal: media.size.height * 0.03,
              vertical: media.size.height * 0.02),
          width: double.infinity,
          color: Color.fromARGB(255, 235, 234, 234),
          child: Column(
            children: [
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: media.size.height * 0.02),
                height: media.size.height * 0.4,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(255, 192, 187, 187))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: media.size.height * 0.2 * 1.4,
                          child: Text(
                            'Privacy permission item using 2 line sentences',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: media.size.height * 0.02 * 1.2),
                          ),
                        ),
                        Switch(
                            value: value1,
                            onChanged: (value) {
                              value1 = value;
                            }),
                      ],
                    ),
                    Text(
                      'this is a short discription about small item privacy permission using 2 lines sentences',
                      style: TextStyle(
                          color: Color.fromARGB(255, 180, 176, 176),
                          fontSize: media.size.height * 0.02),
                    ),
                    Divider(
                      color: const Color.fromARGB(255, 192, 187, 187),
                      thickness: media.size.height * 0.002,
                    ),
                    Row(
                      children: [
                        Container(
                          width: media.size.height * 0.2 * 1.4,
                          child: Text(
                            'Privacy permission item using 2 line sentences',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: media.size.height * 0.02 * 1.2),
                          ),
                        ),
                        Switch(
                            value: value2,
                            onChanged: (value) {
                              value2 = value;
                            }),
                      ],
                    ),
                    Text(
                      'this is a short discription about small item privacy permission using 2 lines sentences',
                      style: TextStyle(
                          color: Color.fromARGB(255, 180, 176, 176),
                          fontSize: media.size.height * 0.02),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: media.size.height * 0.03,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Data Protection',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: media.size.height * 0.02 * 1.5),
                ),
              ),
              Text(
                "All you need to do is add your information to create a comprehensive resource that's targeted for your specific customers. You could also use a privacy policy generator instead of a template and work from there.",
                style: TextStyle(
                    color: Color.fromARGB(255, 180, 176, 176),
                    fontSize: media.size.height * 0.02 * 1.3),
              ),
            ],
          )),
    );
  }
}
