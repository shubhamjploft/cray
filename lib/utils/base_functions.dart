
import 'dart:io';
import 'package:cray/UI/auth_screen/login_screen.dart';
import 'package:cray/utils/storage_keys.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../base_components/base_text.dart';
import 'base_colors.dart';
import 'base_variables.dart';
import 'get_storage.dart';

enum AuthFlowType { signup, forgotPassword }

triggerHapticFeedback() {
  if (Platform.isAndroid) {
    HapticFeedback.vibrate();
  } else {
    HapticFeedback.lightImpact();
  }
}
// ignore: prefer_typing_uninitialized_variables
var currentBackPressTime;

XFile? pickedFile;

Future<bool> onWillPop() {
  DateTime now = DateTime.now();
  if (currentBackPressTime == null ||
      now.difference(currentBackPressTime) > const Duration(seconds: 2)) {
    currentBackPressTime = now;
    Fluttertoast.showToast(msg: 'Press back again to exit');
    return Future.value(false);
  }
  currentBackPressTime = null;
  return Future.value(true);
}
void clearSessionData() {
  triggerHapticFeedback();
  // BaseStorage.box.erase();
  Get.offAll(() => const LoginScreen());
}

String getLastFourDigits(String id) {
  if (id.length <= 4) {
    return id;
  } else {
    return id.substring(id.length - 4);
  }
}
// MaskTextInputFormatter usPhoneMask = MaskTextInputFormatter(
//     mask: '(###) ###-####',
//     filter: {"#": RegExp(r'[0-9]')},
//     type: MaskAutoCompletionType.lazy);

SizedBox buildSizeHeight(double height) {
  return SizedBox(
    height: height,
  );
}

SizedBox buildSizeWidth(double width) {
  return SizedBox(
    width: width,
  );
}

const String parsingError =
    "Some Error occoured while parsing data, Please try again later.";

String formatBackendDate(String dateString, {bool? getDayFirst}) {
  if (dateString.isNotEmpty && dateString != "null") {
    DateTime date = DateTime.parse(dateString);
    String day = date.day.toString().padLeft(2, '0');
    String month = date.month.toString().padLeft(2, '0');
    String year = date.year.toString();
    int hour24 = date.hour; // 24-hour format
    String minute = date.minute.toString().padLeft(2, '0');

    // Determine AM/PM
    String amPm = hour24 >= 12 ? 'PM' : 'AM';

    // Convert to 12-hour format
    int hour12 = hour24 % 12;
    hour12 = hour12 == 0 ? 12 : hour12;

    String formattedDate;
    if (getDayFirst ?? true) {
      formattedDate = '$day-$month-$year';
    } else {
      formattedDate = '$year-$month-$day';
    }

    // Return formatted date with time in 12-hour format with AM/PM
    return '$formattedDate $hour12:$minute $amPm';
  } else {
    return "";
  }
}

String formatBackendTime(String date) {
  if (date.isEmpty) return ""; // Handle empty date
  final parsedDate = DateTime.parse(date);
  final formatter = DateFormat('hh:mm a'); // Use 'HH:mm' for 24-hour format
  return formatter.format(parsedDate);
}

///////////////////////////
String inFormat = "yyyy-MM-dd HH:mm:ss";
// ignore: non_constant_identifier_names
String IsoFormat = "yyyy-MM-ddThh:mm:ss";
String outFormat = "dd MMM yyyy";
String inFormat1 = "yyyy-MM-dd";
String outFormat1 = "dd-MM-yyyy";
String outFormat2 = "dd MMM";
String outFormat3 = "dd MMM yyyy, HH:mm a";
String outFormat4 = "dd MMM yyyy, hh:mm a";
String outFormat5 = "dd MMM yyyy, h:mm a";
// ignore: non_constant_identifier_names
String F12_Hours = "h:mm a";
String outFormat6 = "dd MMM yyyy • h:mm a";
String time = "dd MMM, h:mm a";
formatDateFromString(String? date, {String? input, String? output}) {
  if((date ?? "").isEmpty) return "";
  var inputDate = DateFormat(input ?? inFormat).parse(date.toString(), true).toLocal();
  var outputDate = DateFormat(output ?? outFormat).format(inputDate);
  return outputDate.toString();
}
extension IsUser on String {
  bool isUser() {
    if(this == BaseStorage.read(StorageKeys.user)){
      return true;
    }
    return false;
  }
}
///////////////////////////

