import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../services/local/local_data_helper.dart';

class GeneralConfig {
  GeneralConfig._();

  static init() async {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ));
    await LocalDataHelper.instance.init();
  }
}
