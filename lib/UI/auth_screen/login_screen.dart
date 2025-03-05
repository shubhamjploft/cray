import 'package:cray/UI/screens/request_otp_screen.dart';
import 'package:cray/UI/auth_screen/signup_screen.dart';
import 'package:cray/controller/login_controller.dart';
import 'package:cray/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../base_components/base_button.dart';
import '../../base_components/base_scaffold_background.dart';
import '../../base_components/base_text.dart';
import '../../base_components/base_textfield.dart';
import '../../utils/base_assets.dart';
import '../../utils/base_colors.dart';

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKeyLogin = GlobalKey<FormState>();
  LoginController loginCtrl = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseColors.white,
      body: BaseScaffoldBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Form(
                key: formKeyLogin,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildSizeHeight(60),
                    const BaseText(
                      value: "Welcome to Cray",
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: BaseColors.greyTextColor,
                    ),
                    const BaseText(
                      value: "Let's get you\nstarted.",
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: BaseColors.black,
                    ),
                    buildSizeHeight(40),
                    BaseTextField(
                      labelText: '',
                      hintText: 'Email address',
                      controller: loginCtrl.emailController,
                      textCapitalization: TextCapitalization.words,
                      textInputType: TextInputType.emailAddress,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: SvgPicture.asset(
                          BaseAssets.emailIc,
                        ),
                      ),
                      validator: (val) {
                        String email = loginCtrl.emailController.text.trim();
                        if (email.isEmpty) {
                          return "Please enter an email address";
                        }
                        bool isValidEmail = RegExp(
                                r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                            .hasMatch(email);

                        if (!isValidEmail) {
                          return "Please enter a valid email address";
                        }

                        return null;
                      },
                    ),
                    buildSizeHeight(20),
                    BaseTextField(
                      labelText: '',
                      hintText: 'Password',
                      controller: loginCtrl.passwordController,
                      textCapitalization: TextCapitalization.words,
                      textInputType: TextInputType.name,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: SvgPicture.asset(
                          BaseAssets.lockAPasswordIc,
                        ),
                      ),
                      validator: (String? val) {
                        if (val == null || val.trim().isEmpty) {
                          return "Please enter a password";
                        }
                        if (val.length < 6) {
                          return "Password must be at least 6 characters long";
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Obx(() {
                              return customCheckBox(
                                value: loginCtrl.isRememberMe.value,
                                onChanged: (value) {
                                  loginCtrl.isRememberMe.value = value ?? false;
                                },
                              );
                            }),
                            buildSizeWidth(10),
                            const BaseText(
                              value: "Remember me",
                              fontSize: 14,
                            ),
                            const Spacer(),
                            BaseText(
                              value: "Forgot Password?",
                              color: BaseColors.redClr,
                              onTap: () {
                                Get.to(() => const RequestOtpScreen(
                                    flowType: AuthFlowType.forgotPassword));
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    buildSizeHeight(20),
                    Container(
                      height: 50,
                      width: double.maxFinite,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          color: BaseColors.white,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                              color: BaseColors.textfieldBoarderClr)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            BaseAssets.appleIc,
                          ),
                          buildSizeWidth(10),
                          const BaseText(
                            value: "Continue with Apple",
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          )
                        ],
                      ),
                    ),
                    buildSizeHeight(15),
                    Container(
                      height: 50,
                      width: double.maxFinite,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          color: BaseColors.white,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                              color: BaseColors.textfieldBoarderClr)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            BaseAssets.fcIc,
                          ),
                          buildSizeWidth(10),
                          const BaseText(
                            value: "Continue With Facebook",
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          )
                        ],
                      ),
                    ),
                    buildSizeHeight(15),
                    Container(
                      height: 50,
                      width: double.maxFinite,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          color: BaseColors.white,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                              color: BaseColors.textfieldBoarderClr)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            BaseAssets.linkedinIc,
                          ),
                          buildSizeWidth(10),
                          const BaseText(
                            value: "Continue With Linkedin",
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          )
                        ],
                      ),
                    ),
                    BaseButton(
                        topMargin: 35,
                        bottomMargin: 35,
                        title: "Log In",
                        onPressed: () {
                          if (formKeyLogin.currentState?.validate() ?? false) {
                            loginCtrl.userLoginApi();
                          }
                        }),
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
                    buildSizeHeight(15),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget customCheckBox(
      {required bool value,
      required Function(bool?) onChanged,
      Color? borderColor}) {
    return Checkbox(
      value: value,
      onChanged: onChanged,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
      side: WidgetStateBorderSide.resolveWith((states) {
        return BorderSide(
            color: borderColor != null
                ? value
                    ? BaseColors.checkBox
                    : borderColor
                : BaseColors.checkBox,
            width: 1.5);
      }),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
        side: BorderSide(color: borderColor ?? BaseColors.checkBox, width: 1.0),
      ),
      checkColor: BaseColors.black,
      fillColor: const WidgetStatePropertyAll(BaseColors.checkBox),
    );
  }
}
