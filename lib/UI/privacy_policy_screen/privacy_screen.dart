import 'package:cray/utils/base_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../base_components/base_scaffold_background.dart';
import '../../base_components/base_text.dart';
import '../../utils/base_colors.dart';
import '../../utils/base_functions.dart';

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({super.key});

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [BaseColors.white, BaseColors.lightPink],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: BaseScaffoldBackground(
            child: Column(
              children: [
                buildSizeHeight(40),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: SvgPicture.asset(BaseAssets.backButtonIc)),
                      buildSizeWidth(20),
                      const BaseText(
                          value: "Privacy Policy",
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w400),
                    ],
                  ),
                ),
                Expanded(
                  child: BaseScaffoldBackground(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildSizeHeight(16),
                            const BaseText(
                              value: "1. Sharing Your Information",
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              color: BaseColors.black,
                            ),
                            const BaseText(
                              value:
                                  "We Do Not Sell Your Information. However, We May Share It With:",
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              color: BaseColors.black,
                            ),
                            buildSizeHeight(16),
                            const BaseText(
                              value: "2. Data Security",
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              color: BaseColors.black,
                            ),
                            const BaseText(
                              value:
                                  "By Accessing Our App Or Services, You Agree To These Terms & Conditions. If You Do Not Agree, You May Not Use Our Services.",
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              color: BaseColors.black,
                            ),
                            buildSizeHeight(16),
                            const BaseText(
                              value: "3. Your Rights",
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              color: BaseColors.black,
                            ),
                            const BaseText(
                              value:
                                  "By Accessing Our App Or Services, You Agree To These Terms & Conditions. If You Do Not Agree, You May Not Use Our Services.",
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              color: BaseColors.black,
                            ),
                            buildSizeHeight(16),
                            const BaseText(
                              value: "4. Third-Party Services",
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              color: BaseColors.black,
                            ),
                            const BaseText(
                              value:
                                  "By Accessing Our App Or Services, You Agree To These Terms & Conditions. If You Do Not Agree, You May Not Use Our Services.",
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              color: BaseColors.black,
                            ),
                            buildSizeHeight(16),
                            const BaseText(
                              value: "5. User Responsibilities",
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              color: BaseColors.black,
                            ),
                            const BaseText(
                              value: "Ensure All Booking Details Are Accurate.",
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              color: BaseColors.black,
                            ),
                            buildSizeHeight(16),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
