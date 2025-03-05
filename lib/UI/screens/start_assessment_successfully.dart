import 'package:cray/UI/screens/start_assessment_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../base_components/base_button.dart';
import '../../base_components/base_scaffold_background.dart';
import '../../base_components/base_text.dart';
import '../../utils/base_colors.dart';
import '../../utils/base_functions.dart';

// ignore: must_be_immutable
class StartAssessmentSuccessfully extends StatefulWidget {
  String? partnerId;
   StartAssessmentSuccessfully({super.key,this. partnerId });

  @override
  State<StartAssessmentSuccessfully> createState() => _StartAssessmentSuccessfullyState();
}

class _StartAssessmentSuccessfullyState extends State<StartAssessmentSuccessfully> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseColors.white,
      body: BaseScaffoldBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                const Center(
                  child: BaseText(
                    value: "Partner's details updated successfully",
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: BaseColors.black,
                    textAlign: TextAlign.center,
                  ),
                ),
                const Spacer(),
                BaseButton(
                  title: "Start Assessment",
                  onPressed: () {
                    Get.to(() =>  StartAssessmentScreen(partnerId: widget.partnerId,));
                  },
                ),
                buildSizeHeight(50),
              ],
            ),

          ),
        ),
      ),
    );
  }
}
