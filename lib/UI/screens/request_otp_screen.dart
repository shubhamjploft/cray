import 'package:cray/UI/auth_screen/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../base_components/base_button.dart';
import '../../base_components/base_scaffold_background.dart';
import '../../base_components/base_text.dart';
import '../../base_components/base_textfield.dart';
import '../../controller/request_otp_controller.dart';
import '../../utils/base_assets.dart';
import '../../utils/base_colors.dart';
import '../../utils/base_functions.dart';

class RequestOtpScreen extends StatefulWidget {
  final AuthFlowType flowType;
  const RequestOtpScreen({super.key, required this.flowType});

  @override
  State<RequestOtpScreen> createState() => _RequestOtpScreenState();
}

class _RequestOtpScreenState extends State<RequestOtpScreen> {
  RequestOtpController requestOtpCtrl = Get.put(RequestOtpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseColors.white,
      body: BaseScaffoldBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: requestOtpCtrl.formKeyRequestOtp,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildSizeHeight(20),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: SvgPicture.asset(
                      BaseAssets.backButtonIc,
                    ),
                  ),
                  buildSizeHeight(40),
                  Center(
                    child: SvgPicture.asset(
                      BaseAssets.lockIc,
                    ),
                  ),
                  buildSizeHeight(30),
                  const BaseText(
                    value: "Let’s Help You Get Back In!",
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: BaseColors.black,
                  ),
                  buildSizeHeight(30),
                  BaseTextField(
                    labelText: '',
                    hintText: 'Email address',
                    controller: requestOtpCtrl.emailOtpController,
                    textInputType: TextInputType.emailAddress,
                    textCapitalization: TextCapitalization.words,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: SvgPicture.asset(
                        BaseAssets.emailIc,
                      ),
                    ),
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return "Please enter an email address";
                      }
                      if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(val)) {
                        return "Please enter a valid email address";
                      }
                      return null;
                    },

                  ),
                  const Spacer(),
                  Column(
                    children: [
                      BaseButton(
                        title: "Request OTP",
                        onPressed: () {
                          if (requestOtpCtrl.formKeyRequestOtp.currentState
                                  ?.validate() ??
                              false) {
                            requestOtpCtrl.changePassword(widget.flowType);
                            // Get.to(() => VerifyOtpScreen(flowType: widget.flowType));
                        }},
                      ),
                      buildSizeHeight(30),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => const SignupScreen());
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BaseText(
                              value: "Don’t have an account?",
                              fontSize: 15,
                            ),
                            BaseText(
                              value: " Sign up",
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: BaseColors.redClr,
                            ),
                          ],
                        ),
                      ),
                      buildSizeHeight(30),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
