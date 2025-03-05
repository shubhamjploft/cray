
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cray/UI/privacy_policy_screen/about_us_screen.dart';
import 'package:cray/UI/privacy_policy_screen/privacy_screen.dart';
import 'package:cray/UI/privacy_policy_screen/term_condition_screen.dart';
import 'package:cray/controller/profile_controller.dart';
import 'package:cray/utils/base_colors.dart';
import 'package:cray/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../base_components/base_button.dart';
import '../../base_components/base_scaffold_background.dart';
import '../../base_components/base_text.dart';
import '../../base_components/full_file_url.dart';
import '../../base_components/switch_button.dart';
import '../../utils/base_assets.dart';
import 'edit_profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileController profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseColors.white,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [BaseColors.white, BaseColors.lightPink],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SizedBox.expand(
          child: BaseScaffoldBackground(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const BaseText(
                          value: "Settings",
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          color: BaseColors.black,
                        ),
                        GestureDetector(
                          onTap: () {
                            showPasswordChangedDialogue(context);
                          },
                          child: SvgPicture.asset(
                            BaseAssets.offIc,
                            height: 25,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildSizeHeight(30),
                            Container(
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                  color: BaseColors.white,
                                  border: Border.all(
                                      color: BaseColors.moreLightGreen),
                                  borderRadius:
                                  const BorderRadiusDirectional.all(
                                      Radius.circular(20))),
                              child: Column(
                                children: [
                                  Container(
                                    height: 45,
                                    width: double.maxFinite,
                                    decoration: const BoxDecoration(
                                        color: BaseColors.moreLightGreen,
                                        borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20))),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          const BaseText(
                                            value: "My Profile",
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: BaseColors.black,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Get.to(() => const EditProfile());
                                            },
                                            child: SvgPicture.asset(
                                              BaseAssets.editIc,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  buildSizeHeight(5),
                                  Obx(() {
                                    return  Container(
                                      height: 112,
                                      width: 112,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(20)),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: CachedNetworkImage(
                                          imageUrl: generateFullFileUrl(
                                              profileController.profileData.value?.profilePicture ?? ""),
                                          height: 112,
                                          width: 112,
                                          fit: BoxFit.cover,
                                          placeholder: (BuildContext context, String url) => const Center(child: CircularProgressIndicator()),
                                          errorWidget: (BuildContext context, String url, Object error) => Image.asset(
                                            BaseAssets.noProfileImg,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                  buildSizeHeight(10),
                                  Obx(() {
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      children: [
                                        BaseText(
                                          value: profileController
                                              .profileData.value?.firstName ??
                                              "",
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: BaseColors.black,
                                        ),
                                        BaseText(
                                          value: profileController
                                              .profileData.value?.lastName ??
                                              "",
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: BaseColors.black,
                                        ),
                                      ],
                                    );
                                  }),
                                  Obx(() {
                                    return BaseText(
                                      value: profileController
                                          .profileData.value?.mobileNumber ??
                                          "",
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: BaseColors.black,
                                    );
                                  }),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          BaseAssets.instagramImg,
                                          height: 20,
                                        ),
                                        buildSizeWidth(10),
                                        Image.asset(
                                          BaseAssets.facebookImg,
                                          height: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            buildSizeHeight(16),
                            Container(
                              width: double.maxFinite,
                              decoration: const BoxDecoration(
                                  color: BaseColors.moreLightGreen,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(16))),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    const BaseText(
                                      value: "Notification",
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: BaseColors.black,
                                    ),
                                    CustomSwitchButton(
                                      onChanged: (bool value) {},
                                    )
                                  ],
                                ),
                              ),
                            ),
                            buildSizeHeight(16),
                            InkWell(
                              onTap: () {
                                Get.to(() => const TermConditionScreen());
                              },
                              child: Container(
                                width: double.maxFinite,
                                decoration: const BoxDecoration(
                                    color: BaseColors.moreLightGreen,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(16))),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      const BaseText(
                                        value: "Terms & Conditions",
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: BaseColors.black,
                                      ),
                                      SvgPicture.asset(
                                        BaseAssets.arrowIc,
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            buildSizeHeight(16),
                            InkWell(
                              onTap: () {
                                Get.to(() => const PrivacyScreen());
                              },
                              child: Container(
                                width: double.maxFinite,
                                decoration: const BoxDecoration(
                                    color: BaseColors.moreLightGreen,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(16))),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      const BaseText(
                                        value: "Privacy Policy",
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: BaseColors.black,
                                      ),
                                      SvgPicture.asset(
                                        BaseAssets.arrowIc,
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            buildSizeHeight(16),
                            InkWell(
                              onTap: () {
                                Get.to(() => const AboutUsScreen());
                              },
                              child: Container(
                                width: double.maxFinite,
                                decoration: const BoxDecoration(
                                    color: BaseColors.moreLightGreen,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(16))),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      const BaseText(
                                        value: "About Us",
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: BaseColors.black,
                                      ),
                                      SvgPicture.asset(
                                        BaseAssets.arrowIc,
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            buildSizeHeight(20),
                            // const Center(
                            //   child: BaseText(
                            //     value: "Delete Account",
                            //     fontSize: 16,
                            //     fontWeight: FontWeight.w500,
                            //     color: BaseColors.redClr,
                            //   ),
                            // ),
                            buildSizeHeight(70)
                          ],
                        ),
                      ),
                    ),
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

void showPasswordChangedDialogue(BuildContext context) {
  showDialog(
    useSafeArea: false,
    context: context,
    barrierColor: Colors.black.withOpacity(0.7),
    builder: (BuildContext dialogContext) {
      return Stack(
        children: [
          Container(
            color: Colors.black.withOpacity(0.3),
          ),
          Dialog(
            shadowColor: BaseColors.greyTextColor,
            insetPadding: const EdgeInsets.symmetric(horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildSizeHeight(10),
                  const BaseText(
                    value: "Are You Sure You Want To Log Out?",
                    topMargin: 10,
                    textAlign: TextAlign.center,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                  BaseButton(
                    btnWidth: 301,
                    title: "Log Out",
                    topMargin: 15,
                    onPressed: () {
                      clearSessionData();
                      // Get.offAll(const LoginScreen());
                    },
                  ),
                  buildSizeHeight(20),
                  BaseButton(
                    btnWidth: 301,
                    btnColor: BaseColors.lightGreen,
                    title: "Cancel",
                    btnTextColor: BaseColors.black,
                    bottomMargin: 10,
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    },
  );
}
