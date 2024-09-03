import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final String text;

  const HeaderWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        children: [
          FittedBox(
            child: Text(text, style: nunitoBold.copyWith(fontSize: 25)),
          ),
        ],
      ),
    );
  }
}
