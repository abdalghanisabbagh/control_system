import 'screen_res_model.dart';

class ScreensResModel {
  ScreensResModel({this.data});

  factory ScreensResModel.fromJson(json) => ScreensResModel(
      data: List<ScreenResModel>.from(
          json.map((e) => ScreenResModel.fromJson(e)).toList()));

  List<ScreenResModel>? data;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
