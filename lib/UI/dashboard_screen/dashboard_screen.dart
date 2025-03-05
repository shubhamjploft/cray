import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../controller/dashboard_controller.dart';
import '../../utils/base_assets.dart';
import '../../utils/base_colors.dart';
import '../home_screen/home_screen.dart';
import '../notification_screen/notification_screen.dart';
import '../profile_screen/profile_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Widget> screens = [
    const HomeScreen(),
     const NotificationScreen(),
    const ProfileScreen(),
  ];

  DashboardController controller = Get.put(DashboardController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return PopScope(
        canPop: controller.canPop.value,
        onPopInvokedWithResult: controller.onWillPop,
        child: Scaffold(
            body: screens[controller.pageIndex.value],
            extendBody: true,
            bottomSheet: BottomSheet(
              onClosing: () {},
              builder: (BuildContext context) => Container(
                  height: 80,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(40)),
                  padding: EdgeInsets.zero,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buttonView(image: BaseAssets.homeIc, index: 0),
                        buttonView(image: BaseAssets.notificationIc, index: 1),
                        buttonView(image: BaseAssets.personIc, index: 2),
                      ])),
            )),
      );
    });
  }

  Widget buttonView({required String image, required int index, Color? color}) {
    return InkWell(
        onTap: () {
          controller.pageIndex.value = index;
        },
        child: SizedBox(
          height: 50,
          width: 50,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              SvgPicture.asset(
                image,
                height: 24,
                width: 24,
                colorFilter: ColorFilter.mode(
                    controller.pageIndex.value == index
                        ? BaseColors.redClr
                        : BaseColors.greyTextColor,
                    BlendMode.srcIn),
              ).marginOnly(top: 2, bottom: 2),
            ],
          ),
        ));
  }
}


