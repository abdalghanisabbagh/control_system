class PreviewExamResModel {
  String? A;

  PreviewExamResModel({this.A});

  PreviewExamResModel.fromJson(json) {
    A = json['A'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = A;
    return data;
  }
}
