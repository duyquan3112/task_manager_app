import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

class AppImage extends StatelessWidget {
  const AppImage.asset({
    super.key,
    required this.asset,
    this.width = 0,
    this.height = 0,
    this.fit = BoxFit.cover,
    this.borderRadius = BorderRadius.zero,
    this.color,
    this.alignment,
  });

  /// Source
  final String? asset;

  /// Properties
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius borderRadius;
  final Color? color;
  final AlignmentGeometry? alignment;

  @override
  Widget build(BuildContext context) {
    if (asset != null) {
      return _buildAsset();
    }
    return const SizedBox();
  }

  _buildAsset() {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Image.asset(
        "assets/images/$asset.png",
        height: height == 0 ? null : height,
        width: width == 0 ? null : width,
        fit: fit,
        color: color,
        alignment: alignment ?? Alignment.center,
        errorBuilder: (_, __, ___) {
          return Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              color: UIColors.instance.primaryColor,
              borderRadius: borderRadius,
            ),
          );
        },
      ),
    );
  }
}
