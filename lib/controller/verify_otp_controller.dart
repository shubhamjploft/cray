import 'package:cray/UI/auth_screen/change_password_screen.dart';
import 'package:cray/UI/screens/social_media_account_screen.dart';
import 'package:cray/backend/api_end_points.dart';
import 'package:cray/backend/base_api_service.dart';
import 'package:cray/backend/base_success_response.dart';
import 'package:cray/model/verify_otp_response.dart';
import 'package:cray/utils/base_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class VerifyOtpController extends GetxController {
  RxString otp = ''.obs;
  RxBool countdownShow = true.obs;
  TextEditingController otpController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    otpController.addListener(() {
      otp.value = otpController.text;
    });
  }

  @override
  void onClose() {
    otpController.dispose();
    super.onClose();
  }


  verifyOtpApi( AuthFlowType flowType ,{ required String isEmail}) {
    Map<String, dynamic> data = {
      "otp":otpController.text.trim(),
      "email":isEmail,
    };
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().otpVerifyApi, data: data,sendHeaders: false)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          VerifyOtpResponse response = VerifyOtpResponse.fromJson(value?.data);
          if (response.success ?? false) {
            showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            switch (flowType) {
              case AuthFlowType.signup:
                // print("Navigating to SocialMediaAccountScreen");
                Get.to(() =>  SocialMediaAccountScreen(userSocialId: response.data?.id,));
                break;
              case AuthFlowType.forgotPassword:
                // print("Navigating to ChangePasswordScreen");
                Get.off(() => const ChangePasswordScreen());
                break;
            }
          } else {
            showSnackBar(subtitle: response.message ?? "");
          }
        } catch (e) {
          showSnackBar(subtitle: parsingError);
        }
      } else {
        showSnackBar(subtitle: "Something went wrong, please try again");
      }
    });
  }


  //resend otp Api

  Future<void> resendOtp({required String isEmail}) async {
    Map<String, String> data = {
      "email": isEmail,
    };
    await BaseApiService()
        .post(apiEndPoint: ApiEndPoints().emailResendApi, data: data)
        .then((  value) {
      if (value?.statusCode == 200) {
        try {
          BaseSuccessResponse response = BaseSuccessResponse.fromJson(value?.data);
          if (response.success ?? false) {
            countdownShow.value = true;
            showSnackBar(subtitle: response.message ?? "", isSuccess: true);
          } else {
            showSnackBar(subtitle: response.message ?? "");
          }
        } catch (e) {
          showSnackBar(subtitle: parsingError);
        }
      } else {
        showSnackBar(subtitle: "Something went wrong, please try again");
      }
      update();
    });
  }



}
