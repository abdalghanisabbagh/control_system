import 'dart:convert';

import 'package:control_system/Data/Models/user/users_res/user_has_school_res_model.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UserHasSchoolsController extends GetxController {
  UserHasSchoolsResModel? _cachedUserHasRolesResModel;

  UserHasSchoolsResModel? get userHasSchoolsResModel =>
      _cachedUserHasRolesResModel ?? getCachedUserHasSchoolsResModel();

  void cacheUserHasSchoolsResModel(
      UserHasSchoolsResModel userHasSchoolsResModel) {
    _cachedUserHasRolesResModel = userHasSchoolsResModel;
    Hive.box('School')
        .put('UserHasSchools', jsonEncode(userHasSchoolsResModel.toJson()));
  }

  UserHasSchoolsResModel? getCachedUserHasSchoolsResModel() {
    return Hive.box('School').containsKey('UserHasSchools')
        ? _cachedUserHasRolesResModel = UserHasSchoolsResModel.fromJson(
            jsonDecode(Hive.box('School').get('UserHasSchools')))
        : null;
  }
}
