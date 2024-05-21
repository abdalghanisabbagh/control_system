class ClassDeskModel {
  int? schoolClassID;
  int? cloumnNum;
  int? rowNum;

  ClassDeskModel({this.schoolClassID, this.cloumnNum, this.rowNum});

  ClassDeskModel.fromJson(Map<String, dynamic> json) {
    schoolClassID = json['School_Class_ID'];
    cloumnNum = json['Cloumn_Num'];
    rowNum = json['Row_Num'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['School_Class_ID'] = schoolClassID;
    data['Cloumn_Num'] = cloumnNum;
    data['Row_Num'] = rowNum;
    return data;
  }
}
