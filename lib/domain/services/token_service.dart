import 'package:control_system/Data/Models/token/token_model.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TokenService extends GetxController {
  TokenModel? _tokenModel;

  TokenModel? get tokenModel => _tokenModel ?? getTokenModelFromHiveBox();

  void saveTokenModelToHiveBox(TokenModel tokenModel) {
    Hive.box('Token').put("JsonTokenModel", tokenModel.toJson());
  }

  TokenModel? getTokenModelFromHiveBox() {
    _tokenModel = Hive.box('Token').containsKey('JsonTokenModel')
        ? TokenModel.fromJson(Hive.box('Token').get('JsonTokenModel'))
        : null;
    return _tokenModel;
  }
}
