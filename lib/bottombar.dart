import 'package:flutter/material.dart';
import 'package:mechanic_app/customertask.dart';
import 'package:mechanic_app/homescreen.dart';
import 'package:mechanic_app/tasksdetail.dart';

class BottomBar extends StatefulWidget {
  BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  PageController controller = PageController();

  void onPageChanged(index) {
    setState(() {
      currentIndex = index;
    });
  }

  int currentIndex = 0;

  void ontap(int index) {
    if (index == 2) {
      // Open the camera here
      // For example, navigate to the camera screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              CameraScreen(), // Replace with your Camera screen widget
        ),
      );
    } else {
      controller.jumpToPage(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        onPageChanged: onPageChanged,
        controller: controller,
        children: [
          Home_Screen(),
          CusomterTask(),
          Scaffold(
            body: Center(child: Text('hello')),
          ),
          Scaffold(
            body: Center(child: Text('hello')),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: ontap,
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Task'),
          BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                color: currentIndex == 2 ? Colors.blue : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.camera_alt_outlined,
                color: currentIndex == 2 ? Colors.white : Colors.grey,
              ),
              padding: EdgeInsets.all(8),
            ),
            label: 'Camera',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class CameraScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera Screen'),
      ),
      body: Center(
        child: Text('This is the camera screen'),
      ),
    );
  }
}
