class StudentSeatNumberResModel {
  int? iD;
  int? examRoomID;
  int? studentID;
  int? controlMissionID;
  String? seatNumber;

  StudentSeatNumberResModel({
    this.iD,
    this.examRoomID,
    this.studentID,
    this.controlMissionID,
    this.seatNumber,
  });

  StudentSeatNumberResModel.fromJson(json) {
    iD = json['ID'];
    examRoomID = json['Exam_Room_ID'];
    studentID = json['Student_ID'];
    controlMissionID = json['Control_Mission_ID'];
    seatNumber = json['Seat_Number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['Exam_Room_ID'] = examRoomID;
    data['Student_ID'] = studentID;
    data['Control_Mission_ID'] = controlMissionID;
    data['Seat_Number'] = seatNumber;
    return data;
  }
}
