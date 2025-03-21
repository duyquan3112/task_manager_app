import 'package:flutter/material.dart';
import '../services/local/local_data_helper.dart';
import 'enum/app_mode.dart';

class UIColors {
  UIColors._();

  static final instance = UIColors._();

  bool get isNormalMode => LocalDataHelper.instance.getMode() == AppMode.normal.name;

  Color get primaryColor => isNormalMode ? const Color(0xFF005fff) : const Color(0xFF3382FF);

  Color get defaultColor => isNormalMode ? const Color(0xFF242442) : const Color(0xFFF2f2f2);

  Color get backgroundColor => isNormalMode ? const Color(0xFFf2f2f2) : const Color(0xFF13132F);

  Color get lightBlueColor => isNormalMode ? const Color(0xFFe0ecff) : const Color(0xFFe0ecff);
}
