class BarcodesResModel {
  List<BarcodesResModel>? barcodes;
  BarcodesResModel({this.barcodes});
  BarcodesResModel.fromJson(json) {
    barcodes = List<BarcodesResModel>.from(
        json.map((e) => BarcodesResModel.fromJson(e)).toList());
  }
}
