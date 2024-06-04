import 'school_type_model.dart';

class SchoolsTypeResModel {
  SchoolsTypeResModel({this.data});

  factory SchoolsTypeResModel.fromJson(json) {
    var converter = List<SchoolTypeResModel>.from(
        json.map((e) => SchoolTypeResModel.fromJson(e)).toList());

    var data = SchoolsTypeResModel(data: converter);

    return data;
  }

  List<SchoolTypeResModel>? data;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = this.data!.map((v) => v.toJson()).toList();
    return data;
  }
}
