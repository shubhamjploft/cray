import 'package:cray/controller/add_your_social_media_controller.dart';
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
class SocialMediaAccountScreen extends StatefulWidget {
  String? userSocialId;

  SocialMediaAccountScreen({super.key, this.userSocialId});

  @override
  State<SocialMediaAccountScreen> createState() =>
      _SocialMediaAccountScreenState();
}

class _SocialMediaAccountScreenState extends State<SocialMediaAccountScreen> {
  final GlobalKey<FormState> formKeyAccount = GlobalKey<FormState>();
  AddSocialMediaController controller = Get.put(AddSocialMediaController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseColors.white,
      body: BaseScaffoldBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: formKeyAccount,
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
                  buildSizeHeight(30),
                  const BaseText(
                    value: "Add your social media account",
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    color: BaseColors.black,
                  ),
                  buildSizeHeight(30),
                  BaseTextField(
                    labelText: '',
                    hintText: 'Facebook account',
                    controller: controller.facebookAccountCtrl,
                    textInputType: TextInputType.url,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: SvgPicture.asset(
                        BaseAssets.facebookIc,
                      ),
                    ),
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return "Please enter Facebook account";
                      }
                      final RegExp facebookRegex = RegExp(r'^(https?://)?(www\.)?facebook\.com/[a-zA-Z0-9(.?)]');

                      if (!facebookRegex.hasMatch(val.trim())) {
                        return "Please enter a valid Facebook profile link";
                      }

                      return null;
                    },
                  ),
                  buildSizeHeight(16),
                  BaseTextField(
                    labelText: '',
                    hintText: 'LinkedIn account',
                    controller: controller.linkdinAccountCtrl,
                    textInputType: TextInputType.url,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: SvgPicture.asset(
                        BaseAssets.linkedinSecIc,
                      ),
                    ),
                    validator: (String? val) {
                      if (val == null || val.trim().isEmpty) {
                        return "Please enter LinkedIn account";
                      }
                      final RegExp linkedInRegex = RegExp(
                          r'^(https?://)?(www\.)?linkedin\.com/(in|company)/[a-zA-Z0-9_-]+/?$'
                      );
                      if (!linkedInRegex.hasMatch(val.trim())) {
                        return "Please enter a valid LinkedIn profile link";
                      }
                      return null;
                    },
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      BaseButton(
                        title: "Continue",
                        onPressed: () {
                          if (formKeyAccount.currentState?.validate() ?? false) {
                            controller.addUserSocialMediaApi(userId: widget.userSocialId);
                            // Get.to(() => const DashboardScreen());
                            // Get.to(() => const StartAssessmentSuccessfully());
                          }
                        },
                      ),
                      buildSizeHeight(50),
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