Future<File?> showMediaPicker({bool? isCropEnabled}) async {
  FocusManager.instance.primaryFocus?.unfocus();
  File? pickedFile;

  await Get.bottomSheet(
    Container(
        alignment: Alignment.center,
        height: 150,
        margin: const EdgeInsets.symmetric(
            horizontal: horizontalScreenPadding,
            vertical: horizontalScreenPadding),
        padding: const EdgeInsets.only(
            top: 5,
            right: horizontalScreenPadding,
            left: horizontalScreenPadding),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            Container(
              width: 100,
              height: 4,
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(30)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () async {
                      pickedFile = await chooseCameraFile(isCropEnabled); // Direct assignment using await
                      if (Get.isBottomSheetOpen ?? false) {
                        Get.back();
                      }
                    },
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.camera_alt_outlined,
                            color: BaseColors.greyTextColor, size: 60),
                        BaseText(
                          topMargin: 10,
                          value: "Camera",
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () async {
                      pickedFile = await chooseGalleryFile(isCropEnabled);
                      if (Get.isBottomSheetOpen ?? false) {
                        Get.back();
                      }
                    },
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.photo_library_outlined,
                            color: BaseColors.greyTextColor, size: 60),
                        BaseText(
                          topMargin: 10,
                          value: "Gallery",
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        )),
    backgroundColor: Colors.transparent,
  );

  return File(pickedFile?.path??"");
}



Future<File?> chooseCameraFile(bool? isCropEnabled) async {
  final ImagePicker imgPicker = ImagePicker();
  File? files;
  dynamic chosenFile;
  await imgPicker.pickImage(source: ImageSource.camera).then((XFile? value) async {
    if (value != null) {
      if (isCropEnabled ?? false) {
        chosenFile = await cropImage(
          File(value.path),
        );
      } else {
        chosenFile = File(value.path);
      }
    }
  });
  if (chosenFile != null) {
    files = File(chosenFile?.path ?? "");
  }
  return files;
}

Future<File?> chooseGalleryFile(bool? isCropEnabled) async {
  final ImagePicker imgPicker = ImagePicker();
  File? files;
  dynamic chooseFile;
  await imgPicker.pickImage(source: ImageSource.gallery).then((XFile? value) async {
    if (value != null) {
      if (isCropEnabled ?? false) {
        chooseFile = await cropImage(
          File(value.path),
        );
      } else {
        chooseFile = File(value.path);
      }
    }
  });
  if (chooseFile != null) {
    files = File(chooseFile?.path ?? "");
  }
  return files;
}

Future<CroppedFile?> cropImage(File imageFile) async {
  CroppedFile? croppedFile;
  await ImageCropper()
      .cropImage(
    sourcePath: imageFile.path,
    aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
    uiSettings: [
      AndroidUiSettings(
          toolbarTitle: 'Cropper',
          activeControlsWidgetColor: Colors.black,
          toolbarColor: CupertinoColors.white,
          toolbarWidgetColor: Colors.black,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: true),
      IOSUiSettings(
          title: 'Cropper',
          rotateButtonsHidden: true,
          aspectRatioLockEnabled: true),
    ],
  )
      .then((CroppedFile? value) {
    croppedFile = value;
  });
  return croppedFile;
}

void showBaseLoader({bool? showLoader}) {
  if (showLoader ?? true) {
    Get.context!.loaderOverlay.show();
    Future.delayed(const Duration(seconds: apiTimeOut), () {
      Get.context!.loaderOverlay.hide();
    });
  }
}
//
void dismissBaseLoader({bool? showLoader}) {
  if (showLoader ?? true) {
    Get.context!.loaderOverlay.hide();
  }
}

