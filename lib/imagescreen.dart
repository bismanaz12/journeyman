import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FullScreenImage extends StatelessWidget {
  final String image;

  FullScreenImage({required this.image});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            color: Colors.black.withOpacity(0.5),
          ),
        ),
        Center(
          child: Image.asset(image),
        ),
      ],
    );
  }
}
