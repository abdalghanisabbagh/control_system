class UserProfile {
  int? iD;
  String? fullName;
  String? userName;

  UserProfile({
    this.iD,
    this.fullName,
    this.userName,
  });

  UserProfile.fromJson(Map<String, dynamic> json) {
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
