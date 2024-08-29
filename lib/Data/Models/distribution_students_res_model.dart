class DistributionStudentsResModel {
  int? distributedStudents;
  int? unDistributedStudents;
  int? totalStudents;

  DistributionStudentsResModel({
    this.distributedStudents,
    this.unDistributedStudents,
    this.totalStudents,
  });

  DistributionStudentsResModel.fromJson(json) {
    distributedStudents = json['distributedStudents'];
    unDistributedStudents = json['unDistributedStudents'];
    totalStudents = json['totalStudents'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['distributedStudents'] = distributedStudents;
    data['unDistributedStudents'] = unDistributedStudents;
    data['totalStudents'] = totalStudents;
    return data;
  }
}
