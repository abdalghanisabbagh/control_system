class ClassDeskResModel {
  int? cloumnNum;

  int? id;

  int? rowNum;
  int? schoolClassID;
  ClassDeskResModel({
    this.id,
    this.schoolClassID,
    this.cloumnNum,
    this.rowNum,
  });
  ClassDeskResModel.fromJson(json) {
    id = json['ID'];
    schoolClassID = json['School_Class_ID'];
    cloumnNum = json['Cloumn_Num'];
    rowNum = json['Row_Num'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = id;
    data['School_Class_ID'] = schoolClassID;
    data['Cloumn_Num'] = cloumnNum;
    data['Row_Num'] = rowNum;
    return data;
  }
}
