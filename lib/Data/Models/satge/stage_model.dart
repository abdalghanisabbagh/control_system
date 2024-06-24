class StageModel {
  int? iD;
  String? name;
  int? active;
  int? createdBy;
  String? createdAt;

  StageModel({
    this.iD,
    this.name,
    this.active,
    this.createdBy,
    this.createdAt,
  });

  StageModel.fromJson(json) {
    iD = json['ID'];
    name = json['Name'];
    active = json['Active'];
    createdBy = json['Created_By'];
    createdAt = json['Created_At'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['Name'] = name;
    data['Active'] = active;
    data['Created_By'] = createdBy;
    data['Created_At'] = createdAt;
    return data;
  }
}
