class ClassDeskResModel {
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

  int? id;
  int? cloumnNum;
  int? rowNum;
  int? schoolClassID;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = id;
    data['School_Class_ID'] = schoolClassID;
    data['Cloumn_Num'] = cloumnNum;
    data['Row_Num'] = rowNum;
    return data;
  }
}
