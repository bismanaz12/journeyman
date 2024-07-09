import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Enable_Buttom extends StatelessWidget {
  Enable_Buttom({
    super.key,
    required this.text,
  });
  bool value1 = false;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(fontSize: 18),
        ),
        Switch(
            value: value1,
            onChanged: (value) {
              value1 = value;
            }),
      ],
    );
  }
}
