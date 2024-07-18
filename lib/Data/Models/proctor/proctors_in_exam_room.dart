class ProctorsInExamRoom {
  List<ProctorsInExamRoom>? data;

  ProctorsInExamRoom({this.data});

  ProctorsInExamRoom.fromJson(json) {
    data = List<ProctorsInExamRoom>.from(
        json.map((e) => ProctorsInExamRoom.fromJson(e)).toList());
  }
}
