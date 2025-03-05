import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cray/UI/dashboard_screen/dashboard_screen.dart';
import 'package:cray/UI/swipe_screen/components/swipeable_cards_section/swipeable_cards.dart';
import 'package:cray/base_components/animated_column.dart';
import 'package:cray/base_components/base_text.dart';
import 'package:cray/base_components/full_file_url.dart';
import 'package:cray/base_components/progress_bar_custum.dart';
import 'package:cray/controller/profile_controller.dart';
import 'package:cray/controller/question_screen_controller.dart';
import 'package:cray/controller/swipeable_cards_controller.dart';
import 'package:cray/model/filter_question_response.dart';
import 'package:cray/model/screen_question_response.dart';
import 'package:cray/utils/base_colors.dart';
import 'package:cray/utils/base_functions.dart';
import 'package:cray/utils/base_no_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../base_components/base_scaffold_background.dart';
import '../../controller/dashboard_controller.dart';
import '../../utils/base_assets.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key, this.isAllNo = false});
final bool isAllNo;
  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  QuestionScreenController controller =Get.isRegistered<QuestionScreenController>()?Get.find<QuestionScreenController>(): Get.put(QuestionScreenController());

  @override
  Widget build(BuildContext context) {
    log("${widget.isAllNo }");
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
        child: BaseScaffoldBackground(
          child: SafeArea(
            child: Column(
              children: [
                buildSizeHeight(20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Get.offAll(const DashboardScreen());
                          },
                          child: SvgPicture.asset(BaseAssets.backButtonIc)),
                      InkWell(
                        onTap: () {
                          Get.find<DashboardController>().pageIndex.value = 2;
                          Get.to(() => const DashboardScreen());
                        },
                        child: Obx(() {
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
                                    Get.find<ProfileController>().profileData.value?.profilePicture ?? ""),
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
                    ],
                  ),
                ),
                buildSizeHeight(20),
                 CustomProgressBar(isAllNo: widget.isAllNo),
                Visibility(
                  visible: widget.isAllNo,
                  replacement: Obx(() => Visibility(
                      visible: (controller.screenQuestionList).isNotEmpty,
                      replacement: const BaseNoData(message: "No Questions left!"),
                      child: Expanded(
                        child: SwipeableCardsSection(
                          cardController: controller.cardController.value,
                          context: context,
                          items: controller.screenQuestionList.map((ScreenQuestion question) => cardView(question)).toList(),
                          onCardSwiped: (dynamic dir, dynamic index, dynamic widget) {
                            String selectedOption = '';
                            if (dir == Direction.left) {
                              selectedOption = 'no';
                            } else if (dir == Direction.right) {
                              selectedOption = 'yes';
                            } else if (dir == Direction.down) {
                              selectedOption = 'notSure';
                            }
                            controller.submitQuestionApi(
                              questionId: controller.screenQuestionList[0].id?.toString() ?? "",
                              userSelectedOption: selectedOption,
                              isAllNo: false
                            );
                          },
                          enableSwipeUp: false,
                          enableSwipeDown: true,
                        ),
                      ),
                    ),
                  ),
                  child: Obx(
                    () => Visibility(
                      visible: (controller.allQuestionList).isNotEmpty,
                      replacement: const BaseNoData(message: "No Questions left!"),
                      child: Expanded(
                        child: SwipeableCardsSection(
                          cardController: controller.cardController.value,
                          context: context,
                          items: controller.allQuestionList.map((QuestionList question) => cardViewAllNo(question)).toList(),
                          onCardSwiped: (dynamic dir, dynamic index, dynamic widget) {
                            String selectedOption = '';
                            if (dir == Direction.left) {
                              selectedOption = 'no';
                            } else if (dir == Direction.right) {
                              selectedOption = 'yes';
                            } else if (dir == Direction.down) {
                              selectedOption = 'notSure';
                            }
                            controller.submitQuestionApi(
                              questionId: controller.allQuestionList[0].id?.toString() ?? "",
                              userSelectedOption: selectedOption,
                              isAllNo: true
                            );
                          },
                          enableSwipeUp: false,
                          enableSwipeDown: true,
                        ),
                      ),
                    ),
                  ),
                ),
                // const Padding(
                //   padding:
                //       EdgeInsets.symmetric(horizontal: 22, vertical: 30),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       BaseText(
                //         value: "<Preview Question",
                //         color: BaseColors.lightBlack,
                //         fontSize: 16,
                //       ),
                //       BaseText(
                //         value: "Next Question>",
                //         color: BaseColors.lightBlack,
                //         fontSize: 16,
                //       ),
                //     ],
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget cardView(ScreenQuestion question) {
    return GestureDetector(
      onTap: () {
      },
      child: Obx(() {
        return Container(
          height: 500,
          width: Get.width,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
              color: BaseColors.white,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                  color: controller.isRight.value == true
                      ? BaseColors.speedometerSecClr
                      : controller.isLeft.value == true
                          ? BaseColors.redClr
                          : controller.isDown.value == true
                              ? BaseColors.greyClr
                              : BaseColors.white,
                  width: 2)),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned(
                top: 20,
                child: SvgPicture.asset(BaseAssets.upArrowIc),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildSizeHeight(60),
                    BaseText(
                      value: question.question?.toString() ?? "",
                      fontSize: 27,
                      fontWeight: FontWeight.w600,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Obx(() {
                return Visibility(
                  visible: controller.isRight.value == true,
                  child: Positioned(
                    top: 40,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: AnimatedColumn(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: SvgPicture.asset(BaseAssets.checkIc,
                                height: 60, width: 60),
                          ),
                          const BaseText(
                            value: "Yes",
                            fontSize: 28,
                            fontWeight: FontWeight.w400,
                          ),
                          buildSizeHeight(20)
                        ],
                      ),
                    ),
                  ),
                );
              }),
              Obx(() {
                return Visibility(
                  visible: controller.isLeft.value == true,
                  child: Positioned(
                    top: 40,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: AnimatedColumn(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: SvgPicture.asset(BaseAssets.crossIc,
                                height: 60, width: 60),
                          ),
                          const BaseText(
                            value: "No",
                            fontSize: 28,
                            fontWeight: FontWeight.w400,
                          ),
                          buildSizeHeight(20)
                        ],
                      ),
                    ),
                  ),
                );
              }),
              Obx(() {
                return Visibility(
                  visible: controller.isDown.value == true,
                  child: Positioned(
                    top: 40,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: AnimatedColumn(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: SvgPicture.asset(BaseAssets.questionIc,
                                height: 60, width: 60),
                          ),
                          const BaseText(
                            value: "Not Sure",
                            fontSize: 28,
                            fontWeight: FontWeight.w400,
                          ),
                          buildSizeHeight(20)
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        );
      }),
    );
  }

  Widget cardViewAllNo(QuestionList question) {
    return GestureDetector(
      onTap: () {
      },
      child: Obx(() {
        return Container(
          height: 500,
          width: Get.width,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
              color: BaseColors.white,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                  color: controller.isRight.value == true
                      ? BaseColors.speedometerSecClr
                      : controller.isLeft.value == true
                      ? BaseColors.redClr
                      : controller.isDown.value == true
                      ? BaseColors.greyClr
                      : BaseColors.white,
                  width: 2)),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned(
                top: 20,
                child: SvgPicture.asset(BaseAssets.upArrowIc),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildSizeHeight(60),
                    BaseText(
                      value: question.question?.toString() ?? "",
                      fontSize: 27,
                      fontWeight: FontWeight.w600,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Obx(() {
                return Visibility(
                  visible: controller.isRight.value == true,
                  child: Positioned(
                    top: 40,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: AnimatedColumn(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: SvgPicture.asset(BaseAssets.checkIc,
                                height: 60, width: 60),
                          ),
                          const BaseText(
                            value: "Yes",
                            fontSize: 28,
                            fontWeight: FontWeight.w400,
                          ),
                          buildSizeHeight(20)
                        ],
                      ),
                    ),
                  ),
                );
              }),
              Obx(() {
                return Visibility(
                  visible: controller.isLeft.value == true,
                  child: Positioned(
                    top: 40,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: AnimatedColumn(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: SvgPicture.asset(BaseAssets.crossIc,
                                height: 60, width: 60),
                          ),
                          const BaseText(
                            value: "No",
                            fontSize: 28,
                            fontWeight: FontWeight.w400,
                          ),
                          buildSizeHeight(20)
                        ],
                      ),
                    ),
                  ),
                );
              }),
              Obx(() {
                return Visibility(
                  visible: controller.isDown.value == true,
                  child: Positioned(
                    top: 40,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: AnimatedColumn(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: SvgPicture.asset(BaseAssets.questionIc,
                                height: 60, width: 60),
                          ),
                          const BaseText(
                            value: "Not Sure",
                            fontSize: 28,
                            fontWeight: FontWeight.w400,
                          ),
                          buildSizeHeight(20)
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        );
      }),
    );
  }
}
