import 'dart:convert' as convert;

class ClassRoomResModel {
  ClassRoomResModel({
    this.iD,
    this.schoolsID,
    this.name,
    this.maxCapacity,
    this.floor,
    this.rows,
    this.columns,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
    this.active,
  });

  ClassRoomResModel.fromJson(json) {
    iD = json['ID'];
    schoolsID = json['Schools_ID'];
    name = json['Name'];
    maxCapacity = json['Max_Capacity'];
    floor = json['Floor'];
    rows = json['Rows'] == null
        ? null
        : convert.json.decode(json['Rows']).cast<int>();
    columns = json['Columns'];
    createdBy = json['Created_By'];
    createdAt = json['Created_At'];
    updatedBy = json['Updated_By'];
    updatedAt = json['Updated_At'];
    active = json['Active'];
  }

  int? active;
  int? columns;
  String? createdAt;
  int? createdBy;
  String? floor;
  int? iD;
  String? maxCapacity;
  String? name;
  List<int>? rows;
  int? schoolsID;
  DateTime? updatedAt;
  int? updatedBy;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['Schools_ID'] = schoolsID;
    data['Name'] = name;
    data['Max_Capacity'] = maxCapacity;
    data['Floor'] = floor;
    data['Rows'] = rows;
    data['Columns'] = columns;
    data['Created_By'] = createdBy;
    data['Created_At'] = createdAt;
    data['Updated_By'] = updatedBy;
    data['Updated_At'] = updatedAt;
    data['Active'] = active;
    return data;
  }
}
