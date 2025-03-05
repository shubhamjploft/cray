import 'package:flutter/material.dart';
import 'package:cray/utils/base_assets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../base_components/base_scaffold_background.dart';
import '../../base_components/base_text.dart';
import '../../utils/base_colors.dart';
import '../../utils/base_functions.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
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
                          value: "About Us",
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
                              value:
                                  "At Levicon Carwash, We Understand That Your Car Is More Than Just A Vehicle—It’s A Reflection Of Your Lifestyle. That’s Why We’re Dedicated To Offering Top-Notch, Hassle-Free Car Wash And Detailing Services, Tailored To Meet Your Needs.",
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              color: BaseColors.black,
                            ),
                            buildSizeHeight(16),
                            const BaseText(
                              value: "Our Mission",
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: BaseColors.black,
                            ),
                            const BaseText(
                              value:
                                  "Our Mission Is Simple: To Provide Convenient, Eco-Friendly, And High- Quality Car Care Services Right At Your Fingertips.",
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              color: BaseColors.black,
                            ),
                            buildSizeHeight(16),
                            const BaseText(
                              value: "Why Choose Us?",
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
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
