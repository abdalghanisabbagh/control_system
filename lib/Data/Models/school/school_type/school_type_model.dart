import '../../base_model.dart';

class SchoolTypeModel extends BaseModel {
  String? name;

  SchoolTypeModel({this.name});

  SchoolTypeModel.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Name'] = name;
    return data;
  }
}
