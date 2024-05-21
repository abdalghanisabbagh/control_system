import 'package:flutter/material.dart';

class GradeSystemWidget extends StatelessWidget {
  final bool? selectedscool;

  const GradeSystemWidget({super.key, required this.selectedscool});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
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
