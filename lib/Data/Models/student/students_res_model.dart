import 'package:control_system/Data/Models/student/student_model.dart';

class StudentsTypeResModel {
  List<StudentMoodel>? data;

  StudentsTypeResModel({this.data});

  factory StudentsTypeResModel.fromJson(json) {
    var converter = List<StudentMoodel>.from(
        json.map((e) => StudentMoodel.fromJson(e)).toList());

    var data = StudentsTypeResModel(data: converter);

    return data;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = this.data!.map((v) => v.toJson()).toList();
    return data;
  }
}
