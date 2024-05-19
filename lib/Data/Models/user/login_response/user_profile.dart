class UserProfile {
  int? iD;
  String? fullName;
  String? userName;
  String? password;
  int? createdBy;
  String? createdAt;
  int? active;

  UserProfile(
      {this.iD,
      this.fullName,
      this.userName,
      this.password,
      this.createdBy,
      this.createdAt,
      this.active});

  UserProfile.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    fullName = json['Full_Name'];
    userName = json['User_Name'];
    password = json['Password'];
    createdBy = json['Created_By'];
    createdAt = json['Created_At'];
    active = json['Active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['Full_Name'] = fullName;
    data['User_Name'] = userName;
    data['Password'] = password;
    data['Created_By'] = createdBy;
    data['Created_At'] = createdAt;
    data['Active'] = active;
    return data;
  }
}
