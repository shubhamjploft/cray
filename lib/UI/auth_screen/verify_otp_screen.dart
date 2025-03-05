import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../base_components/base_button.dart';
import '../../base_components/base_scaffold_background.dart';
import '../../base_components/base_text.dart';
import '../../controller/verify_otp_controller.dart';
import '../../utils/base_assets.dart';
import '../../utils/base_colors.dart';
import '../../utils/base_functions.dart';

// ignore: must_be_immutable
class VerifyOtpScreen extends StatefulWidget {
  final AuthFlowType flowType;
    String email;
    VerifyOtpScreen({super.key, required this.flowType,required this.email});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  VerifyOtpController otpCtrl = Get.put(VerifyOtpController());

  int _counter = 30;
  late Timer _timer;
  bool resendStatus = false;

  @override
  void initState() {
    super.initState();
    init();
    WidgetsBinding.instance.addPostFrameCallback((Duration timer) {});
  }

  String getFormattedTimer() {
    return _counter.toString().padLeft(2, '0');
  }

  void init() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        _counter--;
        if (_counter == 0) {
          _timer.cancel();
          resendStatus = true;
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseColors.white,
      body: SizedBox.expand(
        child: BaseScaffoldBackground(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildSizeHeight(20),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: SvgPicture.asset(BaseAssets.backButtonIc),
                    ),
                    buildSizeHeight(40),
                    const BaseText(
                      value: "Enter\nOTP code",
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: BaseColors.black,
                    ),
                    buildSizeHeight(30),
                    const BaseText(
                      value: "Please enter the 6-digit OTP we have sent to your email abc@abc.com to verify your account.",
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: BaseColors.greyTextColor,
                    ),
                    buildSizeHeight(40),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Pinput(
                        controller: otpCtrl.otpController,
                        length: 6,
                        autofocus: true,
                        toolbarEnabled: true,
                        obscureText: false,
                        pinAnimationType: PinAnimationType.fade,
                        defaultPinTheme: defaultPinTheme.copyWith(
                          textStyle: const TextStyle(
                            fontSize: 20,
                            color: BaseColors.black,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: defaultPinTheme.decoration!.copyWith(
                            color: BaseColors.white,
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(color: BaseColors.textfieldBoarderClr, width: 1),
                          ),
                        ),
                        separatorBuilder: (index) => const SizedBox(width: 3),
                        onClipboardFound: (value) {
                          debugPrint('onClipboardFound: $value');
                        },
                        hapticFeedbackType: HapticFeedbackType.lightImpact,
                        onChanged: (value) {
                          debugPrint('onChanged: $value');
                        },
                        cursor: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 2,
                              height: 20,
                              color: BaseColors.black,
                            ),
                          ],
                        ),
                        focusedPinTheme: defaultPinTheme.copyWith(
                          textStyle: const TextStyle(
                            fontSize: 20,
                            color: BaseColors.black,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: defaultPinTheme.decoration!.copyWith(
                            borderRadius: BorderRadius.circular(100),
                            color: BaseColors.white,
                            border: Border.all(color: BaseColors.textfieldBoarderClr, width: 1),
                          ),
                        ),
                        submittedPinTheme: defaultPinTheme.copyWith(
                          textStyle: const TextStyle(
                            fontSize: 20,
                            color: BaseColors.black,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: defaultPinTheme.decoration!.copyWith(
                            color: BaseColors.white,
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(color: BaseColors.textfieldBoarderClr, width: 1),
                          ),
                        ),
                        errorPinTheme: defaultPinTheme.copyBorderWith(
                          border: Border.all(color: BaseColors.textfieldBoarderClr),
                        ),
                      ),
                    ),
                    buildSizeHeight(150),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const BaseText(
                          value: "Didn’t receive the OTP?",
                          fontWeight: FontWeight.w400,
                          color: BaseColors.darkGreyBox,
                        ),
                        buildSizeWidth(5),
                        if(!resendStatus)
                         BaseText(
                          value: "00:${getFormattedTimer()}s",
                          fontWeight: FontWeight.w500,
                          color: BaseColors.redClr,
                        ),
                      ],
                    ),
                    buildSizeHeight(20),
                     Center(
                      child: BaseText(
                        onTap: () {
                              if(resendStatus)
                              {
                                otpCtrl.resendOtp(isEmail: widget.email);
                                if (resendStatus) {
                                  resendStatus = false;
                                  _counter = 30;
                                  init();
                                }
                              }
                            },
                        value: "Resend OTP",
                        fontWeight: FontWeight.w500,
                        color: BaseColors.redClr,
                        showUnderline: true,
                      ),
                    ),
                    buildSizeHeight(40),
                    Obx(() {
                      return BaseButton(
                        title: "Continue",
                        btnColor: otpCtrl.otp.value.length == 6 ? BaseColors.black : Colors.grey,
                        onPressed: () {
                          if (otpCtrl.otp.value.length == 6) {
                            otpCtrl.verifyOtpApi(widget.flowType, isEmail: widget.email.toString());

                          }
                        },
                      );
                    }),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

PinTheme defaultPinTheme = PinTheme(
  width: 54,
  height: 54,
  textStyle: const TextStyle(
    fontSize: 20,
    color: BaseColors.black,
    fontWeight: FontWeight.w500,
  ),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(100),
    border: Border.all(color: BaseColors.greyTextColor, width: 2),
  ),
);