import 'package:cray/base_components/base_text.dart';
import 'package:cray/controller/question_screen_controller.dart';
import 'package:cray/utils/base_colors.dart';
import 'package:cray/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomProgressBar extends StatefulWidget {
  const CustomProgressBar({super.key,this.isAllNo =false});
final bool isAllNo;
  @override
  State<CustomProgressBar> createState() => _CustomProgressBarState();
}

class _CustomProgressBarState extends State<CustomProgressBar> {
  QuestionScreenController controller = Get.find<QuestionScreenController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Obx(() {
            return BaseText(
                value: '${(controller.totalProgress.value - (widget.isAllNo?controller.allQuestionList.length:controller.screenQuestionList.length)) }',
                color: BaseColors.progressClr,
                fontSize: 14);
          }),
          buildSizeWidth(8),
          Expanded(
            child: Obx(() {
              double progressValue =
                  ((controller.totalProgress.value -
                      (widget.isAllNo?controller.allQuestionList.length:controller.screenQuestionList.length))) /
                      controller.totalProgress.value;
              return Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: BaseColors.progressClr)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: progressValue,
                    backgroundColor: BaseColors.white,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                        BaseColors.progressClr),
                    minHeight: 6,
                  ),
                ),
              );
            }),
          ),

          buildSizeWidth(8),
          Obx(() {
            return BaseText(
                value:
                '${(controller.totalProgress.value -
                    (widget.isAllNo?controller.allQuestionList.length:controller.screenQuestionList.length)) }/${controller.totalProgress
                    .value}',
                color: BaseColors.progressClr,
                fontSize: 14);
          }),
        ],
      ),
    );
  }
}
