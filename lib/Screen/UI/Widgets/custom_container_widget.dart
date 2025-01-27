import 'package:flutter/material.dart';

import '../../../Style/color_style.dart';

class CustomContainerWidget extends StatelessWidget {
  const CustomContainerWidget({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.4,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: colorGrey,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(50),
            topLeft: Radius.circular(50),
          ),
        ),
        child: Listener(child: child),
        ),
      );
  }
}
