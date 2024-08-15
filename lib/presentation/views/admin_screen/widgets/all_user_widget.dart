import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:control_system/presentation/views/admin_screen/widgets/add_role_user.dart';
import 'package:control_system/presentation/views/admin_screen/widgets/edit_user_widget.dart';
import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:searchable_listview/searchable_listview.dart';
import '../../../../Data/Models/user/users_res/user_res_model.dart';
import '../../../../domain/controllers/controllers.dart';
import '../../../resource_manager/ReusableWidget/app_dialogs.dart';
import '../../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../../resource_manager/ReusableWidget/my_back_button.dart';
import '../../../resource_manager/ReusableWidget/show_dialgue.dart';

class AllUserWidget extends GetView<AdminController> {
  const AllUserWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              MyBackButton(
                onPressed: () {},
              ),
              Expanded(
                child: Center(
                  child: Text(
                    "All Users",
                    style: nunitoBold.copyWith(
                      color: ColorManager.bgSideMenu,
                      fontSize: 35,
                    ),
                  ),
                ),
              )
            ],
          ),
          GetBuilder<AdminController>(builder: (_) {
            return Expanded(
              child: controller.isLoadingGetAllUsers
                  ? Center(
                      child: LoadingIndicators.getLoadingIndicator(),
                    )
                  : controller.allUsersList.isEmpty
                      ? Center(
                          child: Text(
                            "No Users Found",
                            style: nunitoBold.copyWith(
                              color: ColorManager.bgSideMenu,
                              fontSize: 35,
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: SearchableList<UserResModel>(
                            initialList: controller.allUsersList,
                            emptyWidget: Center(
                              child: Text(
                                "No data found",
                                style: nunitoBold.copyWith(
                                  color: ColorManager.bgSideMenu,
                                  fontSize: 35,
                                ),
                              ),
                            ),
                            filter: (value) => controller.allUsersList
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
                                          radius: 25,
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
                                                      style: nunitoBold.copyWith(
                                                          color: ColorManager
                                                              .bgSideMenu,
                                                          fontSize: 20),
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
                                                                  .withOpacity(
                                                                      0.7),
                                                              fontSize: 20),
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
                                                                  .withOpacity(
                                                                      0.7),
                                                              fontSize: 20),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Flexible(
                                                    child: Text(
                                                      "Created by: ${item.createdByUserResModel?.fullName ?? "Unknown"}",
                                                      style: nunitoRegular
                                                          .copyWith(
                                                              color: ColorManager
                                                                  .bgSideMenu
                                                                  .withOpacity(
                                                                      0.7),
                                                              fontSize: 20),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.add,
                                              color: ColorManager.glodenColor),
                                          onPressed: () {
                                            MyDialogs.showDialog(
                                              context,
                                              AddRoleUser(
                                                userResModel: item,
                                              ),
                                            );
                                            controller.getAllRoles(
                                              userResModel: item,
                                            );
                                          },
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
                                                    userResModel: item),
                                              );
                                            },
                                          ),
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
                                              btnOkOnPressed: () {},
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
                        ),
            );
          }),
        ],
      ),
    );
  }
}
