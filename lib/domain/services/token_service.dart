import 'dart:convert';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../Data/Models/token/token_model.dart';

class TokenService extends FullLifeCycleController with FullLifeCycleMixin {
  TokenModel? _tokenModel;

  TokenModel? get tokenModel => _tokenModel ?? getTokenModelFromHiveBox();

  Future<void> deleteTokenModelFromHiveBox() async {
    _tokenModel = null;
    await Hive.box('Token').clear();
  }

  TokenModel? getTokenModelFromHiveBox() {
    _tokenModel = Hive.box('Token').containsKey('Token')
        ? TokenModel.fromJson(jsonDecode(Hive.box('Token').get('Token')))
        : null;
    return _tokenModel;
  }

  @override
  void onDetached() {}

  @override
  void onHidden() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {}

  Future<void> saveNewAccessToken(TokenModel tokenModel) async {
    _tokenModel = tokenModel;
    Hive.box('Token').put('Token', jsonEncode(tokenModel.toJson()));
  }

  void saveTokenModelToHiveBox(TokenModel tokenModel) {
    Hive.box('Token').put('Token', jsonEncode(tokenModel.toJson()));
  }
}
