class UserHasSchoolResModel {
  List<int>? schoolId;

  List<String>? schoolName;

  UserHasSchoolResModel({this.schoolName});
  UserHasSchoolResModel.fromJson(json) {
    if (json is List) {
      schoolName = <String>[];
      schoolId = <int>[];
      for (var v in json) {
        schoolName!.add((v['schools']['Name']));
        schoolId!.add(v['schools']['ID']);
      }
    }
  }

 
}
