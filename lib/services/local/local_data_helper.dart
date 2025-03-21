import 'package:shared_preferences/shared_preferences.dart';

import '../../common/enum/app_mode.dart';

class LocalDataHelper {
  final String _keyMode = "_keyMode";

  LocalDataHelper._();

  static final instance = LocalDataHelper._();

  late SharedPreferences sharedPreferences;

  init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> setMode(String value) async {
    await sharedPreferences.setString(_keyMode, value);
  }

  String getMode() {
    return sharedPreferences.getString(_keyMode) ?? AppMode.normal.name;
  }

  Future<bool> removeMode() async {
    return await sharedPreferences.remove(_keyMode);
  }
}
