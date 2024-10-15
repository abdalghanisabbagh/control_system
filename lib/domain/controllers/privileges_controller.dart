import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_dropdown/models/value_item.dart';

import '../../Data/Models/user/roles/role_res_model.dart';
import '../../Data/Models/user/roles/roles_res_model.dart';
import '../../Data/Models/user/screens/screen_res_model.dart';
import '../../Data/Models/user/screens/screens_res_model.dart';
import '../../Data/Network/response_handler.dart';
import '../../Data/Network/tools/failure_model.dart';
import '../../Data/enums/req_type_enum.dart';
import '../../app/configurations/app_links.dart';
import '../../presentation/resource_manager/ReusableWidget/show_dialogue.dart';

class PrivilegesController extends GetxController {
  final PageStorageBucket actionsPageStorageBucket = PageStorageBucket();
  final PageStorageKey actionsPageStorageKey =
      const PageStorageKey<String>('actionsPageStorageKey');

  bool addLoading = false;
  bool allActionsIncluded = false;
  List<ScreenResModel> allScreens = [];
  bool connectLoading = false;
  bool deleteScreenLoading = false;
  List<RoleResModel> filteredRoles = [];
  List<ScreenResModel> filteredScreens = [];
  List<ScreenResModel> filteredWidgets = [];
  bool getAllLoading = false;
  List<int> includedActions = [];
  String? lastSelectedFrontId;
  final PageStorageBucket privilegesPageStorageBucket = PageStorageBucket();
  final PageStorageKey privilegesPageStorageKey =
      const PageStorageKey<String>('privilegesPageStorageKey');

  List<int> removedScreensIds = [];
  List<ScreenResModel> resultFilteredWidgets = [];
  List<RoleResModel> rolesList = [];
  final PageStorageBucket screensPageStorageBucket = PageStorageBucket();
  final PageStorageKey screensPageStorageKey =
      const PageStorageKey<String>('screensPageStorageKey');

  final searchRolesController = TextEditingController();
  final searchScreensController = TextEditingController();
  final searchWidgetsController = TextEditingController();
  int? selectedRoleId;
  int? selectedScreenId;
  List<int> selectedScreensIds = [];
  List<ScreenResModel> widgets = [];

  /// Adds a new role to the server and returns a boolean indicating whether the role was added successfully.
  ///
  /// The function takes one parameter [name] which is the name of the role to be added.
  ///
  /// The function will show an error dialog if the response is a failure.
  ///
  /// The function will also update the UI to show that the role has been added to the server.
  ///
  /// The function returns a boolean indicating whether the role was added successfully.
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

  /// Adds a new screen to the server and returns a boolean indicating
  /// whether the screen was added successfully.
  ///
  /// The function takes two parameters: [name] and [frontId].
  ///
  /// The function will show an error dialog with the failure message
  /// if the response is a failure.
  ///
  /// The function will also update the UI to show that the screen has been
  /// added to the server.
  ///
  /// If the response is successful, the function will call [getAllScreens]
  /// to refresh the UI and return true. If the response is a failure, the
  /// function will return false.
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

  /// Adds the selected screens to the selected role and returns a boolean indicating
  /// whether the screens were added successfully.
  ///
  /// The function takes no parameters.
  ///
  /// The function will show an error dialog with the failure message if the response is a failure.
  ///
  /// The function will also update the UI to show that the screens have been added to the role.
  ///
  /// If the response is successful, the function will call [onInit] to refresh the UI and return true. If the response is a failure, the
  /// function will return false.
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
      body: selectedScreensIds,
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

