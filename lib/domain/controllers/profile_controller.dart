import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../Data/Models/user/login_response/user_profile_model.dart';
import '../../Data/Network/response_handler.dart';
import '../../Data/enums/req_type_enum.dart';
import '../../app/configurations/app_links.dart';
import '../../presentation/resource_manager/ReusableWidget/show_dialogue.dart';

class ProfileController extends GetxController {
  bool isLoadingEditUser = false;
  bool showOldPassword = true;
  bool showPassword = true;

  UserProfileModel? _cachedUserProfile;

  UserProfileModel? get cachedUserProfile =>
      _cachedUserProfile ?? getProfileFromHiveBox();

  /// Check if the user has access to the given widgetId by checking if the
  /// role the user belongs to has a screen with the given widgetId.
  ///
  /// This method will first get the roles of the user using [cachedUserProfile].
  /// Then it will map each role to a list of strings which are the frontId of
  /// the screens the role has. Then it will check if the given widgetId is
  /// present in any of the lists. If it is, it will return true, otherwise it
  /// will return false.
  bool canAccessWidget({required String widgetId}) {
    return (cachedUserProfile?.roles
            ?.map((role) => role.screens
                ?.map((screen) => screen.frontId)
                .contains(widgetId))
            .where((element) => (element ?? false))
            .firstOrNull ??
        false);
  }

  /// Deletes the user profile from the Hive box and clears the cached user profile.
  ///
  Future<void> deleteProfileFromHiveBox() async {
    _cachedUserProfile = null;
    await Hive.box('Profile').clear();
  }

  /// Edits a user with the given [id] and [data] and returns a boolean indicating
  /// whether the operation was successful.
  ///
  /// The function takes two parameters: [data] and [id]. [data] is the data to be
  /// updated in the user and [id] is the ID of the user to be updated.
  ///
  /// The function will return a boolean indicating whether the operation was
  /// successful. If the operation is successful, the function will return true,
  /// otherwise it will return false.
  ///
  /// The function will also show a loading indicator while the request is being
  /// processed.
  ///
  /// If the response is a failure, the function will show an error dialog with the
  /// failure message.
  ///
  Future<bool> editUser(Map<String, dynamic> data, int id) async {
    isLoadingEditUser = true;
    update();

    final response = await ResponseHandler<void>().getResponse(
        path: "${UserLinks.users}/$id",
        converter: (_) {},
        type: ReqTypeEnum.PATCH,
        body: data);

    isLoadingEditUser = false;
    update();

    return response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
        isLoadingEditUser = false;
        update();
        return false;
      },
      (r) {
        isLoadingEditUser = false;
        update();
        return true;
      },
    );
  }

  /// Gets the user profile from the Hive box and returns it as a
  /// [UserProfileModel].
  ///
  /// If the user profile is not present in the Hive box, the method will return
  /// null.
  ///
  /// The method will first get the data from the Hive box using the key 'Profile'.
  /// If the key is present in the box, the method will decode the data and
  /// convert it to a [UserProfileModel] object. If the key is not present, the
  /// method will return null.
  ///
  UserProfileModel? getProfileFromHiveBox() {
    var data = Hive.box('Profile').get('Profile');
    _cachedUserProfile = Hive.box('Profile').containsKey("Profile")
        ? UserProfileModel.fromJson(jsonDecode(data))
        : null;
    return _cachedUserProfile;
  }

  /// Saves the user profile to the Hive box and updates the cached user profile.
  ///
  /// The function takes a [UserProfileModel] object as a parameter and saves it
  /// to the Hive box using the key 'Profile'. The function will also update the
  /// cached user profile and notify the UI to rebuild using the [update] method.
  ///
  /// The function will not return anything.
  ///
  void saveProfileToHiveBox(UserProfileModel cachedUserProfile) {
    _cachedUserProfile = cachedUserProfile;
    update();
    Hive.box('Profile').put('Profile', jsonEncode(cachedUserProfile.toJson()));
  }
}
