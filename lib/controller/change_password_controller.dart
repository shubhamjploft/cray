import 'package:cray/backend/api_end_points.dart';
import 'package:cray/backend/base_api_service.dart';
import 'package:cray/backend/base_success_response.dart';
import 'package:cray/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  RxBool obscureChangePassword = true.obs;
  RxBool obscureChangeCnfrmPassword = true.obs;
  RxBool obscurePassword = true.obs;
  final TextEditingController emailCtrl = TextEditingController(),
      newPasswordCtrl = TextEditingController();

  changePassword() {
    Map<String, String> data = {
      "email": emailCtrl.text.trim(),
      "newPassword": newPasswordCtrl.text.trim()
    };
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().changePasswordApi, data: data)
        .then((dynamic value) {
      if (value?.statusCode == 200) {
        BaseSuccessResponse response =
            BaseSuccessResponse.fromJson(value?.data);
        if (response.success ?? false) {
          triggerHapticFeedback();
          // Get.to(() => VerifyOtpScreen(flowType: flowType));
          showSnackBar(subtitle: response.message ?? "", isSuccess: true);
        } else {
          showSnackBar(subtitle: response.message ?? "");
        }
      } else {
        showSnackBar(subtitle: "Something went wrong, please try again");
      }
    });
  }
}
