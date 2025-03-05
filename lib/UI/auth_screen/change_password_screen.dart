import 'dart:ui';

import 'package:cray/UI/auth_screen/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../base_components/base_button.dart';
import '../../base_components/base_scaffold_background.dart';
import '../../base_components/base_text.dart';
import '../../base_components/base_textfield.dart';
import '../../controller/change_password_controller.dart';
import '../../utils/base_assets.dart';
import '../../utils/base_colors.dart';
import '../../utils/base_functions.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  ChangePasswordController changePasswordCtrl = Get.put(ChangePasswordController());
  final GlobalKey<FormState> formKeyChangePassword = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: BaseColors.white,
        body: BaseScaffoldBackground(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Stack(
                children: [
                  // Scrollable content
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      child: Form(
                        key: formKeyChangePassword,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                            Obx(
                              () => BaseTextField(
                                controller: changePasswordCtrl.emailCtrl,
                                labelText: '',
                                hintText: 'Email',
                                obscureText: changePasswordCtrl.obscureChangePassword.value,
                                textCapitalization: TextCapitalization.words,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 10),
                                  child: SvgPicture.asset(
                                    BaseAssets.emailIc,
                                  ),
                                ),
                                validator: (String? val) {
                                  if (val == null || val.trim().isEmpty) {
                                    return "Please enter your email";
                                  }
                                  final RegExp emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                                  if (!emailRegex.hasMatch(val)) {
                                    return "Please enter a valid email address";
                                  }
                                  return null;
                                },
                                suffixIcon: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        triggerHapticFeedback();
                                        changePasswordCtrl
                                                .obscureChangePassword.value =
                                            !(changePasswordCtrl
                                                .obscureChangePassword.value);
                                        changePasswordCtrl.update();
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 3, right: 25),
                                        child: !changePasswordCtrl
                                                .obscureChangePassword.value
                                            ? const Icon(
                                                CupertinoIcons.eye,
                                                size: 24,
                                                color: BaseColors.greyTextColor,
                                              )
                                            : const Icon(
                                                CupertinoIcons.eye_slash,
                                                size: 24,
                                                color: BaseColors.greyTextColor,
                                              ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            buildSizeHeight(20),
                            Obx(
                              () => BaseTextField(
                                controller: changePasswordCtrl.newPasswordCtrl,
                                labelText: '',
                                hintText: 'Enter New Password',
                                obscureText: changePasswordCtrl.obscureChangeCnfrmPassword.value,
                                textCapitalization: TextCapitalization.words,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 10),
                                  child: SvgPicture.asset(
                                    BaseAssets.lockAPasswordIc,
                                  ),
                                ),
                                validator: (String? val) {
                                  if (val == null || val.trim().isEmpty) {
                                    return "Please Enter New Password";
                                  }
                                  if (val.length < 6) {
                                    return "Password must be at least 6 characters long";
                                  }
                                  return null;
                                },
                                suffixIcon: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        triggerHapticFeedback();
                                        changePasswordCtrl
                                                .obscureChangeCnfrmPassword
                                                .value =
                                            !(changePasswordCtrl
                                                .obscureChangeCnfrmPassword
                                                .value);
                                        changePasswordCtrl.update();
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 3, right: 25),
                                        child: !changePasswordCtrl
                                                .obscureChangeCnfrmPassword
                                                .value
                                            ? const Icon(
                                                CupertinoIcons.eye,
                                                size: 24,
                                                color: BaseColors.greyTextColor,
                                              )
                                            : const Icon(
                                                CupertinoIcons.eye_slash,
                                                size: 24,
                                                color: BaseColors.greyTextColor,
                                              ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            buildSizeHeight(20),
                            BaseButton(
                              title: "Change Password",
                              onPressed: () {
                                if (formKeyChangePassword.currentState
                                        ?.validate() ??
                                    false) {
                                  changePasswordCtrl.changePassword();
                                  showPasswordChangedDialogue(context);
                                }
                              },
                            ),
                            buildSizeHeight(30),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    left: 0,
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: SvgPicture.asset(
                        BaseAssets.backButtonIc,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

void showPasswordChangedDialogue(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return Stack(children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: Colors.black.withOpacity(0.3),
            ),
          ),
          Dialog(
            shadowColor: BaseColors.greyTextColor,
            insetPadding: const EdgeInsets.symmetric(horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildSizeHeight(10),
                  const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 100,
                  ),
                  const BaseText(
                    value: "Password Changed Successfully!",
                    topMargin: 10,
                    textAlign: TextAlign.center,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                  const BaseText(
                    value:
                        "Your password has been successfully updated. You can now use your new password to log in to your account.",
                    fontSize: 13,
                    topMargin: 10,
                    textAlign: TextAlign.center,
                    color: BaseColors.greyTextColor,
                  ),
                  BaseButton(
                    title: "Great, Thanks! ",
                    btnWidth: 225,
                    fontSize: 18,
                    topMargin: 15,
                    bottomMargin: 10,
                    onPressed: () {
                      Get.offAll( const LoginScreen());
                    },
                  ),
                ],
              ),
            ),
          ),
        ]);
      });
}
