import 'package:control_system/Data/Models/student/student_grades_res_model.dart';

class StudentsGraesResModel {
  List<StudentGradesResModel>? studentGradesResModel;
  StudentsGraesResModel({this.studentGradesResModel});

  StudentsGraesResModel.fromJson(json) {
    studentGradesResModel = List<StudentGradesResModel>.from(
        json.map((e) => StudentGradesResModel.fromJson(e))).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (studentGradesResModel != null) {
      data['student_grades_res_model'] =
          studentGradesResModel!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
