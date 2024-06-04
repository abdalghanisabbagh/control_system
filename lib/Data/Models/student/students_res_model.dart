import 'student_res_model.dart';

class StudentsResModel {
  StudentsResModel({this.students});

  StudentsResModel.fromJson(json) {
    students = List<StudentResModel>.from(
        json.map((e) => StudentResModel.fromJson(e)).toList());
  }

  List<StudentResModel>? students;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (students != null) {
      data['data'] = students!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
