import 'package:json_annotation/json_annotation.dart';

part 'LoginResponse.g.dart';

@JsonSerializable()
class LoginResponse {
  @JsonKey(name: 'refreshToken')
  String refreshToken;
  @JsonKey(name: 'accessToken')
  String accessToken;

  @JsonKey(name: 'userProfile')
  UserProfile? profile;

  LoginResponse(
      {required this.accessToken, required this.refreshToken, this.profile});

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

class UserProfile {
  String userFullName;
  String? isFloorManager;
  int type;
  UserProfile({
    required this.userFullName,
    this.isFloorManager,
    required this.type,
  });
  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        type: json['type'],
        userFullName: json['UserFullName'],
        isFloorManager: json['IsFloorManager'],
      );
}
