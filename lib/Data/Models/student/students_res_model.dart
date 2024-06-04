import 'student_res_model.dart';

class StudentsResModel {
  List<StudentResModel>? students;

  StudentsResModel({this.students});

  StudentsResModel.fromJson(json) {
    students = List<StudentResModel>.from(
        json.map((e) => StudentResModel.fromJson(e)).toList());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (students != null) {
      data['data'] = students!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
