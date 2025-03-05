import 'package:cray/UI/auth_screen/verify_otp_screen.dart';
import 'package:cray/backend/api_end_points.dart';
import 'package:cray/backend/base_api_service.dart';
import 'package:cray/backend/base_success_response.dart';
import 'package:cray/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestOtpController extends GetxController{
  final GlobalKey<FormState> formKeyRequestOtp = GlobalKey<FormState>();
  final TextEditingController emailOtpController = TextEditingController();


  changePassword( flowType ){
    Map<String, String> data = {
      "email": emailOtpController.text.trim(),
    };
    BaseApiService().post(apiEndPoint: ApiEndPoints().forgotPasswordApi, data: data).then((value){
      if (value?.statusCode ==  200) {
        BaseSuccessResponse response = BaseSuccessResponse.fromJson(value?.data);
        if (response.success??false) {
          triggerHapticFeedback();
          Get.to(() => VerifyOtpScreen(flowType: flowType, email: emailOtpController.text.trim(),));
          showSnackBar(subtitle: response.message??"", isSuccess: true);
        }else{
          showSnackBar(subtitle: response.message??"");
        }
      }else{
        showSnackBar(subtitle: "Something went wrong, please try again");
      }
    });
  }
}