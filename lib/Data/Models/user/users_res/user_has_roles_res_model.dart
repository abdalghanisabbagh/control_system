import 'package:control_system/Data/Models/user/roles/roleres_model.dart';

class UserHasRolesResModel {
  List<RolesResModel>? roles;

  UserHasRolesResModel({this.roles});

  UserHasRolesResModel.fromJson(json) {
    roles = json['roles'] != null
        ? (json['roles'] as List).map((i) => RolesResModel.fromJson(i)).toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (roles != null) {
      data['roles'] = roles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
