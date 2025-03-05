import 'package:flutter/material.dart';

import '../utils/base_colors.dart';
import '../utils/base_functions.dart';
import 'base_text.dart';


class BaseButton extends StatelessWidget {
  final String title;
  final double? btnHeight, btnWidth;
  final double? borderRadius, fontSize;
  final double? bottomMargin, topMargin, rightMargin, leftMargin;
  final EdgeInsetsGeometry? padding;
  final Color? btnColor;
  final Color? borderColor;
  final Color? btnTextColor;
  final bool? enableHapticFeedback, hideKeyboard, borderEnable;
  final void Function()? onPressed;

  const BaseButton({
    super.key,
    required this.title,
    this.btnHeight,
    this.btnWidth,
    this.btnColor,
    this.onPressed,
    this.bottomMargin,
    this.topMargin,
    this.rightMargin,
    this.leftMargin,
    this.enableHapticFeedback,
    this.hideKeyboard,
    this.padding,
    this.borderRadius,
    this.fontSize,
    this.btnTextColor,
    this.borderEnable = false,
    this.borderColor = BaseColors.greyTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          right: rightMargin ?? 0,
          left: leftMargin ?? 0,
          top: topMargin ?? 0,
          bottom: bottomMargin ?? 0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(btnWidth ?? double.infinity, btnHeight ?? 56),
          backgroundColor: !borderEnable! ? btnColor ?? BaseColors.black : btnColor,
          foregroundColor: btnColor ?? BaseColors.black,
          disabledBackgroundColor: btnColor ?? BaseColors.black,
          disabledForegroundColor: btnColor ?? BaseColors.black,
          elevation: 0,
          padding: padding,
          shape: RoundedRectangleBorder(
            side: borderEnable! ? BorderSide(color: borderColor ?? BaseColors.greyTextColor,width: 1.0) : BorderSide.none,
            borderRadius: BorderRadius.circular(borderRadius ?? 30),
          ),
        ),
        onPressed: () {
          if (enableHapticFeedback ?? true) {
            triggerHapticFeedback();
          }
          if (hideKeyboard ?? true) {
            FocusManager.instance.primaryFocus?.unfocus();
          }
          if (onPressed != null) {
            onPressed!();
          }
        },
        child: AbsorbPointer(
          child: BaseText(
            value: title,
            color: btnTextColor ?? Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: fontSize ?? 18,
          ),
        ),
      ),
    );
  }
}
