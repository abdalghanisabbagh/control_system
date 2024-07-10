import '../roles/role_res_model.dart';

class UserProfileModel {
  UserProfileModel({
    this.iD,
    this.fullName,
    this.userName,
    this.roles,
  });

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    fullName = json['Full_Name'];
    userName = json['User_Name'];
    createdBy = json['Created_By'];
    createdAt = json['Created_At'];
    updatedBy = json['Updated_By'];
    updatedAt = json['Updated_At'];
    active = json['Active'];
    roles = List<RoleResModel>.from(
        json['Roles'].map((e) => RoleResModel.fromJson(e)));
  }

  int? active;
  String? createdAt;
  int? createdBy;
  String? fullName;
  int? iD;
  List<RoleResModel>? roles;
  DateTime? updatedAt;
  int? updatedBy;
  String? userName;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['Full_Name'] = fullName;
    data['User_Name'] = userName;
    data['Created_By'] = createdBy;
    data['Created_At'] = createdAt;
    data['Updated_By'] = updatedBy;
    data['Updated_At'] = updatedAt;
    data['Active'] = active;
    data['Roles'] = roles?.map((e) => e.toJson()).toList();
    return data;
  }
}