showSnackBar(
    {bool? isSuccess, String? title, String? subtitle, BuildContext? context}) {
  if (Get.isSnackbarOpen) {
    Get.closeAllSnackbars();
  } else {
    Get.snackbar(
      "",
      "",
      padding: const EdgeInsets.only(left: 24, right: 18, top: 24, bottom: 24),
      titleText: Row(
        children: [
          Expanded(
            child: BaseText(
              value: (title ?? "").isEmpty
                  ? (isSuccess ?? false)
                  ? "Success!"
                  : "Error!"
                  : title ?? "",
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          GestureDetector(
            onTap: () {
              triggerHapticFeedback();
              Get.closeCurrentSnackbar();
            },
            child: const Icon(
              Icons.close,
              color: Colors.white,
              size: 20,
            ),
          ),
        ],
      ),
      messageText: BaseText(
        value: subtitle ?? "",
        fontSize: 13,
        color: Colors.white,
        fontWeight: FontWeight.w400,
      ),
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.only(
          right: horizontalScreenPadding,
          left: horizontalScreenPadding,
          top: 18),
      backgroundColor: (isSuccess ?? false)
          ? BaseColors.primaryColor.withOpacity(0.8)
          : Colors.red.withOpacity(0.8),
      colorText: Colors.white,
    );
  }


  // Widget cachedNetworkImage(
  // {required String image,
  //   BoxFit? fit,
  //   Alignment? alignment,
  //   double? height,
  //   double? width,
  //   double? borderRadius}) {
  //   return ClipRRect(
  //     borderRadius: BorderRadius.circular(borderRadius ?? 0),
  //     child: CachedNetworkImage(
  //         imageUrl: image,
  //         fit: fit ?? BoxFit.cover,
  //         alignment: alignment ?? Alignment.topCenter,
  //         height: height ?? 100,
  //         width: width ?? 100,
  //         // progressIndicatorBuilder: (context, url, progress) => BaseShimmer(
  //         //       height: height ?? 100,
  //         //       width: width ?? 100,
  //         //     ),
  //         placeholder: (context, url) =>
  //             BaseShimmer(
  //               height: height ?? 100,
  //               width: width ?? 100,
  //               borderRadius: 0,
  //             ),
  //         repeat: ImageRepeat.noRepeat,
  //         errorWidget: (context, url, error) =>
  //             Container(
  //               height: height ?? 100,
  //               width: width ?? 100,
  //               decoration: const BoxDecoration(color: BaseColors.gradient1),
  //               child: Padding(
  //                 padding: const EdgeInsets.all(20),
  //                 child: Image.asset(
  //                   BaseAssets.noDataImg,
  //                 ),
  //               ),
  //             )),
  //   );
  // }

  // Future<String> showBaseDatePicker(BuildContext context,
  //     {DateTime? firstDate, DateTime? lastDate}) async {
  //   FocusManager.instance.primaryFocus?.unfocus();
  //   DateTime? selectedDate = DateTime.now();
  //   final DateTime? picked = await showDatePicker(
  //     barrierDismissible: false,
  //     context: context,
  //     initialDate: firstDate ?? selectedDate,
  //     firstDate: firstDate ?? DateTime(1900),
  //     // initialEntryMode: DatePickerEntryMode.calendarOnly,
  //     builder: (context, child) {
  //       return Theme(
  //         data: ThemeData.light().copyWith(
  //           colorScheme: const ColorScheme.light(
  //             primary: BaseColors.lightPink,
  //             onPrimary: Colors.white,
  //             surface: Colors.white,
  //             onSurface: BaseColors.lightPink,
  //           ),
  //           dialogBackgroundColor: Colors.white,
  //         ),
  //         child: child!,
  //       );
  //     },
  //     lastDate: lastDate ?? DateTime(2100),
  //   );
  //   if (picked != null && picked != selectedDate) {
  //     selectedDate = picked;
  //
  //     return "${picked.day.toString().padLeft(2, '0')}-${picked.month.toString()
  //         .padLeft(2, '0')}-${picked.year.toString().padLeft(2, '0')}";
  //   } else {
  //     return "";
  //   }
  // }

  // DateTime changeToDateTime({required String dateString}) {
  //   DateFormat dateFormat = DateFormat("dd-MM-yyyy");
  //   DateTime dateTime = dateFormat.parse(dateString);
  //   // dPrint("${dateTime}");
  //   return dateTime;
  // }
  //
  // String formatDateTime(DateTime dateTime) {
  //   // Define the format you want
  //   final DateFormat formatter = DateFormat('dd-MM-yyyy');
  //   // Use the format method to convert the DateTime to a string
  //   return formatter.format(dateTime);
  // }
  //
  // String formatDate(String dateString) {
  //   if (dateString.isEmpty) return "";
  //   try {
  //     DateTime parsedDate = DateTime.parse(dateString);
  //     return DateFormat('dd MMM').format(parsedDate);
  //   } catch (e) {
  //     return dateString;
  //   }
  // }
  //
  // String formatTimeOfDay(TimeOfDay time) {
  //   final now = DateTime.now();
  //   final dateTime =
  //   DateTime(now.year, now.month, now.day, time.hour, time.minute);
  //   return DateFormat('HH:mm').format(dateTime);
  // }
  //
  //
  // String formatTime(String createdAt) {
  //   try {
  //     DateTime dateTime = DateTime.parse(createdAt);
  //     // Format as 'HH:mm a' (e.g., '10:45 AM')
  //     String formattedTime = DateFormat.jm().format(dateTime);
  //     return formattedTime; // e.g., 10:45 AM
  //   } catch (e) {
  //     return 'Invalid Date';
  //   }
  // }
  //
  // Future<TimeOfDay?> showBaseTimePicker(
  //     {required BuildContext context, TimeOfDay? initialTime}) {
  //   Future<TimeOfDay?> selectedTime = showTimePicker(
  //       initialTime: initialTime ?? TimeOfDay.now(),
  //       context: context,
  //       builder: (context, child) {
  //         return Theme(
  //           data: ThemeData.light().copyWith(
  //             colorScheme: const ColorScheme.light(
  //               primary: BaseColors.primaryColor,
  //               secondary: BaseColors.primaryColor,
  //               onPrimary: Colors.white,
  //               surface: Colors.white,
  //               onSurface: BaseColors.primaryColor,
  //             ),
  //             dialogBackgroundColor: Colors.white,
  //           ),
  //           child: child!,
  //         );
  //       });
  //   return selectedTime;
  // }

// void checkDriverScreen({required ProfileData profileData}) {
//   if (profileData.addressData == null) {
//     Get.offAll(() => const CompleteKycScreen());
//   } else if (profileData.addressData != null &&
//       profileData.driverData == null) {
//     Get.offAll(const IdentityProofScreen());
//   } else if (profileData.driverData != null && profileData.bankData == null) {
//     Get.offAll(const BankDetails());
//   } else if (profileData.bankData != null && profileData.vehicleData == null) {
//     Get.offAll(const VehicleInfoScreen());
//   } else {
//     BaseStorage.write(
//       StorageKeys.kycDetails,
//       "3",
//     );
//     Get.offAll(() => const DriverDashboardScreen());
//   }
// }

// String checkAddressType({required String type}) {
//   List<Map<String, dynamic>> addressTypeList = [
//     {'title': 'Home', 'type': 301},
//     {'title': 'Work', 'type': 302},
//     {'title': 'Friends & Family', 'type': 303},
//     {'title': 'Other', 'type': 304},
//   ];
//
//   String addressType = '';
//
//   addressTypeList.map((e) {
//     if (e['type'].toString() == type) {
//       addressType = e['title'].toString();
//     }
//   }).toList();
//   return addressType;
// }

  // void dPrint(String s) {
  //   if (kDebugMode) {
  //     print(s);
  //   }
  // }
}