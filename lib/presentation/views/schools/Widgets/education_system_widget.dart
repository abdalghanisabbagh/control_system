import 'package:flutter/material.dart';

class EducationSystemWidget extends StatelessWidget {
  bool? selectedscool;

  EducationSystemWidget({super.key, required this.selectedscool});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      child: const Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            "Schools",
            style: TextStyle(color: Colors.red),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
