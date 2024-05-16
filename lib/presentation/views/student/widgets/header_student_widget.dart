import 'package:control_system/app/extensions/device_type_extension.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../base_screen.dart';

class HeaderStudentWidget extends StatelessWidget {
  const HeaderStudentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Row(
          children: [
            if (context.isDesktop) ...{
              const Spacer(),
              IconButton(
                tooltip: "Promot Students From Excel",
                icon: const Icon(FontAwesomeIcons.arrowUpFromGroundWater),
                onPressed: () {
                  // controller.promotFromExcel();
                },
              ),
              IconButton(
                tooltip: "Download excel template",
                icon: const Icon(FontAwesomeIcons.cloudArrowDown),
                onPressed: () {
                  // controller.downloadeTemp();
                },
              ),
              IconButton(
                tooltip: "Import From Excel",
                icon: const Icon(FontAwesomeIcons.fileExcel),
                onPressed: () {
                  // controller.importExcel();
                },
              ),
              IconButton(
                tooltip: "Add New Student",
                icon: const Icon(FontAwesomeIcons.userPlus),
                onPressed: () {
                  // MyDialogs.showAddDialog(context, AddSinglStudent());
                },
              ),
              IconButton(
                tooltip: "Sync Students",
                icon: const Icon(FontAwesomeIcons.rotate),
                onPressed: () {
                  // controller.getStudenFromServer();
                },
              ),
              IconButton(
                tooltip: "Send To DataBase",
                icon: const Icon(Icons.send),
                onPressed: () {
                  // controller.sendStudenToServer(controller.students);
                },
              ),
            }
          ],
        ),
      ),
    );
  }
}
