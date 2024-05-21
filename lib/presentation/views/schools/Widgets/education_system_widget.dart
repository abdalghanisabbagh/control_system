import 'package:flutter/material.dart';

class EducationSystemWidget extends StatelessWidget {
  bool? selectedscool;

  EducationSystemWidget({super.key, required this.selectedscool});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                selectedscool == null
                    ? "Education system "
                    : "Education system (${selectedscool!})",
              ),
              const Spacer(),
            ],
          )
        ],
      ),
    );
  }
}
