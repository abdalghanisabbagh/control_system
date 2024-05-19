import 'package:control_system/Data/Models/user/login_response/user_profile.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProfileController extends GetxController {
  UserProfile? _cachedUserProfile;

  UserProfile? get cachedUserProfile =>
      _cachedUserProfile ?? getProfileFromHiveBox();

  void saveProfileToHiveBox(UserProfile cachedUserProfile) {
    Hive.box('Profile').put("CachedUserProfile", cachedUserProfile.toJson());
  }

  UserProfile? getProfileFromHiveBox() {
    _cachedUserProfile = Hive.box('Profile').containsKey("CachedUserProfile")
        ? UserProfile.fromJson(Hive.box('Profile').get("CachedUserProfile"))
        : null;
    return _cachedUserProfile;
  }
}
