import 'cohort_has_subjects_res_model.dart';

class CohortsSubjectsResModel {
  List<CohortHasSubjectsResModel>? cohortHasSubjects;

  CohortsSubjectsResModel({this.cohortHasSubjects});

  CohortsSubjectsResModel.fromJson(json) {
    cohortHasSubjects = List<CohortHasSubjectsResModel>.from(
        json.map((e) => CohortHasSubjectsResModel.fromJson(e)).toList());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cohortHasSubjects != null) {
      data['cohort_has_subjects'] =
          cohortHasSubjects!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
