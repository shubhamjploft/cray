import 'package:cray/controller/past_profile_controller.dart';
import 'package:cray/utils/base_colors.dart';
import 'package:cray/utils/base_functions.dart';
import 'package:cray/utils/base_no_data.dart';
import 'package:cray/utils/smart_refresher_base_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../base_components/base_scaffold_background.dart';
import '../../base_components/base_text.dart';
import '../../utils/base_assets.dart';


// ignore: must_be_immutable
class PastProfileScreen extends StatefulWidget {
  String? userId;
  PastProfileScreen({super.key, this.userId});

  @override
  State<PastProfileScreen> createState() => _PastProfileScreenState();
}

class _PastProfileScreenState extends State<PastProfileScreen> {
  PastProfileController pastProfileCtrl = Get.put(PastProfileController());

  @override
  void initState() {
    // TODO: implement initState
    pastProfileCtrl.userPastProfile(userId: widget.userId);
    super.initState();
  }

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
                            Get.back();
                          },
                          child: SvgPicture.asset(
                            BaseAssets.backButtonIc,
                          ),
                        ),
                        buildSizeWidth(15),
                        const BaseText(
                          value: "Past Profiles",
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          color: BaseColors.black,
                        ),
                      ],
                    ),
                    buildSizeHeight(20),
                    Row(
                      children: [
                        const BaseText(
                          value: "Name",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: BaseColors.black,
                        ),
                        const Spacer(),
                        const BaseText(
                          value: "Score",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: BaseColors.black,
                        ),
                        buildSizeWidth(30),
                        const BaseText(
                          value: "Last Update",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: BaseColors.black,
                        ),
                      ],
                    ),
                    const Divider(
                      color: BaseColors.greyTextColor,
                    ),
                    Expanded(
                      child: Obx(
                        () {
                          return SmartRefresher(
                            controller: pastProfileCtrl.refreshController,
                            header: const SmartRefresherBaseHeader(),
                            onRefresh: () {
                              pastProfileCtrl.userPastProfile(
                                  isLoaderShow: false, userId: widget.userId);
                            },
                            child: pastProfileCtrl.pastProfileDataList.isEmpty
                                ? Column(
                                    children: [
                                      buildSizeHeight(200.0),
                                      const BaseNoData(
                                        message: "No Past Profile Found !",
                                      ),
                                    ],
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    physics: const AlwaysScrollableScrollPhysics(),
                                    padding: const EdgeInsets.all(0),
                                    itemCount: pastProfileCtrl
                                        .pastProfileDataList.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  BaseText(
                                                    value: pastProfileCtrl.pastProfileDataList[index].name ?? "",
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: BaseColors.black,
                                                  ),
                                                  BaseText(
                                                    value:
                                                        "Create Date :${pastProfileCtrl.pastProfileDataList[index].createdAt ?? ""}",
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w400,
                                                    color: BaseColors.extraGrey,
                                                  ),
                                                ],
                                              ),
                                              const Spacer(),
                                              BaseText(
                                                value: pastProfileCtrl.pastProfileDataList[index].score ?? "",
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: BaseColors.black,
                                              ),
                                              buildSizeWidth(50),
                                              BaseText(
                                                value: pastProfileCtrl.pastProfileDataList[index].lastUpdate ?? "",
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: BaseColors.extraGrey,
                                              ),
                                            ],
                                          ),
                                          const Divider(
                                            color: BaseColors.lightGreen,
                                          ),
                                        ],
                                      );
                                    },
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
