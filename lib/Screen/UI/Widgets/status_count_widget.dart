import 'package:flutter/material.dart';
import '../../../Style/color_style.dart';
import '../../../Style/text_message_style.dart';

class StatusCountWidget extends StatelessWidget {
  const StatusCountWidget(
      {super.key, required this.count, required this.title});

  final String count;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          1,
          (index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Card(
              color: colorGrey,
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      count,
                      style: head1Text(colorBlack),
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    Text(
                      title,
                      style: head6Text(colorLightBlack),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
