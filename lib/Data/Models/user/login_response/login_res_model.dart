import 'user_profile_model.dart';

class LoginResModel {
  LoginResModel({
    this.refreshToken,
    this.accessToken,
    this.userProfile,
  });

  LoginResModel.fromJson(json) {
    refreshToken = json['refreshToken'];
    accessToken = json['accessToken'];
    userProfile = json['userProfile'] != null
        ? UserProfileModel.fromJson(json['userProfile'])
        : null;
  }

  String? accessToken;
  String? refreshToken;
  UserProfileModel? userProfile;

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
