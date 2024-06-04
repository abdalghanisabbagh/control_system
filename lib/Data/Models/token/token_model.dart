class TokenModel {
  TokenModel({
    required this.aToken,
    required this.dToken,
    required this.rToken,
  });

  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(
      aToken: json['aToken'],
      dToken: json['dToken'],
      rToken: json['rToken'],
    );
  }

  final String aToken;
  final String dToken;
  final String rToken;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['aToken'] = aToken;
    data['dToken'] = dToken;
    data['rToken'] = rToken;
    return data;
  }
}
