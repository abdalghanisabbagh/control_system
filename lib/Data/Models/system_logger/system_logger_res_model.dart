import 'package:intl/intl.dart';

class SystemLoggerResModel {
  String? body;

  String? createdAt;

  String? fullName;
  int? id;
  String? ip;
  String? method;
  String? platform;
  String? url;
  String? userAgent;
  String? userId;
  String? userType;
  SystemLoggerResModel({
    this.id,
    this.userAgent,
    this.ip,
    this.body,
    this.platform,
    this.userId,
    this.createdAt,
    this.url,
    this.fullName,
    this.userType,
    this.method,
  });
  SystemLoggerResModel.fromJson(json) {
    id = json['ID'];
    userAgent = json['userAgent'];
    ip = json['ip'];
    body = json['body'];
    platform = json['platform'];
    url = json['url'];
    method = json['method'];
    userId = json['userId'];
    fullName = json['fullName'];
    userType = json['userType'];
    createdAt = DateFormat('yyyy,MM,dd (HH:mm)')
        .format(DateTime.parse(json['Created_At']));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = id;
    data['TableName'] = userAgent;
    data['ip'] = ip;
    data['User_ID'] = body;
    data['Record_Before'] = platform;
    data['Record_After'] = url;
    data['Created_At'] = method;
    data['fullName'] = fullName;
    data['userType'] = userType;
    data['userId'] = userId;
    data['Created_At'] = createdAt;

    return data;
  }
}
