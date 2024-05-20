import '../../base_model.dart';
import 'user_profile.dart';

class LoginResponseModel extends BaseModel {
  String? refreshToken;
  String? accessToken;
  UserProfile? userProfile;

  LoginResponseModel({this.refreshToken, this.accessToken, this.userProfile});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    refreshToken = json['refreshToken'];
    accessToken = json['accessToken'];
    userProfile = json['userProfile'] != null
        ? UserProfile.fromJson(json['userProfile'])
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
