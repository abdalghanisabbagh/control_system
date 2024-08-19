class UserHasSchoolsResModel {
  List<int>? schoolId;

  List<String>? schoolName;

  UserHasSchoolsResModel({this.schoolName});
  UserHasSchoolsResModel.fromJson(json) {
    if (json is List) {
      schoolName = <String>[];
      schoolId = <int>[];
      for (var v in json) {
        schoolName!.add((v['schools']['Name']));
        schoolId!.add(v['schools']['ID']);
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (schoolId != null) {
      data['data'] = schoolId!.map((v) => v).toList();
    }
    return data;
  }
}
