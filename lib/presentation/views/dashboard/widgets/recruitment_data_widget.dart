import 'package:flutter/material.dart';

import '../../../../app/extensions/device_type_extension.dart';
import '../../../resource_manager/assets_manager.dart';
import '../../../resource_manager/index.dart';

class RecruitmentDataWidget extends StatefulWidget {
  const RecruitmentDataWidget({super.key});

  @override
  RecruitmentDataWidgetState createState() => RecruitmentDataWidgetState();
}

class RecruitmentDataWidgetState extends State<RecruitmentDataWidget> {
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
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "All Admin",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ColorManager.black,
                  fontSize: 22,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: ColorManager.bgSideMenu,
                  borderRadius: BorderRadius.circular(100),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                child: Text(
                  "View All",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ColorManager.white,
                  ),
                ),
              )
            ],
          ),
          const Divider(
            thickness: 0.5,
            color: Colors.grey,
          ),
          SingleChildScrollView(
            child: Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                /// Table Header
                TableRow(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey,
                        width: 0.5,
                      ),
                    ),
                  ),
                  children: [
                    tableHeader("Full Name"),
                    if (!context.isMobile) tableHeader("NIS Id"),
                    tableHeader("Status"),
                    if (!context.isMobile) tableHeader(""),
                  ],
                ),

                // ...List.generate(
                //   userController.dashboardUsers.length,
                //   (index) => tableRow(
                //     context,
                //     name: userController.dashboardUsers[index].userFullName,
                //     color: userController.dashboardUsers[index].active == 1
                //         ? Colors.green
                //         : Colors.red,
                //     //image: "assets/user1.jpg",
                //     designation: userController.dashboardUsers[index].nISID,
                //     status: userController.dashboardUsers[index].active == 1
                //         ? "Active"
                //         : "Disable",
                //   ),
                // )
              ],
            ),
          ),
        ],
      ),
    );
  }

  TableRow tableRow(context, {name, image, designation, status, color}) {
    return TableRow(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 0.5,
          ),
        ),
      ),
      children: [
        //Full Name
        Container(
          margin: const EdgeInsets.symmetric(vertical: 15),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(1000),
                child: Icon(
                  Icons.person,
                  color: ColorManager.bgSideMenu,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(name)
            ],
          ),
        ),
        // Designation
        if (!context.isMobile) Text(designation),
        //Status
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
              ),
              height: 10,
              width: 10,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(status),
          ],
        ),
        // Menu icon
        if (!context.isMobile)
          Image.asset(
            AssetsManager.assetsIconsMore,
            color: Colors.grey,
            height: 30,
          )
      ],
    );
  }

  Widget tableHeader(text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: Text(
        text,
        style: const TextStyle(
            fontWeight: FontWeight.bold, color: ColorManager.black),
      ),
    );
  }
}
