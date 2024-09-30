class TokenModel {
  final String aToken;

  final String rToken;

  final DateTime? createdAt;

  TokenModel({
    required this.aToken,
    required this.rToken,
    this.createdAt,
  });
  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(
      aToken: json['aToken'],
      rToken: json['rToken'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
    );
  }

  TokenModel copyWith({
    String? aToken,
    String? rToken,
    DateTime? createdAt,
  }) {
    return TokenModel(
      aToken: aToken ?? this.aToken,
      rToken: rToken ?? this.rToken,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['aToken'] = aToken;
    data['rToken'] = rToken;
    data['createdAt'] = createdAt?.toIso8601String();
    return data;
  }
}
