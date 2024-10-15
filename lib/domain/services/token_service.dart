import 'dart:convert';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../Data/Models/token/token_model.dart';

class TokenService extends GetxController {
  TokenModel? _tokenModel;

  TokenModel? get tokenModel => _tokenModel ?? getTokenModelFromHiveBox();

  /// Deletes the token model from the Hive box and clears the cached token model.
  ///
  /// This function should be called when the user logs out of the application.
  /// It will delete the token model from the Hive box and clear the cached token model.
  ///
  /// The function is asynchronous and returns a [Future] that completes when the
  /// operation is finished. The function does not return any value.
  ///
  /// The function will also notify the UI to rebuild using the [update] method.
  Future<void> deleteTokenModelFromHiveBox() async {
    _tokenModel = null;
    await Hive.box('Token').clear();
  }

  /// Retrieves the token model from the Hive box and assigns it to [_tokenModel].
  ///
  /// The function checks whether the 'Token' key exists in the Hive box. If it
  /// does, the function will decode the JSON string stored in the box and convert
  /// it to a [TokenModel] object. If not, the function will set [_tokenModel] to
  /// null.
  ///
  /// The function will return the [_tokenModel] after retrieving it from the Hive
  /// box.
  TokenModel? getTokenModelFromHiveBox() {
    _tokenModel = Hive.box('Token').containsKey('Token')
        ? TokenModel.fromJson(jsonDecode(Hive.box('Token').get('Token')))
        : null;
    return _tokenModel;
  }

  /// Saves a new access token to the Hive box and updates the [_tokenModel] with
  /// the new access token.
  ///
  /// The function takes a [TokenModel] object as a parameter which contains the
  /// new access token.
  ///
  /// The function will create a new [TokenModel] object with the new access token
  /// and the current time as the created at time. The function will then put the
  /// new [TokenModel] object to the Hive box with the key 'Token'. The function
  /// will also update the [_tokenModel] with the new [TokenModel] object.
  ///
  /// The function is asynchronous and returns a [Future] that completes when the
  /// operation is finished. The function does not return any value.
  Future<void> saveNewAccessToken(TokenModel tokenModel) async {
    _tokenModel = tokenModel.copyWith(
      createdAt: DateTime.now(),
    );
    Hive.box('Token').put('Token', jsonEncode(_tokenModel!.toJson()));
  }

  /// Saves the given [TokenModel] to the Hive box and updates the [_tokenModel] with
  /// the new [TokenModel] object.
  ///
  /// The function takes a [TokenModel] object as a parameter which contains the
  /// new access token.
  ///
  /// The function will create a new [TokenModel] object with the new access token
  /// and the current time as the created at time. The function will then put the
  /// new [TokenModel] object to the Hive box with the key 'Token'. The function
  /// will also update the [_tokenModel] with the new [TokenModel] object.
  void saveTokenModelToHiveBox(TokenModel tokenModel) {
    _tokenModel = tokenModel.copyWith(
      createdAt: DateTime.now(),
    );
    Hive.box('Token').put('Token', jsonEncode(_tokenModel!.toJson()));
  }
}
