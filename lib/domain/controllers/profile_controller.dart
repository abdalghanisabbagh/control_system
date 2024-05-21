import 'package:control_system/Data/Models/user/login_response/user_profile_model.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProfileController extends GetxController {
  UserProfileModel? _cachedUserProfile;

  UserProfileModel? get cachedUserProfile =>
      _cachedUserProfile ?? getProfileFromHiveBox();

  void saveProfileToHiveBox(UserProfileModel cachedUserProfile) {
    Hive.box('Profile').put("CachedUserProfile", cachedUserProfile.toJson());
  }

  UserProfileModel? getProfileFromHiveBox() {
    _cachedUserProfile = Hive.box('Profile').containsKey("CachedUserProfile")
        ? UserProfileModel.fromJson(
            Hive.box('Profile').get("CachedUserProfile"))
        : null;
    return _cachedUserProfile;
  }
}
