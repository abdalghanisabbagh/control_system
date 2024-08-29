import 'package:control_system/Data/Models/user/users_res/user_has_school_res_model.dart';

import '../../../../presentation/resource_manager/constants/app_constatnts.dart';
import 'created_by_user_res_model.dart';
import 'user_has_roles_res_model.dart';

class UserResModel {
  int? active;

  String? createdAt;

  int? createdBy;
  CreatedByUserResModel? createdByUserResModel;
  String? fullName;
  int? iD;
  String? isFloorManager;
  String? roleType;
  int? type;
  String? updatedAt;
  int? updatedBy;
  UserHasRolesResModel? userHasRoles;
  UserHasSchoolsResModel? userHasSchoolResModel;
  String? userName;
  UserResModel({
    this.iD,
    this.fullName,
    this.userName,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
    this.isFloorManager,
    this.type,
    this.active,
    this.createdByUserResModel,
    this.userHasRoles,
    this.roleType,
    this.userHasSchoolResModel,
  });
  UserResModel.fromJson(json) {
    iD = json['ID'];
    fullName = json['Full_Name'];
    userName = json['User_Name'];
    createdBy = json['Created_By'];
    createdAt = json['Created_At'];
    updatedBy = json['Updated_By'];
    updatedAt = json['Updated_At'];
    isFloorManager = json['IsFloorManager'];
    type = json['Type'];
    active = json['Active'];

    createdByUserResModel = json['CreatedById'] != null
        ? CreatedByUserResModel.fromJson(json['CreatedById'])
        : null;

    userHasRoles = json['users_has_roles'] != null
        ? UserHasRolesResModel.fromJson(json['users_has_roles'])
        : null;
    userHasSchoolResModel = json['users_has_schools'] != null
        ? UserHasSchoolsResModel.fromJson(json['users_has_schools'])
        : null;
    roleType = getRoleType(type ?? 0);
  }

  String getRoleType(int type) {
    const roleTypes = AppConstants.roleTypes;
    if (type < 0 || type >= roleTypes.length) {
      return 'Unknown';
    }
    return roleTypes[type];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['Full_Name'] = fullName;
    data['User_Name'] = userName;
    data['Created_By'] = createdBy;
    data['Created_At'] = createdAt;
    data['Updated_By'] = updatedBy;
    data['Updated_At'] = updatedAt;
    data['IsFloorManager'] = isFloorManager;
    data['Type'] = type;
    data['Active'] = active;
    if (createdByUserResModel != null) {
      data['CreatedById'] = createdByUserResModel!.toJson();
    }

    if (userHasRoles != null) {
      data['users_has_roles'] = userHasRoles!.toJson();
    }

    if (roleType != null) {
      data['Role'] = roleType;
    }
    return data;
  }
}
