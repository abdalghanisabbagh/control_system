import 'dart:convert';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../Data/Models/user/login_response/user_profile_model.dart';

class ProfileController extends GetxController {
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
}
