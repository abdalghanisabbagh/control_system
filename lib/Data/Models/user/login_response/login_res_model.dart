import 'user_profile_model.dart';

class LoginResModel {
  String? refreshToken;
  String? accessToken;
  UserProfileModel? userProfile;

  LoginResModel({
    this.refreshToken,
    this.accessToken,
    this.userProfile,
  });

  LoginResModel.fromJson(Map<String, dynamic> json) {
    refreshToken = json['refreshToken'];
    accessToken = json['accessToken'];
    userProfile = json['userProfile'] != null
        ? UserProfileModel.fromJson(json['userProfile'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['refreshToken'] = refreshToken;
    data['accessToken'] = accessToken;
    if (userProfile != null) {
      data['userProfile'] = userProfile!.toJson();
    }
    return data;
  }
}