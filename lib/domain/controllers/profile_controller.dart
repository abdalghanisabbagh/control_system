import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../Data/Models/user/login_response/user_profile_model.dart';
import '../../Data/Network/response_handler.dart';
import '../../Data/enums/req_type_enum.dart';
import '../../app/configurations/app_links.dart';
import '../../presentation/resource_manager/ReusableWidget/show_dialgue.dart';

class ProfileController extends GetxController {
  bool isLodingEditUser = false;

  UserProfileModel? _cachedUserProfile;

  UserProfileModel? get cachedUserProfile =>
      _cachedUserProfile ?? getProfileFromHiveBox();

  bool canAccessWidget({required String widgetId}) {
    return (cachedUserProfile?.roles
            ?.map((role) => role.screens
                ?.map((screen) => screen.frontId)
                .contains(widgetId))
            .firstOrNull ??
        false);
  }

  Future<void> deleteProfileFromHiveBox() async {
    _cachedUserProfile = null;
    await Hive.box('Profile').clear();
  }

  UserProfileModel? getProfileFromHiveBox() {
    var data = Hive.box('Profile').get('Profile');
    _cachedUserProfile = Hive.box('Profile').containsKey("Profile")
        ? UserProfileModel.fromJson(jsonDecode(data))
        : null;
    return _cachedUserProfile;
  }

  void saveProfileToHiveBox(UserProfileModel cachedUserProfile) {
    _cachedUserProfile = cachedUserProfile;
    update();
    Hive.box('Profile').put('Profile', jsonEncode(cachedUserProfile.toJson()));
  }

  Future<bool> editUser(Map<String, dynamic> data, int id) async {
    isLodingEditUser = true;
    update();

    final response = await ResponseHandler<void>().getResponse(
        path: "${UserLinks.users}/$id",
        converter: (_){},
        type: ReqTypeEnum.PATCH,
        body: data);

    isLodingEditUser = false;
    update();

    return response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
        isLodingEditUser = false;
        update();
        return false;
      },
      (r) {
        isLodingEditUser = false;
        update();
        return true;
      },
    );
  }
}
