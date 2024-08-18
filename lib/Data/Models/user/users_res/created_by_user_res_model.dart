class CreatedByUserResModel {
  String? fullName;

  String? userName;

  CreatedByUserResModel({this.userName, this.fullName});
  CreatedByUserResModel.fromJson(json) {
    userName = json['User_Name'];
    fullName = json['Full_Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['User_Name'] = userName;
    data['Full_Name'] = fullName;
    return data;
  }
}
