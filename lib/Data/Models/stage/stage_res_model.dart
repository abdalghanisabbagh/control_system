import 'stage_model.dart';

class StageResModel {
  List<StageModel>? data;

  StageResModel({this.data});

  StageResModel.fromJson(json) {
    data =
        List<StageModel>.from(json.map((e) => StageModel.fromJson(e)).toList());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
