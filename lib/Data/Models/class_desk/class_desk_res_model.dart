class ClassDeskResModel {
  int? columnNum;

  int? id;

  int? rowNum;
  int? schoolClassID;
  ClassDeskResModel({
    this.id,
    this.schoolClassID,
    this.columnNum,
    this.rowNum,
  });
  ClassDeskResModel.fromJson(json) {
    id = json['ID'];
    schoolClassID = json['School_Class_ID'];
    columnNum = json['Cloumn_Num'];
    rowNum = json['Row_Num'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = id;
    data['School_Class_ID'] = schoolClassID;
    data['Cloumn_Num'] = columnNum;
    data['Row_Num'] = rowNum;
    return data;
  }
}
