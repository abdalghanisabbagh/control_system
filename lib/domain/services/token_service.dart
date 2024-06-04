import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../Data/Models/token/token_model.dart';

class TokenService extends GetxController {
  TokenModel? _tokenModel;

  TokenModel? get tokenModel => _tokenModel ?? getTokenModelFromHiveBox();

  Future<void> saveNewAccessToken(String newAccessToken) async {
    _tokenModel = tokenModel;
    await Hive.box('Token').put('aToken', newAccessToken);
    await Hive.box('Token').put('dToken', DateTime.now().toIso8601String());
    await Hive.box('Token').flush();
  }

  void saveTokenModelToHiveBox(TokenModel tokenModel) {
    Hive.box('Token').putAll(tokenModel.toJson());
  }

  TokenModel? getTokenModelFromHiveBox() {
    _tokenModel = Hive.box('Token').containsKey('aToken')
        ? TokenModel(
            aToken: Hive.box('Token').get('aToken'),
            rToken: Hive.box('Token').get('rToken'),
            dToken: Hive.box('Token').get('dToken'),
          )
        : null;
    return _tokenModel;
  }

  Future<void> deleteTokenModelFromHiveBox() async {
    await Hive.box('Token').clear();
  }
}
