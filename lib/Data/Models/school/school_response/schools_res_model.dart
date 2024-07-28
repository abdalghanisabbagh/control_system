import 'school_res_model.dart';

class SchoolsResModel {
  List<SchoolResModel>? data;

  SchoolsResModel({this.data});

  factory SchoolsResModel.fromJson(json) {
    var converter = List<SchoolResModel>.from(
        json.map((e) => SchoolResModel.fromJson(e)).toList());

    var data = SchoolsResModel(data: converter);

    return data;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = this.data!.map((v) => v.toJson()).toList();
    return data;
  }
}
