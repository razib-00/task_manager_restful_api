import 'package:flutter/material.dart';
import '../Style/color_style.dart';

class BackgroundColorListScreen extends StatelessWidget {
  const BackgroundColorListScreen({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: backgroundColorsList)
          ),
        ),
          child,
        ],
      ),
    );
  }
}
