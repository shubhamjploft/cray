import 'package:cray/UI/subscripation_screen/subscripation_screen.dart';
import 'package:cray/base_components/base_scaffold_background.dart';
import 'package:cray/base_components/base_text.dart';
import 'package:cray/utils/base_assets.dart';
import 'package:cray/utils/base_colors.dart';
import 'package:cray/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../base_components/base_button.dart';

class PurchaseCatfishDetails extends StatefulWidget {
  const PurchaseCatfishDetails({super.key});

  @override
  State<PurchaseCatfishDetails> createState() => _PurchaseCatfishDetailsState();
}

class _PurchaseCatfishDetailsState extends State<PurchaseCatfishDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 20,right: 20,top: 50),
            color: Colors.transparent,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: SvgPicture.asset(
                    BaseAssets.backButtonIc,
                  ),
                ),
                buildSizeWidth(15),
                const BaseText(
                  value: "Details",
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  color: BaseColors.black,
                ),
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
                     buildSizeHeight(20),
                     Container(
                         height: 165,
                         width: double.maxFinite,
                         decoration: BoxDecoration(
                             border: Border.all(color: BaseColors.greyTextColor),
                             borderRadius: const BorderRadius.all(Radius.circular(20))),
                       child:ClipRRect(
                         borderRadius: const BorderRadiusDirectional.all(Radius.circular(20)),
                           child: Image.asset(BaseAssets.purchaseCatfishImg,fit: BoxFit.cover,)),
                     ),
                     buildSizeHeight(16),
                     const BaseText(
                       value: "Purchase Catfish Check",
                       fontSize: 22,
                       fontWeight: FontWeight.w500,
                       color: BaseColors.black,
                     ),
                     buildSizeHeight(16),
                     const BaseText(
                       value: "Stay Safe, Date Smart!",
                       fontSize: 20,
                       fontWeight: FontWeight.w500,
                       color: BaseColors.black,
                     ),
                     const BaseText(
                       value: "Verify profiles and avoid fake accounts with our Catfish Check feature.",
                       fontSize: 16,
                       fontWeight: FontWeight.w400,
                       color: BaseColors.darkGreyBox,
                     ),
                     const Divider(
                       color: BaseColors.lightGreen,
                     ),
                     buildSizeHeight(16),
                     const BaseText(
                       value: "What You Get",
                       fontSize: 20,
                       fontWeight: FontWeight.w500,
                       color: BaseColors.black,
                     ),
                     const BaseText(
                       value: "1. AI-powered identity verification",
                       fontSize: 16,
                       fontWeight: FontWeight.w400,
                       color: BaseColors.darkGreyBox,
                     ),
                     const BaseText(
                       value: "2. Instant profile authenticity check",
                       fontSize: 16,
                       fontWeight: FontWeight.w400,
                       color: BaseColors.darkGreyBox,
                     ), const BaseText(
                       value: "3. Increased trust & safety in matches",
                       fontSize: 16,
                       fontWeight: FontWeight.w400,
                       color: BaseColors.darkGreyBox,
                     ),
                     const Divider(
                       color: BaseColors.lightGreen,
                     ),
                     buildSizeHeight(16),
                     const BaseText(
                       value: "One-Time Purchase",
                       fontSize: 20,
                       fontWeight: FontWeight.w500,
                       color: BaseColors.black,
                     ),
                     const BaseText(
                       value: "Get peace of mind for just \$20",
                       fontSize: 16,
                       fontWeight: FontWeight.w400,
                       color: BaseColors.darkGreyBox,
                     ),
                     const Divider(
                       color: BaseColors.lightGreen,
                     ),
                     buildSizeHeight(16),
                     const BaseText(
                       value: "Secure & Private",
                       fontSize: 20,
                       fontWeight: FontWeight.w500,
                       color: BaseColors.black,
                     ),
                     const BaseText(
                       value: "Your safety is our priority!",
                       fontSize: 16,
                       fontWeight: FontWeight.w400,
                       color: BaseColors.darkGreyBox,
                     ),
                     const Divider(
                       color: BaseColors.lightGreen,
                     ),
                     buildSizeHeight(16),
                      BaseButton(
                       title: "Buy Now",
                       onPressed: () {
                         Get.to(() => const SubscripationScreen());
                       },
                     ),
                     buildSizeHeight(20),
                   ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
