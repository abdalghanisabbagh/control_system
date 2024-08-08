class UserHasRolesResModel {
  List<String>? roles;

  UserHasRolesResModel({this.roles});

  UserHasRolesResModel.fromJson(json) {
    if (json is List) {
      roles = <String>[];
      for (var v in json) {
        roles!.add((v['roles']['Name']));
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
