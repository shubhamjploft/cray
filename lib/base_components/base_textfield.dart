import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../utils/base_colors.dart';

class BaseTextField extends StatelessWidget {
  final TextEditingController? controller;
  final bool? obscureText;
  final double? topMargin, bottomMargin, rightMargin, leftMargin;
  final String? hintText, labelText;
  final Color? fillColor;
  final Color? txtColor;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? textInputFormatter;
  final TextInputType? textInputType;
  final String? errorText, initialValue;
  final int? maxLine;
  final FocusNode? focusNode;
  final TextCapitalization? textCapitalization;
  final bool? underLine;
  final int? maxLength;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? suffixIcon;
  final double? borderRadius;
  final Color? borderColor;
  final Function()? onTap;
  final Function(String)? onChanged;
  final Widget? prefixIcon;
  final bool? readOnly, ignorePointers;
  final double? hintTxtSize;
  final String? Function(String?)? validator;
  final Color? hintTextColor;
  final bool? autofocus, isMandatory;


  const BaseTextField({
    super.key,
    this.controller,
    this.obscureText,
    this.labelText,
    required this.hintText,
    this.textInputAction,
    this.textInputType,
    this.textInputFormatter,
    this.suffixIcon,
    this.prefixIcon,
    this.errorText,
    this.borderRadius,
    this.fillColor,
    this.txtColor,
    this.borderColor,
    this.maxLine,
    this.contentPadding,
    this.hintTxtSize,
    this.onTap,
    this.readOnly,
    this.ignorePointers,
    this.hintTextColor,
    this.autofocus,
    this.textCapitalization,
    this.validator,
    this.maxLength,
    this.underLine = false,
    this.onChanged,
    this.focusNode,
    this.initialValue,
    this.topMargin,
    this.bottomMargin,
    this.rightMargin,
    this.leftMargin,
    this.isMandatory,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: controller ?? TextEditingController(),
            obscureText: obscureText ?? false,
            obscuringCharacter: "*",
            maxLines: maxLine ?? 1,
            onTap: onTap,
            focusNode: focusNode,
            readOnly: readOnly ?? false,
            ignorePointers: readOnly ?? false,
            textInputAction: textInputAction ?? TextInputAction.next,
            keyboardType: textInputType,
            inputFormatters: textInputFormatter,
            textCapitalization: textCapitalization ?? TextCapitalization.none,
            autofocus: autofocus ?? false,
            validator: validator,
            onChanged: onChanged,
            cursorColor: BaseColors.secondaryColor,
            maxLength: maxLength ?? 200,
            style: TextStyle(color: txtColor ?? Colors.black, fontSize: 15),
            decoration: InputDecoration(
              contentPadding: contentPadding ??
                  EdgeInsets.only(
                    top: 18,
                    bottom: 18,
                    left: prefixIcon != null ? 22 : 25,
                    right: 22.0,
                  ),
              label: labelText != ""
                  ? RichText(
                text: TextSpan(
                    text: labelText?.tr ?? "",
                    style:  TextStyle(
                        color: hintTextColor ?? BaseColors.hintClr, fontSize: 14,fontWeight:FontWeight.w400,),
                    children: [
                      if (isMandatory ?? false)
                        const TextSpan(
                            text: ' *',
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w300
                            ))
                    ]),
              )
                  : null,
              isDense: true,
              hintMaxLines: 1,
              hintText: hintText?.tr ?? "",
              errorText: errorText,
              counter: const SizedBox.shrink(),
              counterStyle:
              const TextStyle(fontSize: 0, color: Colors.transparent),
              counterText: "",
              semanticCounterText: "",
              suffixIconConstraints: const BoxConstraints(maxHeight: 58),
              prefixIconConstraints: const BoxConstraints(maxHeight: 58),
              hintStyle: TextStyle(
                  color: hintTextColor ?? BaseColors.hintClr,
                  fontSize: hintTxtSize ?? 15,
                  fontWeight: FontWeight.w400,fontFamily: 'poppins'),
              filled: true,
              fillColor:fillColor??BaseColors.white,
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,

              border: OutlineInputBorder(
                borderSide: BorderSide(
                    color: borderColor ?? const Color(0xffD1D1D1), width: 1.5),
                borderRadius:
                BorderRadius.all(Radius.circular(borderRadius ?? 0.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: borderColor ?? const Color(0xffD1D1D1), width: 1.5),
                borderRadius:
                BorderRadius.all(Radius.circular(borderRadius ?? 29)),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: borderColor ?? const Color(0xffD1D1D1), width: 1.5),
                borderRadius:
                BorderRadius.all(Radius.circular(borderRadius ?? 29)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: borderColor ?? const Color(0xffD1D1D1), width: 1.5),
                borderRadius:
                BorderRadius.all(Radius.circular(borderRadius ?? 29)),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red, width: 1.5),
                borderRadius:
                BorderRadius.all(Radius.circular(borderRadius ?? 29)),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: borderColor ?? const Color(0xffF5F4F8), width: 1.5),
                borderRadius:
                BorderRadius.all(Radius.circular(borderRadius ?? 29)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
