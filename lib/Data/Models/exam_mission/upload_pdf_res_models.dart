class Pdf {
  String? data;

  Pdf({this.data});

  Pdf.fromJson(json) {
    data = json;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = this.data;
    return data;
  }
}
