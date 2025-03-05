
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cray/UI/screens/past_profile_screen.dart';
import 'package:cray/UI/screens/purchase_background_check_details.dart';
import 'package:cray/UI/screens/purchase_catfish_details.dart';
import 'package:cray/base_components/full_file_url.dart';
import 'package:cray/controller/dashboard_controller.dart';
import 'package:cray/controller/profile_controller.dart';
import 'package:cray/utils/get_storage.dart';
import 'package:cray/utils/storage_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../base_components/base_button.dart';
import '../../base_components/base_scaffold_background.dart';
import '../../base_components/base_text.dart';
import '../../utils/base_assets.dart';
import '../../utils/base_colors.dart';
import '../../utils/base_functions.dart';
import '../screens/add_partner_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ProfileController profileController = Get.put(ProfileController());

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
                      buildSizeHeight(10),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.find<DashboardController>().pageIndex.value=2;
                            },
                            child:Obx(() {
                              return  Container(
                                height: 50,
                                width: 50,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(100)),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: CachedNetworkImage(
                                    imageUrl: generateFullFileUrl(
                                        profileController.profileData.value?.profilePicture ?? ""),
                                    height: 50,
                                    width: 50,
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
                          ),
                          buildSizeWidth(10),
                          Obx(() {
                            return BaseText(
                              value:"Hello, ${profileController.profileData.value?.firstName ?? ""}",
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: BaseColors.greyTextColor,
                            );
                          }),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              Get.find<DashboardController>().pageIndex.value=2;
                            },
                            child: SvgPicture.asset(
                              BaseAssets.settingIc,
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildSizeHeight(16),
                              Center(
                                child: Opacity(
                                  opacity: 0.3,
                                  child: SvgPicture.asset(
                                    BaseAssets.logoIc,
                                  ),
                                ),
                              ),

                              buildSizeHeight(5),
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => const AddPartnerDetailsScreen());
                                },
                                child: Container(
                                      height: 162,
                                    width: double.maxFinite,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: BaseColors.greyTextColor),
                                        color: BaseColors.containerClr,
                                        borderRadius: const BorderRadius.all(Radius.circular(20))),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(12.0),
                                              child: Container(
                                                height: 50,
                                                width: 50,
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Color(0x33000000),
                                                      Color(0x33B0FF09),
                                                    ],
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                  ),
                                                ),
                                                child: ClipOval(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(12.0),
                                                    child: SvgPicture.asset(
                                                      BaseAssets.userIc,
                                                      fit: BoxFit.contain,
                                                      colorFilter:
                                                          const ColorFilter.mode(
                                                              BaseColors.black,
                                                              BlendMode.srcIn),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const BaseText(
                                              value: "Are They Cray?",
                                              textAlign: TextAlign.center,
                                              fontSize: 30,
                                              fontWeight: FontWeight.w600,
                                              color: BaseColors.black,
                                            ),
                                          ],
                                        ),
                                        const Center(
                                          child: BaseText(
                                            value: "Start Now!",
                                            textAlign: TextAlign.center,
                                            leftMargin: 10,
                                            rightMargin: 10,
                                            fontSize: 28,
                                            fontWeight: FontWeight.w400,
                                            color: BaseColors.lightBlack,
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                              buildSizeHeight(16),
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => PastProfileScreen(userId:BaseStorage.read(StorageKeys.userId)));
                                },
                                child: Container(
                                    height: 101,
                                    width: double.maxFinite,
                                    decoration:  BoxDecoration(
                                        border: Border.all(
                                            color: BaseColors.greyTextColor),
                                        color: BaseColors.blueClr,
                                        borderRadius:
                                            const BorderRadius.all(Radius.circular(20))),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                            BaseAssets.calenderIc,
                                          ),
                                          buildSizeWidth(10),
                                          const BaseText(
                                            value: "Past Scores",
                                            textAlign: TextAlign.center,
                                            fontSize: 32,
                                            fontWeight: FontWeight.w400,
                                            color: BaseColors.white,
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                              buildSizeHeight(16),
                                BaseButton(
                                borderRadius: 10,
                                 borderEnable: true,
                                 borderColor:BaseColors.greyTextColor,
                                btnTextColor: BaseColors.black,
                                btnColor: BaseColors.lightGreen,
                                title: "Purchase Catfish Check",
                                 onPressed: () {
                                   Get.to(() => const PurchaseCatfishDetails());
                                 },
                              ),
                              buildSizeHeight(16),
                               BaseButton(
                                borderRadius: 10,
                                borderEnable: true,
                                borderColor:BaseColors.greyTextColor,
                                btnTextColor: BaseColors.black,
                                btnColor: BaseColors.lightPink,
                                title: "Purchase Background Check",
                                 onPressed: () {
                                   Get.to(() => const PurchaseBackgroundCheckDetails());
                                 },
                              ),
                              buildSizeHeight(100),
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
        ));
  }
}
