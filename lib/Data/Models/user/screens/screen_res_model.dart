class ScreenResModel {
  String frontId;

  int id;

  String name;
  ScreenResModel({
    required this.id,
    required this.frontId,
    required this.name,
  });
  factory ScreenResModel.fromJson(json) => ScreenResModel(
        id: json["ID"],
        frontId: json["Front_Id"],
        name: json["Name"],
      );

  toJson() => {
        "ID": id,
        "Front_Id": frontId,
        "Name": name,
      };
}
