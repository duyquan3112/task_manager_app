import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:task_manager_app/common/styles.dart';

import 'colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
    this.backgroundColor = Colors.transparent,
    this.barrierBackgroundColor = Colors.transparent,
    this.isFullScreen = false,
    this.loadingBuilder,
  })  : isDark = false,
        showText = false,
        text = null;

  LoadingWidget.dark({
    super.key,
    this.barrierBackgroundColor = Colors.transparent,
    this.isFullScreen = false,
    this.loadingBuilder,
    this.text,
  })  : isDark = true,
        showText = true,
        backgroundColor = UIColors.instance.blurBackgroundColor;

  const LoadingWidget.withoutText({
    super.key,
    this.backgroundColor = Colors.transparent,
    this.barrierBackgroundColor = Colors.transparent,
    this.isFullScreen = false,
    this.loadingBuilder,
  })  : isDark = false,
        showText = false,
        text = null;

  final bool isDark;
  final bool showText;
  final Color backgroundColor;
  final Color barrierBackgroundColor;
  final bool isFullScreen;
  final Widget Function()? loadingBuilder;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              color: barrierBackgroundColor,
            ),
          ),
        ),
        if (loadingBuilder != null) ...[
          loadingBuilder!(),
        ],
        if (loadingBuilder == null) ...[
          Container(
            alignment: isFullScreen ? null : const FractionalOffset(0.5, 0.5),
            child: Container(
              width: isFullScreen ? double.infinity : null,
              height: isFullScreen ? double.infinity : null,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: isFullScreen ? null : BorderRadius.circular(16),
              ),
              child: Material(
                elevation: 0,
                color: Colors.transparent,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 56,
                      height: 56,
                      child: Lottie.asset(
                        'assets/jsons/loading_animation.json',
                        height: 56,
                        width: 56,
                        fit: BoxFit.cover,
                      ),
                    ),
                    if (showText)
                      const SizedBox(
                        height: 16,
                      ),
                    if (showText)
                      Text(
                        text ?? "System is loading...\nPlease don't exit!",
                        textAlign: TextAlign.center,
                        style: UITextStyle.regular.copyWith(
                          fontSize: 16,
                          color: isDark ? UIColors.instance.whiteBlueColor : UIColors.instance.defaultColor,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
