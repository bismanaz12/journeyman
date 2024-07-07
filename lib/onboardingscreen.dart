import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:mechanic_app/login.dart';
import 'package:mechanic_app/onboardingfunction.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _Sign_Up_ScreenState();
}

class _Sign_Up_ScreenState extends State<Onboarding> {
  int _currentIndex = 0; // Track current page index
  final PageController _controller = PageController(initialPage: 0);

  // @override
  // void initState() {
  //   super.initState();
  //   _controller = PageController(initialPage: 0);
  // }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/whitebackground.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: _mediaQuery.size.height * .09,
                      width: _mediaQuery.size.width * .20,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/Garage Logo.jpg'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: _mediaQuery.size.width * .05,
                    ),
                    Text(
                      'Hamza\'s Garage',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        // fontFamily: 'pr'
                      ),
                    ),
                  ],
                ),
                // SizedBox(
                //   height: _mediaQuery.size.height * .02,
                // ),
                Expanded(
                  child: PageView.builder(
                    controller: _controller,
                    itemCount: contents.length,
                    onPageChanged: (int index) {
                      setState(() {
                        _currentIndex = index; // Update current index
                      });
                    },
                    itemBuilder: (_, i) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Image(
                              image: AssetImage(contents[i].image),
                              height: 500,
                            )
                            // SvgPicture.asset(
                            //   contents[i].image,
                            //   height: 300,
                            // ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    contents.length,
                    (index) => Container(
                      margin: EdgeInsets.symmetric(horizontal: 3),
                      height: 10,
                      width: _currentIndex == index ? 25 : 10,
                      decoration: BoxDecoration(
                        color: _currentIndex == index
                            ? Color(0xff6982ed)
                            : Color(0xff6982ed),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_currentIndex == contents.length - 1) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Login_Screen_2(),
                          ),
                        );
                      } else {
                        _controller.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      }
                    },
                    child: Text(
                      _currentIndex == contents.length - 1
                          ? 'Continue'
                          : 'Next',
                      style: TextStyle(fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(300, 50),
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
        ),
      ),
    );
  }
}
