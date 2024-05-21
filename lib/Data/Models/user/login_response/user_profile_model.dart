class UserProfileModel {
  int? iD;
  String? fullName;
  String? userName;

  UserProfileModel({
    this.iD,
    this.fullName,
    this.userName,
  });

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    fullName = json['Full_Name'];
    userName = json['User_Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['Full_Name'] = fullName;
    data['User_Name'] = userName;
    return data;
  }
}
