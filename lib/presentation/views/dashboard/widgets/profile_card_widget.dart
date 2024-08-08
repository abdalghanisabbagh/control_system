import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';

class ProfileCardWidget extends StatelessWidget {
  const ProfileCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 20,
            offset: const Offset(2, 15), // changes position of shadow
          ),
        ],
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(1000),
                child: const Icon(
                  Icons.person,
                ),
              ),
              // const SizedBox(width: 10),
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Text(
              //       userController.user == null
              //           ? ""
              //           : controller.user!.userName,
              //       style: const TextStyle(fontWeight: FontWeight.bold),
              //     ),
              //     const Text("Super Admin"),
              //   ],
              // )
            ],
          ),
          const Divider(
            thickness: 0.5,
            color: Colors.grey,
          ),
          // profileListTile(
          //     "Joined Date",
          //     userController.user == null
          //         ? ""
          //         : DateFormat('EEEE, MMM d, yyyy').format(
          //             DateTime.parse(
          //                 userController.user!.createdDate))),
          profileListTile("Role", "Admin"),
        ],
      ),
    );
  }

  Widget profileListTile(text, value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: ColorManager.black,
            ),
          ),
        ],
      ),
    );
  }
}
