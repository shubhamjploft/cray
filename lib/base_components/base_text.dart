import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/base_colors.dart';
import '../utils/base_functions.dart';

class BaseText extends StatelessWidget {
  final String value;
  final double? fontSize,
      height,
      topMargin,
      bottomMargin,
      leftMargin,
      rightMargin;
  final double? onTapTopPadding,
      onTapBottomPadding,
      onTapLeftPadding,
      onTapRightPadding;
  final Color? color;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final int? maxLines;
  final bool? enableHapticFeedback, hideKeyboard, lineThrough;
  final void Function()? onTap;
  final TextOverflow? overflow;
  final FontStyle? fontStyle;
  final String? fontFamily;
  final double? letterSpacing;
  final bool? showUnderline;

  const BaseText({
    super.key,
    required this.value,
    this.fontSize,
    this.color,
    this.fontWeight,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.topMargin,
    this.bottomMargin,
    this.leftMargin,
    this.rightMargin,
    this.height,
    this.onTap,
    this.onTapTopPadding,
    this.onTapBottomPadding,
    this.onTapLeftPadding,
    this.onTapRightPadding,
    this.enableHapticFeedback,
    this.hideKeyboard,
    this.lineThrough,
    this.fontStyle,
    this.fontFamily,
    this.letterSpacing,
    this.showUnderline,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: topMargin ?? 0,
        bottom: bottomMargin ?? 0,
        right: rightMargin ?? 0,
        left: leftMargin ?? 0,
      ),
      child: GestureDetector(
        onTap: onTap != null
            ? () {
          if (enableHapticFeedback ?? true) {
            triggerHapticFeedback();
          }
          if (hideKeyboard ?? true) {
            FocusManager.instance.primaryFocus?.unfocus();
          }
          onTap!();
        }
            : null,
        child: Padding(
          padding: EdgeInsets.only(
            top: onTapTopPadding ?? 0,
            bottom: onTapBottomPadding ?? 0,
            right: onTapRightPadding ?? 0,
            left: onTapLeftPadding ?? 0,
          ),
          child: Text(
            value.tr,
            textAlign: textAlign ?? TextAlign.start,
            maxLines: maxLines,
            overflow: overflow,
            style: TextStyle(
              fontSize: fontSize ?? 14,
              height: height,
              color: color ?? Colors.black,
              fontFamily: fontFamily ?? "Poppins",
              letterSpacing: letterSpacing ?? 0,
              fontStyle: fontStyle ?? FontStyle.normal,
              fontWeight: fontWeight ?? FontWeight.w400,
              decoration: (lineThrough ?? false)
                  ? TextDecoration.lineThrough
                  : (showUnderline == true)
                  ? TextDecoration.underline
                  : TextDecoration.none,
              decorationColor: BaseColors.black,
            ),
          ),
        ),
      ),
    );
  }
}
