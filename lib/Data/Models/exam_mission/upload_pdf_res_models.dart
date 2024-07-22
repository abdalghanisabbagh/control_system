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
