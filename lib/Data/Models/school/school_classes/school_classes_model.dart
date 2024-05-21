class SchoolClassesModel {
  String? name;
  String? maxCapacity;
  String? floor;
  String? rows;
  int? columns;
  int? schoolsID;

  SchoolClassesModel({
    this.name,
    this.maxCapacity,
    this.floor,
    this.rows,
    this.columns,
    this.schoolsID,
  });

  SchoolClassesModel.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    maxCapacity = json['Max_Capacity'];
    floor = json['Floor'];
    rows = json['Rows'];
    columns = json['Columns'];
    schoolsID = json['Schools_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Name'] = name;
    data['Max_Capacity'] = maxCapacity;
    data['Floor'] = floor;
    data['Rows'] = rows;
    data['Columns'] = columns;
    data['Schools_ID'] = schoolsID;
    return data;
  }
}
