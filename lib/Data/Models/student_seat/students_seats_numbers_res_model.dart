import 'student_seat_res_model.dart';

class StudentsSeatsNumbersResModel {
  StudentsSeatsNumbersResModel({this.studentSeatNumbers});

  StudentsSeatsNumbersResModel.fromJson(json) {
    studentSeatNumbers = List<StudentSeatNumberResModel>.from(
        json.map((e) => StudentSeatNumberResModel.fromJson(e)).toList());
  }

  List<StudentSeatNumberResModel>? studentSeatNumbers;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (studentSeatNumbers != null) {
      data['data'] = studentSeatNumbers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
