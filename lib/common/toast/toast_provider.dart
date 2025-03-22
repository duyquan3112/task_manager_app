import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../colors.dart';
import '../styles.dart';
import '../utils/text_util.dart';

class ToastProvider {
  ToastProvider._();

  static final ToastProvider instance = ToastProvider._();

  final FToast _toast = FToast();

  show({
    required BuildContext context,
    required String message,
    Color? textColor,
    Color? backgroundColor,
    Duration duration = const Duration(seconds: 1),
    ToastGravity gravity = ToastGravity.TOP,
  }) {
    _toast
      ..init(context)
      ..removeQueuedCustomToasts()
      ..showToast(
        gravity: gravity,
        toastDuration: duration,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: backgroundColor ?? UIColors.instance.blurBackgroundColor,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            message,
            style: UITextStyle.regular.copyWith(
              color: textColor ?? Colors.white,
            ),
          ),
        ),
      );
  }

  showSuccess({
    required BuildContext context,
    required String message,
  }) {
    show(
      context: context,
      message: message,
      textColor: Colors.white,
      backgroundColor: UIColors.instance.accentGreenColor,
    );
  }

  showFailure({
    required BuildContext context,
    required String message,
  }) {
    show(
      context: context,
      message: message,
      textColor: Colors.white,
      backgroundColor: UIColors.instance.accentRedColor,
    );
  }

  display(String? message) {
    if (TextUtils.isEmpty(message)) {
      return;
    }
    Fluttertoast.cancel().whenComplete(() {
      Fluttertoast.showToast(
        msg: message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 13,
      );
    });
  }
}
