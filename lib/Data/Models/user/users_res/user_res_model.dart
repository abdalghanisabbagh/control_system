class UserResModel {
  int? iD;
  String? fullName;
  String? userName;
  int? createdBy;
  String? createdAt;
  int? updatedBy;
  String? updatedAt;
  String? isFloorManager;
  int? type;
  int? active;

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
    return data;
  }
}