import 'package:flutter/material.dart';
import '../services/local/local_data_helper.dart';
import 'enum/app_mode.dart';

class UIColors {
  UIColors._();

  static final instance = UIColors._();

  bool get isNormalMode => LocalDataHelper.instance.getMode() == AppMode.normal.name;

  Color get primaryColor => isNormalMode ? const Color(0xFF005fff) : const Color(0xFF3382FF);

  Color get defaultColor => isNormalMode ? const Color(0xFF242442) : const Color(0xFFF2f2f2);

  Color get backgroundColor => isNormalMode ? const Color(0xFFf7fafc) : const Color(0xFF13132F);

  Color get lightBlueColor => isNormalMode ? const Color(0xFFe0ecff) : const Color(0xFFe0ecff);

  Color get accentOrangeColor => isNormalMode ? const Color(0xFFea580c) : const Color(0xFFea580c);

  Color get accentRedColor => isNormalMode ? const Color(0xFFdc2626) : const Color(0xFFdc2626);

  Color get accentGreenColor => isNormalMode ? const Color(0xFF22c55e) : const Color(0xFF22c55e);

  Color get accentYellowColor => isNormalMode ? const Color(0xFFeab308) : const Color(0xFFeab308);

  Color get blurBackgroundColor => isNormalMode ? const Color(0xe50a0a28) : const Color(0xe50a0a28);

  Color get whiteBlueColor => isNormalMode ? const Color(0xffE6EDFA) : const Color(0xffE6EDFA);

  Color get whiteColor => isNormalMode ? const Color(0xFFFFFFFF) : const Color(0xFF242442);

  Color get grayColor => isNormalMode ? const Color(0xFF6b6b81) : const Color(0xFF9999A9);
}
