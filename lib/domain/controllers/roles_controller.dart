import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:multi_dropdown/models/value_item.dart';

import '../../Data/Models/user/roles/role_res_model.dart';
import '../../Data/Models/user/roles/roleres_model.dart';
import '../../Data/Models/user/screens/screen_res_model.dart';
import '../../Data/Models/user/screens/screens_res_model.dart';
import '../../Data/Network/response_handler.dart';
import '../../Data/Network/tools/failure_model.dart';
import '../../Data/enums/req_type_enum.dart';
import '../../app/configurations/app_links.dart';
import '../../presentation/resource_manager/ReusableWidget/show_dialgue.dart';

class RolesController extends GetxController {
  final searchRolesController = TextEditingController();
  final searchScreensController = TextEditingController();
  final searchWidgetsController = TextEditingController();

  bool addLoading = false;
  bool connectLoading = false;
  bool deleteScreenLoading = false;
  bool getAllLoading = false;
  // final ScrollController rolesScrollController = ScrollController();
  //final ScrollController screensScrollController = ScrollController();
  List<int> removedSreensIds = [];
  List<int> selectedSreensIds = [];
  List<RoleResModel> rolesList = [];
  List<ScreenResModel> allScreens = [];
  List<ScreenResModel> widgets = [];

  List<ScreenResModel> filteredScreens = [];
  List<ScreenResModel> filteredWidgets = [];
  List<RoleResModel> filteredRoles = [];
  List<int> includedActions = [];
  // List<ScreenResModel> resultFilteredScreens = [];
  List<ScreenResModel> resultFilteredWidgets = [];

  int? selectedRoleId;
  int? selectedScreenId;
  String? lastSelectedFrontId;

  // void filterScreens(List<ScreenResModel> myScreens) {
  //   //  List<ScreenResModel> myScreen = [];
  //   RegExp regex = RegExp(r'000');

  //   filteredScreens.assignAll(
  //     allScreens.where((screen) => regex.hasMatch(screen.frontId)).toList(),
  //   );
  //   // myScreen.assignAll(
  //   //   myScreens.where((screen) => regex.hasMatch(screen.frontId)).toList(),
  //   // );
  //   resultFilteredScreens = filteredScreens;
  //   update();
  // }

  void searchWithinFilteredScreens(String query) {
    var screens =
        allScreens.where((screen) => screen.frontId.contains("000")).toList();
    if (query.isEmpty) {
      filteredScreens = screens;
    } else {
      filteredScreens = screens.where((screen) {
        return screen.name.toLowerCase().contains(query.toLowerCase()) ||
            screen.frontId.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }

    update();
  }

  void serachInRoles(String query) {
    if (query.isEmpty) {
      filteredRoles = rolesList;
    } else {
      filteredRoles = rolesList.where((role) {
        return role.name?.toLowerCase().contains(query.toLowerCase()) ?? false;
      }).toList();
    }
    update();
  }

  void filterWidgets() {
    int id = int.parse(lastSelectedFrontId!);
    widgets = allScreens.where((screen) {
      int screenFrontId = int.parse(screen.frontId);
      return screenFrontId >= id && screenFrontId < id + 1000;
    }).toList();
    includedActions = filteredRoles
        .firstWhereOrNull((role) => role.id == selectedRoleId)!
        .screens!
        .map((screen) => screen.id)
        .where((action) => widgets.map((widget) => widget.id).contains(action))
        .toList();

    resultFilteredWidgets = widgets;
    update();
  }

  void searchWithinFilteredWidgets(String query) {
    if (query.isEmpty) {
      widgets = resultFilteredWidgets;
    } else {
      widgets = widgets.where((widget) {
        return widget.name.toLowerCase().contains(query.toLowerCase()) ||
            widget.frontId.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }

    update();
  }

  void setSelectedRole(int roleId) {
    selectedRoleId = roleId;
    update();
  }

  void setSelectedScreen(int screenId) {
    selectedScreenId = screenId;
    update();
  }

  Future<bool> addNewRoles({
    required String name,
  }) async {
    addLoading = true;
    update();
    bool screenHasBeenAdded = false;
    ResponseHandler<RoleResModel> responseHandler = ResponseHandler();
    Either<Failure, RoleResModel> response = await responseHandler.getResponse(
      path: UserRolesSystemsLink.userRolesSystems,
      converter: RoleResModel.fromJson,
      type: ReqTypeEnum.POST,
      body: {
        "Name": name,
      },
    );
    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
        screenHasBeenAdded = false;
      },
      (r) {
        onInit();
        screenHasBeenAdded = true;
        update();
      },
    );
    addLoading = false;
    update();
    return screenHasBeenAdded;
  }

  Future<bool> addNewScreen({
    required String name,
    required String frontId,
  }) async {
    addLoading = true;
    update();
    bool screenHasBeenAdded = false;
    ResponseHandler<ScreenResModel> responseHandler = ResponseHandler();
    Either<Failure, ScreenResModel> response =
        await responseHandler.getResponse(
      path: UserRolesSystemsLink.screen,
      converter: ScreenResModel.fromJson,
      type: ReqTypeEnum.POST,
      body: {
        "Name": name,
        "Front_Id": frontId,
      },
    );
    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
        screenHasBeenAdded = false;
      },
      (r) {
        getAllScreens();
        screenHasBeenAdded = true;
        update();
      },
    );
    addLoading = false;
    update();
    return screenHasBeenAdded;
  }

