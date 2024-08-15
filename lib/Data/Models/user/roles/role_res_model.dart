import '../screens/screen_res_model.dart';

class RoleResModel {
  int? id;

  String? name;

  List<ScreenResModel>? screens = [];
  RoleResModel({
    required this.id,
    required this.name,
    this.screens,
  });
  factory RoleResModel.fromJson(json) => RoleResModel(
        id: json["ID"],
        name: json["Name"],
        screens: json["roles_has_screens"] != null
            ? List<ScreenResModel>.from(json["roles_has_screens"].map(
                (element) =>
                    ScreenResModel.fromJson(element['screens'] ?? element)))
            : json["screens"] != null
                ? List<ScreenResModel>.from(json["screens"].map((element) =>
                    ScreenResModel.fromJson(element['screens'] ?? element)))
                : null,
      );

  toJson() => {
        "ID": id,
        "Name": name,
        "roles_has_screens": screens?.map((e) => e.toJson()).toList(),
      };
}
