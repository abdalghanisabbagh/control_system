import 'class_desk_res_model.dart';

class ClassDesksResModel {
  List<ClassDeskResModel>? data;

  ClassDesksResModel({this.data});

  ClassDesksResModel.fromJson(json) {
    data = List<ClassDeskResModel>.from(
        json.map((e) => ClassDeskResModel.fromJson(e)).toList());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
