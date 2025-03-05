import 'package:cray/UI/auth_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../base_components/base_button.dart';
import '../../base_components/base_scaffold_background.dart';
import '../../base_components/base_text.dart';
import '../../base_components/base_textfield.dart';
import '../../controller/signup_controller.dart';
import '../../utils/base_assets.dart';
import '../../utils/base_colors.dart';
import '../../utils/base_functions.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> formKeySignup = GlobalKey<FormState>();

  SignUpController sigUpCtrl = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseColors.white,
      body: BaseScaffoldBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: formKeySignup,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context)
                        .size
                        .height,
                  ),
                  child: IntrinsicHeight(
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
                        buildSizeHeight(30),
                        Row(
                          children: [
                            Expanded(
                              child: BaseTextField(
                                labelText: '',
                                hintText: 'First Name',
                                controller: sigUpCtrl.firstNameController,
                                textCapitalization: TextCapitalization.words,
                                textInputType: TextInputType.name,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  child: SvgPicture.asset(
                                    BaseAssets.personIc,
                                  ),
                                ),
                                validator: (String? val) {
                                  if (sigUpCtrl.firstNameController.text
                                      .trim()
                                      .isEmpty) {
                                    return "Please First Name";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            buildSizeWidth(10),
                            Expanded(
                              child: BaseTextField(
                                labelText: '',
                                hintText: 'Last Name',
                                controller: sigUpCtrl.lastNameController,
                                textCapitalization: TextCapitalization.words,
                                textInputType: TextInputType.name,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  child: SvgPicture.asset(
                                    BaseAssets.personIc,
                                  ),
                                ),
                                validator: (String? val) {
                                  if (sigUpCtrl.lastNameController.text
                                      .trim()
                                      .isEmpty) {
                                    return "Please Last Name";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        buildSizeHeight(20),
                        BaseTextField(
                          labelText: '',
                          hintText: 'Email address',
                          controller: sigUpCtrl.emailController,
                          textCapitalization: TextCapitalization.words,
                          textInputType: TextInputType.emailAddress,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: SvgPicture.asset(
                              BaseAssets.emailIc,
                            ),
                          ),
                          validator: (String? val) {
                            String email =
                                sigUpCtrl.emailController.text.trim();
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
                          hintText: 'Phone',
                          controller: sigUpCtrl.phoneController,
                          textInputType: TextInputType.phone,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: SvgPicture.asset(
                              BaseAssets.phoneIc,
                            ),
                          ),
                          textInputFormatter: [
                            LengthLimitingTextInputFormatter(10)
                          ],
                          validator: (String? val) {
                            if (val == null || val.trim().isEmpty) {
                              return "Please enter a number";
                            }
                            if (!RegExp(r'^[0-9]+$').hasMatch(val)) {
                              return "Please enter a valid number";
                            }
                            if (val.length != 10) {
                              return "Number must be exactly 10 digits";
                            }
                            return null;
                          },
                        ),
                        buildSizeHeight(20),
                        BaseTextField(
                          labelText: '',
                          hintText: 'Password',
                          textInputType: TextInputType.text,
                          controller: sigUpCtrl.passwordController,
                          textCapitalization: TextCapitalization.words,
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
                        buildSizeHeight(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(() {
                              return customCheckBox(
                                  value: sigUpCtrl.isRememberMe.value,
                                  onChanged: (bool? value) {
                                    sigUpCtrl.isRememberMe.value =
                                        !sigUpCtrl.isRememberMe.value;
                                  });
                            }),
                            buildSizeWidth(10),
                            Flexible(
                              child: RichText(
                                text: const TextSpan(
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                  children: [
                                    TextSpan(
                                        text:
                                            "By creating an account I'm agreeing to our ",
                                        style: TextStyle(fontSize: 12)),
                                    TextSpan(
                                      text: "Privacy Policy",
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12),
                                    ),
                                    TextSpan(text: " and "),
                                    TextSpan(
                                      text: "Terms of service.",
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12),
                                    ),
                                    TextSpan(text: "."),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        buildSizeHeight(70),
                        BaseButton(
                          title: "Create my account",
                          onPressed: () {
                            if (formKeySignup.currentState?.validate() ??
                                false) {
                              sigUpCtrl.userSignUpApi();
                              // Get.to(() => const VerifyOtpScreen(
                              //   flowType: AuthFlowType.signup,
                              // )
                          }},
                        ),
                        buildSizeHeight(30),
                        GestureDetector(
                          onTap: () {
                            Get.to(() =>  const LoginScreen());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const BaseText(
                                value: "Already have an account?",
                                fontSize: 15,
                              ),
                              buildSizeWidth(5),
                              const BaseText(
                                value: "Log In",
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
                  ),
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
