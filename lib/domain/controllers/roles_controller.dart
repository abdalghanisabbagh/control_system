import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:multi_dropdown/models/value_item.dart';
import 'package:transformable_list_view/transformable_list_view.dart';

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
  bool addLoading = false;
  bool connectLoading = false;
  bool deleteScreenLoading = false;
  bool getAllLoading = false;
  List<int> removedSreensIds = [];
  List<RoleResModel> roles = [];
  bool rolesLoading = false;
  final ScrollController rolesScrollController = ScrollController();
  List<ScreenResModel> screens = [];
  final ScrollController screensScrollController = ScrollController();
  List<int> selectedSreensIds = [];

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
        getAllRoles();
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

  Future<bool> addScreensToRole(int roleId) async {
    connectLoading = true;
    update();
    bool screenHasBeenAdded = false;
    ResponseHandler<void> responseHandler = ResponseHandler();
    Either<Failure, void> response = await responseHandler.getResponse(
      path:
          '${UserRolesSystemsLink.userRolesSystemsConnectRolesToScreens}/$roleId',
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
        getAllRoles();
        screenHasBeenAdded = true;
        update();
      },
    );
    connectLoading = false;
    update();
    return screenHasBeenAdded;
  }

  Future<bool> deleteScreensFromRole(int roleId) async {
    deleteScreenLoading = true;
    update();
    bool screenHasBeenRemoved = false;
    ResponseHandler<void> responseHandler = ResponseHandler();
    Either<Failure, void> response = await responseHandler.getResponse(
      path:
          '${UserRolesSystemsLink.userRolesSystemsDisconnectRolesFromScreens}/$roleId',
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
        getAllRoles();
        screenHasBeenRemoved = true;
        update();
      },
    );
    deleteScreenLoading = false;
    update();
    return screenHasBeenRemoved;
  }

  Future getAllRoles() async {
    rolesLoading = true;
    update();
    ResponseHandler<RolesResModel> responseHandler = ResponseHandler();
    Either<Failure, RolesResModel> response = await responseHandler.getResponse(
      path: UserRolesSystemsLink.userRolesSystems,
      converter: RolesResModel.fromJson,
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
        roles = r.data!;
      },
    );
    rolesLoading = false;
    update();
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
        screens = r.data!;
      },
    );
  }

  Matrix4 getTransformMatrix(TransformableListItem item) {
    /// final scale of child when the animation is completed
    const endScaleBound = 0.3;

    /// 0 when animation completed and [scale] == [endScaleBound]
    /// 1 when animation starts and [scale] == 1
    final animationProgress = item.visibleExtent / item.size.height;

    /// result matrix
    final paintTransform = Matrix4.identity();

    /// animate only if item is on edge
    if (item.position != TransformableListItemPosition.middle) {
      final scale = endScaleBound + ((1 - endScaleBound) * animationProgress);

      paintTransform
        ..translate(item.size.width / 2)
        ..scale(scale)
        ..translate(-item.size.width / 2);
    }

    return paintTransform;
  }

  @override
  void onClose() {
    rolesScrollController.dispose();
    screensScrollController.dispose();
    super.onClose();
  }

  @override
  void onInit() async {
    getAllLoading = true;
    update();
    await Future.wait([
      getAllScreens(),
      getAllRoles(),
    ]);
    getAllLoading = false;
    update();
    super.onInit();
  }

  void onOptionSelected(List<ValueItem<dynamic>> selectedOptions) {
    selectedSreensIds =
        selectedOptions.map((e) => e.value as int).toList().cast<int>();
    update();
  }
}
