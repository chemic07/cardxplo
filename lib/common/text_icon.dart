import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TextIcon extends StatelessWidget {
  final String text;
  final String iconPath;
  final double iconHeight;
  final double fontsize;

  const TextIcon({
    super.key,
    required this.text,
    required this.iconPath,
    required this.fontsize,
    this.iconHeight = 24.0,
  });
  @override
  Widget build(Object context) {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(iconPath, height: iconHeight),
        SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: fontsize),
        ),
      ],
    );
  }
}
