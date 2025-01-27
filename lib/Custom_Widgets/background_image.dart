 import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BackgroundImageScreen extends StatelessWidget {
  const BackgroundImageScreen({super.key,required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SvgPicture.asset('assets/image/screen-back.svg',
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
