import 'role_res_model.dart';

class RolesResModel {
  RolesResModel({this.data});

  factory RolesResModel.fromJson(json) => RolesResModel(
      data: List<RoleResModel>.from(
          json.map((e) => RoleResModel.fromJson(e)).toList()));

  List<RoleResModel>? data;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
