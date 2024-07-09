import 'dart:convert';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../Data/Models/user/login_response/user_profile_model.dart';

class ProfileController extends GetxController {
  UserProfileModel? _cachedUserProfile;
  UserProfileModel? profileModel;

  UserProfileModel? get cachedUserProfile =>
      _cachedUserProfile ?? getProfileFromHiveBox();

  void saveProfileToHiveBox(UserProfileModel cachedUserProfile) {
    profileModel = cachedUserProfile;
    update();
    Hive.box('Profile').put('Profile', jsonEncode(cachedUserProfile.toJson()));
  }

  UserProfileModel? getProfileFromHiveBox() {
    var data = Hive.box('Profile').get('Profile');
    _cachedUserProfile = Hive.box('Profile').containsKey("Profile")
        ? UserProfileModel.fromJson(jsonDecode(data))
        : null;
    return _cachedUserProfile;
  }

  Future<void> deleteProfileFromHiveBox() async {
    await Hive.box('Profile').clear();
  }
}
