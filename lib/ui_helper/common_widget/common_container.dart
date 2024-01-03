import 'package:flutter/material.dart';
import 'package:shovving_pre/ui_helper/theme/custom_color.dart';

class CommonContainer extends Container {
  final double? width;
  final double? height;
  final double? radius;
  final Color? containerColor;
  final Color? borderColor;
  final double? borderWidth;
  CommonContainer({super.key,this.width, this.height, this.radius, this.containerColor, this.borderColor,this.borderWidth, super.child})
      : super(
    width: width,
    height: height,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(radius??12),
      color: containerColor ?? CColor.lightGray,
      border: Border.all(color: borderColor ?? containerColor ?? CColor.lightGray, width: borderWidth??1),
    ),
  );
}
