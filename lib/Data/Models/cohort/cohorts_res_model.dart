import 'cohort_res_model.dart';

class CohortsResModel {
  List<CohortResModel>? data;

  CohortsResModel({this.data});

  CohortsResModel.fromJson(json) {
    data = List<CohortResModel>.from(
        json.map((e) => CohortResModel.fromJson(e)).toList());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