    onInit();
    return screenHasBeenAdded;
  }

  /// Deletes the selected screens from the selected role and returns a boolean indicating
  /// whether the screens were removed successfully.
  ///
  /// The function takes no parameters.
  ///
  /// The function will show an error dialog with the failure message if the response is a failure.
  ///
  /// The function will also update the UI to show that the screens have been removed from the role.
  ///
  /// If the response is successful, the function will call [onInit] to refresh the UI and return true. If the response is a failure, the
  /// function will return false.
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
      body: removedScreensIds,
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
        screenHasBeenRemoved = true;
        update();
      },
    );
    deleteScreenLoading = false;
    removedScreensIds.clear();
    onInit();
    return screenHasBeenRemoved;
  }

  /// Changes the color of each screen in [allScreens] depending on whether it is
  /// included in the selected role or not. If the screen is included in the
  /// selected role and all other screens in the same range (i.e., with the same
  /// first 3 digits in the front ID) are also included, the screen will be
  /// colored green. If the screen is included in the selected role but not all
  /// other screens in the same range are included, the screen will be colored
  /// orange. If the screen is not included in the selected role, the screen will
  /// be colored white.
  void filterColorScreen() {
    for (var screen in allScreens) {
      int screenFrontId = int.parse(screen.frontId);

      var role =
          filteredRoles.firstWhereOrNull((role) => role.id == selectedRoleId);

      if (role != null) {
        List<ScreenResModel> matchingActions =
            role.screens!.where((roleScreen) {
          int roleScreenFrontId = int.parse(roleScreen.frontId);
          return roleScreenFrontId >= screenFrontId &&
              roleScreenFrontId < screenFrontId + 1000 &&
              allScreens.any(
                  (screen) => int.parse(screen.frontId) == roleScreenFrontId);
        }).toList();

        int numberOfScreensInRange = allScreens.where((screen) {
          int includedScreenFrontId = int.parse(screen.frontId);
          return includedScreenFrontId >= screenFrontId &&
              includedScreenFrontId < screenFrontId + 1000;
        }).length;

        if (matchingActions.isEmpty) {
          screen.color = Colors.white;
        } else if (matchingActions.length == numberOfScreensInRange) {
          screen.color = Colors.green;
        } else {
          screen.color = Colors.orange;
        }
      } else {
        screen.color = Colors.white;
      }
    }

    update();
  }

  /// Filter the widgets to be shown based on the selected screen and the user's permissions.
  ///
  /// The function will filter the [allScreens] list to only include the widgets that
  /// are children of the selected screen and are included in the user's role.
  ///
  /// The filtered list of widgets will be stored in [resultFilteredWidgets].
  ///
  /// If the user does not have any roles, the function will return without doing
  /// anything.
  void filterWidgets() {
    if (lastSelectedFrontId == null) {
      return;
    }

    int lastSelectedFrontID;
    lastSelectedFrontID = int.parse(lastSelectedFrontId!);

    widgets = allScreens.where((screen) {
      int screenFrontId;
      screenFrontId = int.parse(screen.frontId);

      return screenFrontId >= lastSelectedFrontID &&
          screenFrontId < lastSelectedFrontID + 1000;
    }).toList();

    var role =
        filteredRoles.firstWhereOrNull((role) => role.id == selectedRoleId);

    if (role == null) {
      resultFilteredWidgets = widgets;
      return;
    }

    includedActions = role.screens!
        .map((screen) => screen.id)
        .where((action) => widgets.map((widget) => widget.id).contains(action))
        .toList();

    resultFilteredWidgets = widgets;

    update();
  }

  /// Gets all roles from the API and assigns them to [rolesList] and [filteredRoles].
  ///
  /// It takes no parameters.
  ///
  /// The function will return a boolean indicating whether the roles were
  /// retrieved successfully.
  ///
  /// If the response is a failure, it shows an error dialog with the failure
  /// message.
  ///
  /// The function will also update the UI to show a loading indicator while the request is being processed.
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

  /// Gets all screens from the API and assigns them to [allScreens] and [filteredScreens].
  ///
  /// It takes no parameters.
  ///
  /// The function will return a boolean indicating whether the screens were
  /// retrieved successfully.
  ///
  /// If the response is a failure, it shows an error dialog with the failure
  /// message.
  ///
  /// The function will also update the UI to show a loading indicator while the request is being processed.
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

  /// Called when the widget is initialized.
  ///
  /// It sets [getAllLoading] to true, calls [super.onInit], clears [removedScreensIds],
  /// [selectedScreensIds], and calls [getAllScreens] and [getAllRoles].
  ///
  /// If [selectedScreenId] and [lastSelectedFrontId] are not null, it calls
  /// [setSelectedScreen] and [filterColorScreen].
  ///
  /// It then calls [filterWidgets] and sets [getAllLoading] to false.
  ///
  /// This is used to initialize the state of the controller when the widget is
  /// initialized.
  void onInit() async {
    super.onInit();
    removedScreensIds.clear();
    selectedScreensIds.clear();
    getAllLoading = true;
    update();
    await Future.wait([getAllScreens(), getAllRoles()]);
    if (selectedScreenId != null && lastSelectedFrontId != null) {
      setSelectedScreen(selectedScreenId!, lastSelectedFrontId!);
      filterColorScreen();
    } else {
      null;
    }
    filterWidgets();
    getAllLoading = false;
    update();
  }

  /// Called when a user selects a value from the [DropdownSearch] widget.
  ///
  /// It takes a list of [ValueItem] objects as a parameter.
  ///
  /// The function sets [selectedScreensIds] to the values of the selected [ValueItem]
  /// objects, and calls [update] to notify the UI of the change.
  void onOptionSelected(List<ValueItem<dynamic>> selectedOptions) {
    selectedScreensIds =
        selectedOptions.map((e) => e.value as int).toList().cast<int>();
    update();
  }

  void searchInRoles(String query) {
    if (query.isEmpty) {
      filteredRoles = rolesList;
    } else {
      filteredRoles = rolesList.where((role) {
        return role.name?.toLowerCase().contains(query.toLowerCase()) ?? false;
      }).toList();
    }
    update();
  }

  /// Searches for screens within the filtered list of screens based on the given
  /// query. If the query is empty, it sets [filteredScreens] to the list of all
  /// screens. Otherwise, it filters the list of all screens based on the query
  /// and sets [filteredScreens] to the filtered list.
  ///
  /// The function then calls [update] to notify the UI of the change.
  ///
  /// [query] is the search query to search for in the list of screens.
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

  /// Searches for widgets within the filtered list of widgets based on the given
  /// query. If the query is empty, it sets [widgets] to the list of all widgets.
  /// Otherwise, it filters the list of all widgets based on the query and sets
  /// [widgets] to the filtered list.
  ///
  /// The function then calls [update] to notify the UI of the change.
  ///
  /// [query] is the search query to search for in the list of widgets.
  void searchWithinFilteredWidgets(String query) {
    if (query.isEmpty) {
      setSelectedScreen(selectedScreenId!, lastSelectedFrontId!);
      filterWidgets();
      widgets = resultFilteredWidgets;
    } else {
      widgets = resultFilteredWidgets.where((widget) {
        return widget.name.toLowerCase().contains(query.toLowerCase()) ||
            widget.frontId.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }

    update();
  }

  /// Sets the currently selected role to the given [roleId], filters the screens
  /// based on the selected role, filters the widgets based on the selected screen
  /// and selected role, and updates the UI to reflect the changes.
  ///
  void setSelectedRole(int roleId) {
    selectedRoleId = roleId;
    filterColorScreen();
    filterWidgets();
    update();
  }

  /// Sets the currently selected screen to the given [screenId] and [frontId],
  /// and notifies the UI of the change.
  ///
  /// [screenId] is the ID of the screen to be selected.
  ///
  /// [frontId] is the front ID of the screen to be selected.
  ///
  /// The function updates the UI to reflect the changes.
  ///
  /// The function is asynchronous and returns a future of void.
  Future<void> setSelectedScreen(int screenId, String frontId) async {
    selectedScreenId = screenId;
    lastSelectedFrontId = frontId;
    update();
  }
}
