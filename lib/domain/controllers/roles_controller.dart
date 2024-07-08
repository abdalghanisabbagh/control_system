import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:control_system/Data/Models/user/roles/role_res_model.dart';
import 'package:control_system/Data/Models/user/roles/roleres_model.dart';
import 'package:control_system/Data/Models/user/screens/screen_res_model.dart';
import 'package:control_system/Data/Models/user/screens/screens_res_model.dart';
import 'package:control_system/Data/Network/response_handler.dart';
import 'package:control_system/Data/Network/tools/failure_model.dart';
import 'package:control_system/Data/enums/req_type_enum.dart';
import 'package:control_system/app/configurations/app_links.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/show_dialgue.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:multi_dropdown/models/value_item.dart';

class RolesController extends GetxController {
  bool getAllLoading = false;
  bool addLoading = false;
  bool connectLoading = false;

  List<ScreenResModel> screens = [];
  List<RoleResModel> roles = [];
  List<int> selectedSreensIds = [];
  @override
  void onInit() {
    getAllScreens();
    getAllRoles();
    super.onInit();
  }

  Future getAllScreens() async {
    getAllLoading = true;
    update();
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
        getAllLoading = false;
        update();
      },
      (r) {
        screens = r.data!;
        getAllLoading = false;
        update();
      },
    );
  }

  Future getAllRoles() async {
    getAllLoading = true;
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
        getAllLoading = false;
        update();
      },
      (r) {
        roles = r.data!;
        getAllLoading = false;
        update();
      },
    );
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
        // "Created_By": Hive.box('Profile').get('ID'),
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
        // "Created_By": Hive.box('Profile').get('ID'),
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

  Future<bool> addScreensToRole(int roleId) async {
    connectLoading = true;
    update();
    bool screenHasBeenAdded = false;
    ResponseHandler<RoleResModel> responseHandler = ResponseHandler();
    Either<Failure, RoleResModel> response = await responseHandler.getResponse(
      path:
          '${UserRolesSystemsLink.userRolesSystemsConnectRolesTOScreens}/$roleId',
      converter: RoleResModel.fromJson,
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

  void onOptionSelected(List<ValueItem<dynamic>> selectedOptions) {
    selectedSreensIds =
        selectedOptions.map((e) => e.value as int).toList().cast<int>();
    update();
  }
}
