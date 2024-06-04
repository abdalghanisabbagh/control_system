import '../login_response/user_profile_model.dart';

class UsersResModel {
  UsersResModel({
    required this.data,
  });

  UsersResModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <UserProfileModel>[];
      json['data'].forEach((v) {
        data.add(UserProfileModel.fromJson(v));
      });
    }
  }

  late final List<UserProfileModel> data;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = this.data.map((v) => v.toJson()).toList();
    return data;
  }
}
