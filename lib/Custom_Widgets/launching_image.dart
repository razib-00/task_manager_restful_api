import 'package:flutter/material.dart';


class LaunchingBackgroundImageScreen extends StatelessWidget {
  const LaunchingBackgroundImageScreen({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(
              'assets/image/launching.jpg',
              fit: BoxFit.cover,
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,
            ),
            child,
          ],
        ),
      ),
    );
  }
}
