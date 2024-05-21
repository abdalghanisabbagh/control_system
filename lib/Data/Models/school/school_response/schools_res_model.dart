import 'package:control_system/Data/Models/school/school_response/school_res_model.dart';

class SchoolsResModel {
  List<SchoolResModel>? data;

  SchoolsResModel({this.data});

  SchoolsResModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <SchoolResModel>[];
      json['data'].forEach(
        (v) {
          data!.add(SchoolResModel.fromJson(v));
        },
      );
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = this.data!.map((v) => v.toJson()).toList();
    return data;
  }
}
