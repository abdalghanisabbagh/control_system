import '../../school/school_type/school_type_model.dart';

class UserHasSchoolsResModel {
  List<int>? schoolId;

  List<String>? schoolName;

  List<SchoolTypeResModel>? schoolType;
  List<int>? schoolTypeIds;
  UserHasSchoolsResModel({this.schoolName});
  UserHasSchoolsResModel.fromJson(json) {
    if (json is List) {
      schoolName = <String>[];
      schoolId = <int>[];
      schoolType = <SchoolTypeResModel>[];
      schoolTypeIds = <int>[];
      for (var v in json) {
        schoolName!.add((v['schools']['Name']));
        schoolId!.add(v['schools']['ID']);
        schoolTypeIds!.add(v['schools']['School_Type_ID']);
        schoolType!
            .add(SchoolTypeResModel.fromJson(v['schools']['school_type']));
      }
    }
  }

  List<Map<String, dynamic>> toJson() {
    List<Map<String, dynamic>> schools = [];
    if (schoolId != null && schoolName != null && schoolType != null) {
      for (var i = 0; i < schoolId!.length; i++) {
        final Map<String, dynamic> data = <String, dynamic>{};
        data['schools'] = {
          'ID': schoolId![i],
          'Name': schoolName![i],
          'School_Type_ID': schoolTypeIds![i],
          'school_type': schoolType![i].toJson()
        };
        schools.add(data);
      }
    }
    return schools;
  }
}
