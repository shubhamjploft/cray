import 'package:cray/controller/question_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:cray/base_components/base_button.dart';
import 'package:cray/base_components/base_scaffold_background.dart';
import 'package:get/get.dart';

import '../../base_components/base_text.dart';
import '../../utils/base_colors.dart';
import '../../utils/base_functions.dart';

// ignore: must_be_immutable
class StartAssessmentScreen extends StatefulWidget {
  String? partnerId;
   StartAssessmentScreen({super.key,this.partnerId});

  @override
  State<StartAssessmentScreen> createState() => _StartAssessmentScreenState();
}

class _StartAssessmentScreenState extends State<StartAssessmentScreen> {
  QuestionScreenController questionCtrl = Get.put(QuestionScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseColors.white,
      body: BaseScaffoldBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildSizeHeight(10),
                  Row(
                    children: [
                      const BaseText(
                        value:'60',
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
                    value: "Do not mistake this as a pass/fail judgment on your partner—Cray is simply a helpful tool to screen potential partners",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: BaseColors.black,
                  ),
                  buildSizeHeight(80),
                  Column(
                    children: [
                      BaseButton(
                        title: "Start Assessment",
                        onPressed: () {
                          questionCtrl.screenquestion(partId:widget.partnerId.toString());
                          // Get.to(() => const QuestionScreen());
                        },
                      ),
                   buildSizeHeight(20)
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
