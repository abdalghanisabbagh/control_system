import 'proctor_res_model.dart';

class ProctorsResModel {
  ProctorsResModel({this.data});

  ProctorsResModel.fromJson(json) {
    data = List<ProctorResModel>.from(
        json.map((e) => ProctorResModel.fromJson(e)).toList());
  }

  List<ProctorResModel>? data;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
