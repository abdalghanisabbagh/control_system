import '../screens/screen_res_model.dart';

class RoleResModel {
  RoleResModel({
    required this.id,
    required this.name,
    this.screens,
  });

  factory RoleResModel.fromJson(json) => RoleResModel(
        id: json["ID"],
        name: json["Name"],
        screens: json["roles_has_screens"] != null
            ? List<ScreenResModel>.from(json["roles_has_screens"]
                .map((x) => ScreenResModel.fromJson(x['screens'] ?? x)))
            : null,
      );

  int id;
  String name;
  List<ScreenResModel>? screens = [];

  toJson() => {
        "ID": id,
        "Name": name,
        "roles_has_screens": screens?.map((e) => e.toJson()).toList(),
      };
}
