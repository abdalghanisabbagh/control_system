class ProctorResModel {
  int? iD;
  String? fullName;
  String? userName;
  String? password;
  String? active;
  int? createdBy;
  String? createdAt;
  int? updatedBy;
  String? updatedAt;

  ProctorResModel({
    this.iD,
    this.fullName,
    this.userName,
    this.password,
    this.active,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
  });

  ProctorResModel.fromJson(json) {
    iD = json['ID'];
    fullName = json['Full_Name'];
    userName = json['User_Name'];
    password = json['Password'];
    active = json['Active'];
    createdBy = json['Created_By'];
    createdAt = json['Created_At'];
    updatedBy = json['Updated_By'];
    updatedAt = json['Updated_At'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['Full_Name'] = fullName;
    data['User_Name'] = userName;
    data['Password'] = password;
    data['Active'] = active;
    data['Created_By'] = createdBy;
    data['Created_At'] = createdAt;
    data['Updated_By'] = updatedBy;
    data['Updated_At'] = updatedAt;
    return data;
  }
}
