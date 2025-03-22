import 'package:flutter/material.dart';
import 'package:task_manager_app/common/styles.dart';

import 'colors.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    this.title,
    this.widget,
    required this.onPressed,
    this.enabled = true,
    this.isLoading = false,
    this.buttonColor,
    this.textColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 24),
    this.height = 50,
    this.width,
    this.radius = 24,
  });

  final String? title;
  final Widget? widget;
  final bool enabled;
  final void Function() onPressed;
  final Color? buttonColor;
  final Color? textColor;
  final EdgeInsetsGeometry padding;
  final bool isLoading;
  final double height;
  final double? width;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final buttonColor = this.buttonColor ?? UIColors.instance.primaryColor;
    return _RenderButton(
      title: title,
      widget: widget,
      onPressed: onPressed,
      enabled: enabled,
      buttonColor: buttonColor,
      textColor: textColor ?? UIColors.instance.defaultColor,
      padding: padding,
      isLoading: isLoading,
      height: height,
      width: width,
      radius: radius,
    );
  }
}

class _RenderButton extends StatelessWidget {
  _RenderButton({
    this.title,
    this.widget,
    required this.onPressed,
    this.enabled = true,
    this.buttonColor,
    this.textColor,
    this.padding = const EdgeInsets.all(13),
    this.isLoading = false,
    this.height,
    this.width,
    this.radius = 6,
  });

  final String? title;
  final Widget? widget;
  final bool enabled;
  final void Function() onPressed;
  final Color? buttonColor;
  final Color? textColor;
  final EdgeInsetsGeometry padding;
  final bool isLoading;
  final double? height;
  final double? width;
  final double radius;

  late final Widget button = MaterialButton(
    onPressed: enabled
        ? () {
            if (!isLoading) {
              FocusManager.instance.primaryFocus?.unfocus();
              onPressed();
            }
          }
        : null,
    padding: padding,
    color: buttonColor ?? UIColors.instance.primaryColor,
    disabledColor: Colors.grey,
    splashColor: enabled ? null : Colors.transparent,
    highlightColor: enabled ? null : Colors.transparent,
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
    child: isLoading
        ? _defaultLoadingWidget
        : widget ??
            Text(
              title ?? "",
              textAlign: TextAlign.center,
              style: UITextStyle.medium.copyWith(
                color: enabled ? textColor ?? UIColors.instance.defaultColor : Colors.white70,
                fontSize: 16,
                height: 1.2,
              ),
            ),
  );

  @override
  Widget build(BuildContext context) {
    if (height == null) {
      return SizedBox(
        width: width,
        child: button,
      );
    }
    return SizedBox(height: height, width: width, child: button);
  }
}

Widget _defaultLoadingWidget = const SizedBox(
  width: 20,
  height: 20,
  child: RepaintBoundary(
    child: CircularProgressIndicator(
      color: Colors.white,
      strokeWidth: 3.5,
    ),
  ),
);

class SplashButton extends StatelessWidget {
  final Widget child;
  final BorderRadius? borderRadius;
  final Color highlightColor;
  final Color hoverColor;
  final GestureTapCallback? onTap;
  final bool isDisabled;

  const SplashButton({
    super.key,
    required this.child,
    this.borderRadius,
    this.highlightColor = Colors.white54,
    this.hoverColor = Colors.white54,
    this.isDisabled = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (isDisabled) return child;

    return Stack(
      children: [
        child,
        Positioned.fill(
          child: Material(
            borderRadius: borderRadius,
            clipBehavior: Clip.hardEdge,
            color: Colors.transparent,
            child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: highlightColor,
              hoverColor: hoverColor,
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
                onTap?.call();
              },
            ),
          ),
        ),
      ],
    );
  }
}

class AppOutlinedButton extends StatelessWidget {
  const AppOutlinedButton({
    super.key,
    this.title = '',
    this.child,
    required this.onPressed,
    this.enabled = true,
    this.borderColor,
    this.disabledBorderColor,
    this.textColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 12),
    this.backgroundColor,
    this.splashColor = Colors.white24,
    this.height = 50,
    this.borderRadius,
    this.isLoading = false,
    this.borderWidth = 2,
    this.textStyle,
  });

  final String title;
  final Widget? child;
  final bool enabled;
  final void Function() onPressed;
  final Color? borderColor;
  final Color? disabledBorderColor;
  final Color? textColor;
  final Color? backgroundColor;
  final Color splashColor;
  final EdgeInsetsGeometry padding;
  final BorderRadiusGeometry? borderRadius;
  final double height;
  final bool isLoading;
  final double borderWidth;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: enabled
          ? () {
              if (!isLoading) {
                onPressed.call();
              }
            }
          : null,
      style: OutlinedButton.styleFrom(
        foregroundColor: splashColor,
        backgroundColor: backgroundColor ?? Colors.white,
        padding: padding,
        side: BorderSide(
          width: borderWidth,
          color: enabled ? borderColor ?? Colors.grey : disabledBorderColor ?? Colors.grey,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(6),
        ),
        fixedSize: Size.fromHeight(height),
      ),
      child: isLoading
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(
                    color: UIColors.instance.primaryColor,
                    strokeWidth: 3.5,
                  ),
                )
              ],
            )
          : child ??
              Text(
                title,
                style: textStyle?.copyWith(
                      color: textColor ?? UIColors.instance.defaultColor,
                    ) ??
                    UITextStyle.medium.copyWith(
                      color: textColor ?? UIColors.instance.defaultColor,
                      fontSize: 16,
                      height: 1.2,
                    ),
              ),
    );
  }
}
