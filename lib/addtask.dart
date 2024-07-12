import 'package:flutter/material.dart';

class AddTasks extends StatelessWidget {
  const AddTasks({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context);
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: Container(),
        ),
        Row(
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(),
                  fixedSize: Size(
                      media.size.height * 0.2 * 1.2, media.size.height * 0.05)),
              onPressed: () {},
              child: Text('Barcode Scan',
                  style: TextStyle(
                      color: Colors.black, fontSize: media.size.height * 0.02)),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(),
                  fixedSize: Size(
                      media.size.height * 0.2 * 1.2, media.size.height * 0.05),
                ),
                onPressed: () {},
                child: Text(
                  'Take a Photo',
                  style: TextStyle(
                      color: Colors.black, fontSize: media.size.height * 0.02),
                ))
          ],
        ),
      ],
    ));
  }
}
