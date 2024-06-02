import 'package:control_system/Data/Models/user/login_response/user_profile_model.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProfileController extends GetxController {
  UserProfileModel? _cachedUserProfile;

  UserProfileModel? get cachedUserProfile =>
      _cachedUserProfile ?? getProfileFromHiveBox();

  void saveProfileToHiveBox(UserProfileModel cachedUserProfile) {
    Hive.box('Profile').putAll(cachedUserProfile.toJson());
  }

  UserProfileModel? getProfileFromHiveBox() {
    _cachedUserProfile = Hive.box('Profile').containsKey("CachedUserProfile")
        ? UserProfileModel(
            iD: Hive.box('Profile').get('ID'),
            fullName: Hive.box('Profile').get('Full_Name'),
            userName: Hive.box('Profile').get('User_Name'),
          )
        : null;
    return _cachedUserProfile;
  }

  Future<void> deleteProfileFromHiveBox() async {
    await Hive.box('Profile').clear();
  }
}
