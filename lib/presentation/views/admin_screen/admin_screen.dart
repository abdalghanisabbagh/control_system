import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:searchable_listview/searchable_listview.dart';

import '../../../Data/Models/user/users_res/user_res_model.dart';
import '../../../domain/controllers/admin_controller.dart';
import '../../resource_manager/ReusableWidget/app_dialogs.dart';
import '../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../resource_manager/ReusableWidget/show_dialgue.dart';
import '../base_screen.dart';
import 'widgets/add_new_user_widget.dart';

class AdminScreen extends GetView<AdminController> {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      key: key,
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Admin",
                style: nunitoBlack.copyWith(
                  color: ColorManager.bgSideMenu,
                  fontSize: 30,
                ),
              ),
              InkWell(
                onTap: () {
                  MyDialogs.showDialog(
                    context,
                    const AddNewUserWidget(),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorManager.glodenColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "Add New User",
                        style: nunitoBold.copyWith(
                          color: ColorManager.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          GetBuilder<AdminController>(builder: (_) {
            return Expanded(
              child: controller.isLoadingGetUsers
                  ? Center(
                      child: LoadingIndicators.getLoadingIndicator(),
                    )
                  : controller.usersList.isEmpty
                      ? Center(
                          child: Text(
                            "No Users Found",
                            style: nunitoBold.copyWith(
                              color: ColorManager.bgSideMenu,
                              fontSize: 16,
                            ),
                          ),
                        )
                      : SearchableList<UserResModel>(
                          initialList: controller.usersList,
                          emptyWidget: Center(
                            child: Text(
                              "No data found",
                              style: nunitoBold.copyWith(
                                color: ColorManager.bgSideMenu,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          filter: (value) => controller.usersList
                              .where((element) => element.fullName!
                                  .toLowerCase()
                                  .contains(value.toLowerCase()))
                              .toList(),
                          itemBuilder: (UserResModel item) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: Card(
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 30,
                                        backgroundColor:
                                            ColorManager.glodenColor,
                                        child: Text(
                                          item.fullName![0].toUpperCase(),
                                          style: nunitoBold.copyWith(
                                            color: ColorManager.white,
                                            fontSize: 25,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 15),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  item.fullName ?? "Unknown",
                                                  style: nunitoBold.copyWith(
                                                    color:
                                                        ColorManager.bgSideMenu,
                                                    fontSize: 22,
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Text(
                                                  item.userHasRoles?.roles
                                                              ?.isEmpty ==
                                                          null
                                                      ? "User has no roles"
                                                      : item.userHasRoles?.roles
                                                                  ?.isEmpty ==
                                                              true
                                                          ? "User has no roles"
                                                          : "Roles: ${item.userHasRoles?.roles?.join(",")} - ${item.roleType}",
                                                  style: nunitoRegular.copyWith(
                                                    color: ColorManager
                                                        .bgSideMenu
                                                        .withOpacity(0.7),
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 5),
                                            Row(
                                              children: [
                                                Text(
                                                  "Created At: ${DateFormat("dd-MM-yyyy HH:mm").format(DateTime.parse(item.createdAt!))}",
                                                  style: nunitoRegular.copyWith(
                                                    color: ColorManager
                                                        .bgSideMenu
                                                        .withOpacity(0.7),
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Text(
                                                  "Created by: ${item.createdByUserResModel?.fullName ?? "Unknown"}",
                                                  style: nunitoRegular.copyWith(
                                                    color: ColorManager
                                                        .bgSideMenu
                                                        .withOpacity(0.7),
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.edit,
                                            color: ColorManager.glodenColor),
                                        onPressed: () {
                                          // Open edit user dialog
                                          // MyDialogs.showDialog(
                                          //   context,
                                          //   EditUserWidget(user: item),
                                          // );
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete,
                                            color: Colors.red),
                                        onPressed: () {
                                          MyAwesomeDialogue(
                                            title: 'Delete User',
                                            desc:
                                                'Are you sure you want to delete this user?',
                                            dialogType: DialogType.warning,
                                            btnOkOnPressed: () {
                                              // Delete user
                                            },
                                            btnCancelOnPressed: () {
                                              Get.back();
                                            },
                                          ).showDialogue(context);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
            );
          }),
        ]),
      ),
    );
  }
}
