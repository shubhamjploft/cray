import 'package:cray/base_components/base_scaffold_background.dart';
import 'package:cray/base_components/base_text.dart';
import 'package:cray/controller/notification_controller.dart';
import 'package:cray/utils/base_colors.dart';
import 'package:cray/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final NotificationController controller = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [BaseColors.white, BaseColors.lightPink],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: BaseScaffoldBackground(
            child: Column(
              children: [
                buildSizeHeight(40),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BaseText(
                          value: "Notification",
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w400),
                    ],
                  ),
                ),
                Expanded(
                  child: Obx(
                    () => controller.items.isEmpty
                        ? const Center(
                            child: BaseText(
                                value: "No notifications",
                                fontSize: 16,
                                color: Colors.grey),
                          )
                        : ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: controller.items.length,
                            itemBuilder: (context, index) {
                              return AnimatedOpacity(
                                duration: const Duration(milliseconds: 300),
                                opacity: 1.0,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  child: Slidable(
                                    key: ValueKey(controller.items[index]),
                                    endActionPane: ActionPane(
                                      motion: const ScrollMotion(),
                                      extentRatio: 0.2,
                                      children: [
                                        buildSizeWidth(10),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() => controller.items
                                                .removeAt(index));
                                          },
                                          child: Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                              color: Colors.redAccent,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: const Icon(
                                                CupertinoIcons.delete,
                                                color: Colors.white,
                                                size: 22),
                                          ),
                                        ),
                                      ],
                                    ),
                                    child: AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.05),
                                            blurRadius: 6,
                                            offset: const Offset(0, 4),
                                          )
                                        ],
                                      ),
                                      child: ListTile(
                                        title: BaseText(
                                            value: controller.items[index],
                                            textAlign: TextAlign.start,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                        subtitle: const BaseText(
                                            value: "Just now",
                                            fontSize: 12,
                                            color: Colors.grey),
                                        leading: const CircleAvatar(
                                          backgroundColor:
                                              BaseColors.lightGreen,
                                          child: Icon(CupertinoIcons.bell_fill,
                                              color: BaseColors.primaryColor,
                                              size: 20),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ),
                buildSizeHeight(75),
              ],
            ),
          ),
        ));
  }
}
