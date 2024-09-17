class SystemLoggerResModel {
  String? action;

  String? createdAt;

  int? id;
  String? recordAfter;
  String? recordBefore;
  String? tableName;
  String? userId;
  SystemLoggerResModel(
      {this.id,
      this.tableName,
      this.action,
      this.userId,
      this.recordBefore,
      this.recordAfter,
      this.createdAt});
  SystemLoggerResModel.fromJson(json) {
    id = json['ID'];
    tableName = json['TableName'];
    action = json['Action'];
    userId = json['UserId'];
    recordBefore = json['Record_Before'];
    recordAfter = json['Record_After'];
    createdAt = json['Created_At'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = id;
    data['TableName'] = tableName;
    data['Action'] = action;
    data['User_ID'] = userId;
    data['Record_Before'] = recordBefore;
    data['Record_After'] = recordAfter;
    data['Created_At'] = createdAt;
    return data;
  }
}
