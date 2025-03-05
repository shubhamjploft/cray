import 'package:cray/UI/screens/purchase_background_check_details.dart';
import 'package:cray/UI/screens/purchase_catfish_details.dart';
import 'package:cray/controller/question_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../base_components/base_button.dart';
import '../../base_components/base_scaffold_background.dart';
import '../../base_components/base_text.dart';
import '../../utils/base_colors.dart';
import '../../utils/base_functions.dart';

class ProfileMatchScreen extends StatefulWidget {
  const ProfileMatchScreen({super.key,required this.score});
  final String score;
  @override
  State<ProfileMatchScreen> createState() => _ProfileMatchScreenState();
}

class _ProfileMatchScreenState extends State<ProfileMatchScreen> {
  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: BaseColors.white,
        body: SizedBox.expand(
          child: BaseScaffoldBackground(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          buildSizeHeight(10),
                          Row(
                            children: [
                              BaseText(
                                value: widget.score,
                                fontSize: 60,
                                fontWeight: FontWeight.w600,
                                color: BaseColors.black,
                              ),
                              buildSizeWidth(10),
                              const BaseText(
                                value: "Cray Score",
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                color: BaseColors.extraLightBlack,
                              ),
                            ],
                          ),
                          const BaseText(
                            value: "In the top left corner, you will find your “Cray Score.” In a healthy relationship, this number should be as close to 0 as possible. The lower the score, the more likely the relationship is free from major red flags.",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: BaseColors.black,
                          ),
                          buildSizeHeight(10),
                          const BaseText(
                            value: "Below, your answers are listed along with explanations of why the questions you endorsed are important. This summary is not meant to be diagnostic but rather to highlight areas of concern regarding your partner. Each of these questions is based on psychological constructs designed to identify potentially concerning traits in a partner.",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: BaseColors.black,
                          ),
                          buildSizeHeight(10),
                          const BaseText(
                            value: "Do not mistake this as a pass/fail judgment on your partner—Cray is simply a helpful tool to screen potential partners.",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: BaseColors.black,
                          ),
                          buildSizeHeight(20),
                           BaseButton(
                              title: "View Report",
                             onPressed: () {
                               Get.find<QuestionScreenController>().viewReportQuestionApi();
                               // Get.to(() => const ViewReportScreen());
                             },
                          ),
                          buildSizeHeight(20),
                           BaseButton(
                            btnTextColor: BaseColors.black,
                            btnColor: BaseColors.lightGreen,
                            title: "Purchase Catfish Check",
                            onPressed: () {
                              Get.to(() => const PurchaseCatfishDetails());
                            },
                          ),
                          buildSizeHeight(20),
                           BaseButton(
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
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
