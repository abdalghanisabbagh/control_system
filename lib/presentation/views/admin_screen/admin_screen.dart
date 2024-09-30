import 'package:control_system/presentation/views/admin_screen/widgets/add_reader_user_widget%20.dart';
import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/controllers/admin_controller.dart';
import '../../../domain/controllers/profile_controller.dart';
import '../../resource_manager/ReusableWidget/app_dialogs.dart';
import '../../resource_manager/routes/app_routes_names_and_paths.dart';
import '../base_screen.dart';
import 'widgets/add_new_user_widget.dart';
import 'widgets/admin_widget.dart';

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
                          const AddReaderUserWidget(),
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
                              "Create Reader",
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
            const AdminWidget(),
          ],
        ),
      ),
    );
  }
}