  Future<bool> addScreensToRole() async {
    connectLoading = true;
    update();
    bool screenHasBeenAdded = false;
    ResponseHandler<void> responseHandler = ResponseHandler();
    Either<Failure, void> response = await responseHandler.getResponse(
      path:
          '${UserRolesSystemsLink.userRolesSystemsConnectRolesToScreens}/$selectedRoleId',
      converter: (_) {},
      type: ReqTypeEnum.PATCH,
      body: selectedSreensIds,
    );
    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
        screenHasBeenAdded = false;
      },
      (r) {
        screenHasBeenAdded = true;
        update();
      },
    );
    connectLoading = false;
    selectedSreensIds.clear();

    onInit();
    update();
    return screenHasBeenAdded;
  }

  Future<bool> deleteScreensFromRole() async {
    deleteScreenLoading = true;
    update();
    bool screenHasBeenRemoved = false;
    ResponseHandler<void> responseHandler = ResponseHandler();
    Either<Failure, void> response = await responseHandler.getResponse(
      path:
          '${UserRolesSystemsLink.userRolesSystemsDisconnectRolesFromScreens}/$selectedRoleId',
      converter: (_) {},
      type: ReqTypeEnum.PATCH,
      body: removedSreensIds,
    );
    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
        screenHasBeenRemoved = false;
      },
      (r) {
        onInit();
        screenHasBeenRemoved = true;
        update();
      },
    );
    deleteScreenLoading = false;
    removedSreensIds.clear();
    onInit();
    update();
    return screenHasBeenRemoved;
  }

  Future<void> getAllRoles() async {
    ResponseHandler<RolesResModel> responseHandler = ResponseHandler();
    Either<Failure, RolesResModel> response = await responseHandler.getResponse(
      path: UserRolesSystemsLink.userRolesSystems,
      converter: RolesResModel.fromJson,
      type: ReqTypeEnum.GET,
    );

    response.fold((l) {
      MyAwesomeDialogue(
        title: 'Error',
        desc: l.message,
        dialogType: DialogType.error,
      ).showDialogue(Get.key.currentContext!);
    }, (r) {
      rolesList = r.data!;
      filteredRoles = rolesList;
      update();
    });
  }

  Future getAllScreens() async {
    ResponseHandler<ScreensResModel> responseHandler = ResponseHandler();
    Either<Failure, ScreensResModel> response =
        await responseHandler.getResponse(
      path: UserRolesSystemsLink.screen,
      converter: ScreensResModel.fromJson,
      type: ReqTypeEnum.GET,
    );
    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
      },
      (r) {
        allScreens = r.data!;

        filteredScreens = allScreens
            .where((screen) => screen.frontId.contains("000"))
            .toList();
      },
    );
  }

  @override
  void onClose() {
    // rolesScrollController.dispose();
    // screensScrollController.dispose();
    super.onClose();
  }

  @override
  void onInit() async {
    super.onInit();

    selectedRoleId;
    selectedScreenId;
    allScreens.clear();
    rolesList.clear();
    widgets.clear();
    filteredScreens.clear();
    filteredRoles.clear();
    selectedSreensIds.clear();

    getAllLoading = true;
    update();

    await Future.wait([getAllScreens(), getAllRoles()]);

    getAllLoading = false;
    update();
  }

  void onOptionSelected(List<ValueItem<dynamic>> selectedOptions) {
    selectedSreensIds =
        selectedOptions.map((e) => e.value as int).toList().cast<int>();
    update();
  }
}
