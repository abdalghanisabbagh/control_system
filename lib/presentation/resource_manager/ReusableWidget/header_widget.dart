import 'package:flutter/material.dart';

import '../index.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        children: [
          Text(text, style: nunitoBoldStyle()),
        ],
      ),
    );
  }
}
