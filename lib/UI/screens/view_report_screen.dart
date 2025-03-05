import 'package:cray/UI/dashboard_screen/dashboard_screen.dart';
import 'package:cray/controller/question_screen_controller.dart';
import 'package:cray/model/exam_record_review_response.dart';
import 'package:cray/utils/base_no_data.dart';
import 'package:cray/utils/smart_refresher_base_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../base_components/base_scaffold_background.dart';
import '../../base_components/base_text.dart';
import '../../utils/base_assets.dart';
import '../../utils/base_colors.dart';
import '../../utils/base_functions.dart';

class ViewReportScreen extends StatefulWidget {
  const ViewReportScreen({super.key});

  @override
  State<ViewReportScreen> createState() => _ViewReportScreenState();
}

class _ViewReportScreenState extends State<ViewReportScreen> {
  QuestionScreenController controller = Get.find<QuestionScreenController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseColors.white,
      body: SizedBox.expand(
        child: BaseScaffoldBackground(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildSizeHeight(10),
                  GestureDetector(
                   onTap: () {
                     Get.offAll(const DashboardScreen());
                   },
                    child: Row(
                      children: [
                        SvgPicture.asset(BaseAssets.backButtonIc),
                        buildSizeWidth(15),
                        const BaseText(
                          value: "View Report",
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          color: BaseColors.black,
                        ),
                      ],
                    ),
                  ),
                  buildSizeHeight(20),
                  Expanded(
                    child: Obx(
                      () => SmartRefresher(
                        controller: controller.refreshController,
                        header: const SmartRefresherBaseHeader(),
                        onRefresh: () {
                          controller.viewReportQuestionApi(isLoaderShow: false);
                        },
                        child: controller.viewQuestionList.isEmpty
                            ? Column(
                                children: [
                                  buildSizeHeight(200.0),
                                  const BaseNoData(
                                    message: "No Past Profile Found!",
                                  ),
                                ],
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                itemCount: controller.viewQuestionList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final Question question =
                                      controller.viewQuestionList[index];
                                  return QuestionCard(
                                    question:
                                        "Q. ${index + 1} ${question.question ?? ""}",
                                    selectedOption:
                                        question.userSelectedOption ?? "",
                                    explanation: controller
                                            .viewQuestionList[index]
                                            .explanation ??
                                        "",
                                  );
                                },
                              ),
                      ),
                    ),
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

class QuestionCard extends StatelessWidget {
  final String question;
  final String explanation;
  final String? selectedOption;

  const QuestionCard({
    super.key,
    required this.question,
    required this.selectedOption,
    required this.explanation,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.maxFinite,
          decoration: const BoxDecoration(
            color: BaseColors.offWhiteClr,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(8),
              topLeft: Radius.circular(8),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: BaseText(
              value: question,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ),
        buildSizeHeight(5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: ["Yes", "No", "NotSure"].map((String option) {
            String lowerCaseOption = option.toLowerCase();
            String selected = selectedOption?.toLowerCase() ?? "";
            Color backgroundColor = BaseColors.questionGreyClr;
            if (selected == lowerCaseOption) {
              backgroundColor = selected == "yes"
                  ? BaseColors.greenColor
                  : selected == "no"
                      ? BaseColors.redClr
                      : selected == "notsure"
                          ? BaseColors.orangeColor
                          : BaseColors.questionGreyClr;
            }
            return Container(
              width: 100,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(5),
              ),
              alignment: Alignment.center,
              child: BaseText(
                value: option == "NotSure" ? "Not Sure" : option,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            );
          }).toList(),
        ),
        buildSizeHeight(10),
        Container(
          width: double.maxFinite,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: BaseColors.lightGreen,
            borderRadius: BorderRadius.circular(5),
          ),
          alignment: Alignment.center,
          child: Html(data: explanation,
              style: {
                "p": Style(
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontFamily: "poppins",
            ),
          },
          ),
        ),
        buildSizeHeight(20),
      ],
    );
  }
}
