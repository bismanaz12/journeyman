import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Enable_Buttom extends StatelessWidget {
  const Enable_Buttom({
    super.key,
    required this.text,
  });
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
        Icon(Icons.abc_sharp)
      ],
    );
  }
}
