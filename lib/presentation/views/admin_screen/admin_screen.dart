import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:control_system/presentation/views/admin_screen/widgets/add_role_user.dart';
import 'package:control_system/presentation/views/admin_screen/widgets/edit_user_widget.dart';
import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:searchable_listview/searchable_listview.dart';

import '../../../Data/Models/user/users_res/user_res_model.dart';
import '../../../domain/controllers/admin_controller.dart';
import '../../../domain/controllers/profile_controller.dart';
import '../../resource_manager/ReusableWidget/app_dialogs.dart';
import '../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../resource_manager/ReusableWidget/show_dialgue.dart';
import '../../resource_manager/routes/app_routes_names_and_paths.dart';
import '../base_screen.dart';
import 'widgets/add_new_user_widget.dart';

class AdminScreen extends GetView<AdminController> {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      key: key,
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Admin",
                  style: nunitoBold.copyWith(
                    color: ColorManager.bgSideMenu,
                    fontSize: 35,
                  ),
                ),
                const Spacer(),
                Visibility(
                  visible: Get.find<ProfileController>().canAccessWidget(
                    widgetId: '9100',
                  ),
                  child: Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        controller.getAllUsers();
                        context
                            .goNamed(AppRoutesNamesAndPaths.allUsersScreenName);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: ColorManager.bgSideMenu,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              "All Users",
                              style: nunitoBold.copyWith(
                                color: ColorManager.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.005,
                ),
                Visibility(
                  visible: Get.find<ProfileController>().canAccessWidget(
                    widgetId: '9200',
                  ),
                  child: Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        controller.getUserInSchool();
                        context.goNamed(
                            AppRoutesNamesAndPaths.usersInSchoolScreenName);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: ColorManager.newStatus,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              "Users in School",
                              style: nunitoBold.copyWith(
                                color: ColorManager.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.005,
                ),
                Visibility(
                  visible: Get.find<ProfileController>().canAccessWidget(
                    widgetId: '9300',
                  ),
                  child: Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        MyDialogs.showDialog(
                          context,
                          const AddNewUserWidget(),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: ColorManager.glodenColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              "Add New User",
                              style: nunitoBold.copyWith(
                                color: ColorManager.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            GetBuilder<AdminController>(builder: (_) {
              return Expanded(
                child: controller.isLoadingGetUsersCreatedBy
                    ? Center(
                        child: LoadingIndicators.getLoadingIndicator(),
                      )
                    : controller.userCreatedList.isEmpty
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
                            initialList: controller.userCreatedList,
                            emptyWidget: Center(
                              child: Text(
                                "No data found",
                                style: nunitoBold.copyWith(
                                  color: ColorManager.bgSideMenu,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            filter: (value) => controller.userCreatedList
                                .where((element) => element.fullName!
                                    .toLowerCase()
                                    .contains(value.toLowerCase()))
                                .toList(),
                            itemBuilder: (UserResModel item) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: Card(
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
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
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      item.fullName ??
                                                          "Unknown",
                                                      style:
                                                          nunitoBold.copyWith(
                                                        color: ColorManager
                                                            .bgSideMenu,
                                                        fontSize: 22,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Flexible(
                                                    child: Text(
                                                      "Roles: ${item.userHasRoles?.roles?.isNotEmpty == true ? item.userHasRoles?.roles?.join(", ") : "User has no roles"} - ${item.roleType ?? "Unknown"}",
                                                      style: nunitoRegular
                                                          .copyWith(
                                                        color: ColorManager
                                                            .bgSideMenu
                                                            .withOpacity(0.7),
                                                        fontSize: 16,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 5),
                                              Row(
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      "Created At: ${DateFormat("dd-MM-yyyy HH:mm").format(DateTime.parse(item.createdAt!))}",
                                                      style: nunitoRegular
                                                          .copyWith(
                                                        color: ColorManager
                                                            .bgSideMenu
                                                            .withOpacity(0.7),
                                                        fontSize: 16,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Visibility(
                                          visible: Get.find<ProfileController>()
                                              .canAccessWidget(
                                                  widgetId: '9600'),                                          child: IconButton(
                                            icon: Icon(Icons.add,
                                                color:
                                                    ColorManager.glodenColor),
                                            onPressed: () {
                                              MyDialogs.showDialog(
                                                context,
                                                AddRoleUser(
                                                  userResModel: item,
                                                ),
                                              );
                                              controller.getAllRoles(
                                                  userResModel: item);
                                            },
                                          ),
                                        ),
                                        Visibility(
                                          visible: Get.find<ProfileController>()
                                              .canAccessWidget(
                                                  widgetId: '9400'),
                                          child: IconButton(
                                            icon: Icon(Icons.edit,
                                                color:
                                                    ColorManager.glodenColor),
                                            onPressed: () {
                                              MyDialogs.showDialog(
                                                context,
                                                EditUserWidget(
                                                  userResModel: item,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        Visibility(
                                          visible: Get.find<ProfileController>()
                                              .canAccessWidget(
                                                  widgetId: '9500'),
                                          child: IconButton(
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
          ],
        ),
      ),
    );
  }
}
