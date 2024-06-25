import 'class_desk_res_model.dart';

class ClassDesksResModel {
  ClassDesksResModel({this.data});

  ClassDesksResModel.fromJson(json) {
    data = List<ClassDeskModel>.from(
        json.map((e) => ClassDeskModel.fromJson(e)).toList());
  }

  List<ClassDeskModel>? data;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
