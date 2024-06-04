class GradeResModel {
  GradeResModel({
    this.iD,
    this.schoolsID,
    this.name,
    this.nextGrade,
    this.createdBy,
    this.createdAt,
  });

  GradeResModel.fromJson(json) {
    iD = json['ID'];
    schoolsID = json['Schools_ID'];
    name = json['Name'];
    nextGrade = json['Next_Grade'];
    createdBy = json['Created_By'];
    createdAt = json['Created_At'];
  }

  String? createdAt;
  int? createdBy;
  int? iD;
  String? name;
  int? nextGrade;
  int? schoolsID;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['Schools_ID'] = schoolsID;
    data['Name'] = name;
    data['Next_Grade'] = nextGrade;
    data['Created_By'] = createdBy;
    data['Created_At'] = createdAt;
    return data;
  }
}
