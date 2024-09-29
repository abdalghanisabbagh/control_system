
import 'system_logger_res_model.dart';

class SystemLoggersResModel {
  List<SystemLoggerResModel>? data;

  SystemLoggersResModel({this.data});

  SystemLoggersResModel.fromJson(json) {
    data = List<SystemLoggerResModel>.from(
        json.map((e) => SystemLoggerResModel.fromJson(e)).toList());
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['data'] = data.map((v) => v.toJson() as MapEntry Function(String key, dynamic value)).toList();
  //     return data;
  // }
}
