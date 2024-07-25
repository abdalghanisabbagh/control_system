Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['data'] = data;
  return data;
}

class PdfExamMissionResModel {
  String? data;

  PdfExamMissionResModel({this.data});

  PdfExamMissionResModel.fromJson(json) {
    data = json;
  }
}

class UploadPdfResModel {
  String? url;

  UploadPdfResModel({this.url});

  UploadPdfResModel.fromJson(json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    return data;
  }
}
