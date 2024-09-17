class TokenModel {
  final String aToken;

  final String rToken;

  TokenModel({
    required this.aToken,
    required this.rToken,
  });
  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(
      aToken: json['aToken'],
      rToken: json['rToken'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['aToken'] = aToken;
    data['rToken'] = rToken;
    return data;
  }
}
