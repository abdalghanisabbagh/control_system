class SubjectResModel {
  String? active;

  String? createdAt;

  int? createdBy;
  int? iD;
  String? name;
  DateTime? updatedAt;
  int? updatedBy;
  SubjectResModel({
    this.iD,
    this.name,
    this.active,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
  });
  SubjectResModel.fromJson(json) {
    iD = json['ID'];
    name = json['Name'];
    active = json['Active'];
    createdBy = json['Created_By'];
    createdAt = json['Created_At'];
    updatedBy = json['Updated_By'];
    updatedAt = json['Updated_At'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['Name'] = name;
    data['Active'] = active;
    data['Created_By'] = createdBy;
    data['Created_At'] = createdAt;
    data['Updated_By'] = updatedBy;
    data['Updated_At'] = updatedAt;
    return data;
  }
}
