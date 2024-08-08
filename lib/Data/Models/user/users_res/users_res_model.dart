import 'package:control_system/Data/Models/user/users_res/user_res_model.dart';
import 'package:flutter/material.dart';

class UsersResModel {
  List<UserResModel>? users;

  UsersResModel({this.users});

  UsersResModel.fromJson(json) {
    users = List<UserResModel>.from(
        json.map((e) => UserResModel.fromJson(e)).toList());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (users != null) {
      data['data'] = users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
