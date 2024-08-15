class UserHasRolesResModel {
  List<String>? roles;
  List<int>? roleID;

  UserHasRolesResModel({this.roles});

  UserHasRolesResModel.fromJson(json) {
    if (json is List) {
      roles = <String>[];
      roleID = <int>[];
      for (var v in json) {
        roles!.add((v['roles']['Name']));
        roleID!.add(v['roles']['ID']);
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (roles != null) {
      data['roles'] = roles!.map((e) => {'Name': e}).toList();
    }
    return data;
  }
}
