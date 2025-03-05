import 'package:cray/base_components/base_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../base_components/base_scaffold_background.dart';
import '../../base_components/base_text.dart';
import '../../utils/base_assets.dart';
import '../../utils/base_colors.dart';
import '../../utils/base_functions.dart';

class SubscripationScreen extends StatefulWidget {
  const SubscripationScreen({super.key});

  @override
  State<SubscripationScreen> createState() => _SubscripationScreenState();
}

class _SubscripationScreenState extends State<SubscripationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseColors.white,
      body: SizedBox.expand(
        child: BaseScaffoldBackground(
          child: SafeArea(
            child: Padding(
              padding:  const EdgeInsets.only(left: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildSizeHeight(20),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Row(
                        children: [
                          SvgPicture.asset(BaseAssets.backButtonIc),
                          buildSizeWidth(15),
                           const BaseText(
                            value: "Subscription",
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                            color: BaseColors.black,
                          ),
                        ],
                      ),
                    ),
                    buildSizeHeight(150),
                    SizedBox(
                      height: 364,
                      child: ListView.builder(
                        itemCount: 3,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, index) {
                          return Container(
                            height: 364,
                            width: 239,
                            margin: const EdgeInsets.only(right: 12),
                            decoration: BoxDecoration(
                              color: BaseColors.offWhiteClr,
                              border: Border.all(color: BaseColors.redClr),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const BaseText(
                                  value: "Product",
                                  fontSize: 36,
                                  fontWeight: FontWeight.w800,
                                  color: BaseColors.black,
                                  showUnderline: true,
                                ),
                                buildSizeHeight(40),
                                const BaseText(
                                  value: "Purchase",
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                  color: BaseColors.black,
                                ),
                                buildSizeHeight(10),
                                const BaseText(
                                  value: "Lorem Ipsum Is Simply Dummy Text Of The Printing And Typesetting Industry.",
                                  fontSize: 16,
                                  textAlign: TextAlign.center,
                                  fontWeight: FontWeight.w400,
                                  color: BaseColors.black,
                                ),
                                 const BaseText(
                                  value: "\$20",
                                  fontSize: 50,
                                  fontWeight: FontWeight.w800,
                                  color: BaseColors.redClr,
                                ),
                                buildSizeHeight(10),
                                  BaseButton(
                                  btnWidth: 140,
                                    btnHeight: 42,
                                    title: "Buy Now",
                                     onPressed: () {
                                     // Get.to(() => const ProfileMatchScreen());
                                  },
                                ),
                              ],
                            ),
                          );
                        },
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
