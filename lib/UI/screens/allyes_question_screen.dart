import 'package:cray/UI/dashboard_screen/dashboard_screen.dart';
import 'package:cray/UI/swipe_screen/question_screen.dart';
import 'package:cray/base_components/base_button.dart';
import 'package:cray/base_components/base_scaffold_background.dart';
import 'package:cray/base_components/base_text.dart';
import 'package:cray/controller/question_screen_controller.dart';
import 'package:cray/utils/base_colors.dart';
import 'package:cray/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllYesQuestionScreen extends StatefulWidget {
  const AllYesQuestionScreen({super.key, required this.partnerId});
  final String partnerId;

  @override
  State<AllYesQuestionScreen> createState() => _AllYesQuestionScreenState();
}

class _AllYesQuestionScreenState extends State<AllYesQuestionScreen> {
  QuestionScreenController controller = Get.find<QuestionScreenController>();

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: BaseColors.white,
        body: BaseScaffoldBackground(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildSizeHeight(20),
                    const BaseText(
                      value: "You and your partner appear to not share the same goals in life, which could lead to relationship conflict.",
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: BaseColors.black,
                      textAlign: TextAlign.start,
                    ),
                    buildSizeHeight(20),
                    const BaseText(
                      value: "You and your partner appear to not share the same interests in life, which could lead to significantly less relationship satisfaction.",
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: BaseColors.black,
                      textAlign: TextAlign.start,
                    ),
                    buildSizeHeight(20),
                    const BaseText(
                      value: "You and your partner appear to have significant conflict within your family of origin which could lead to an unstable relationship due to lack of external support.",
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: BaseColors.black,
                      textAlign: TextAlign.start,
                    ),
                    buildSizeHeight(20),
                    const BaseText(
                      value: "You and your partner appear to have serious issues with external support which will likely increase isolation and relationship conflict.",
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: BaseColors.black,
                      textAlign: TextAlign.start,
                    ),
                    buildSizeHeight(20),
                    const BaseText(
                      value: "You and your partner appear to have a relationship that began under inappropriate circumstances which calls into question the motives of your partner.",
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: BaseColors.black,
                      textAlign: TextAlign.start,
                    ),
                    buildSizeHeight(20),
                    BaseButton(
                      title: "Start Assessment",
                      onPressed: () {
                        showPasswordChangedDialogue(context);
                      },
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

  void showPasswordChangedDialogue(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (BuildContext dialogContext) {
        return Dialog(
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
                  value: "Are you certain you still want to move forward? This partnership did not start on a strong foundation.",
                  textAlign: TextAlign.center,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                buildSizeHeight(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: BaseButton(
                        title: "No",
                        onPressed: () {
                          Get.offAll(const DashboardScreen());
                        },
                      ),
                    ),
                    buildSizeWidth(10),
                    Expanded(
                      child: BaseButton(
                        btnColor: BaseColors.lightGreen,
                        title: "Yes",
                        btnTextColor: BaseColors.black,
                        bottomMargin: 10,
                        onPressed: () async {
                          await controller.filterQuestionApi(partId: widget.partnerId);
                          Get.to(() => const QuestionScreen(isAllNo: true));
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
