import 'package:cray/UI/auth_screen/verify_otp_screen.dart';
import 'package:cray/backend/api_end_points.dart';
import 'package:cray/backend/base_api_service.dart';
import 'package:cray/backend/base_success_response.dart';
import 'package:cray/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController{
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool isRememberMe = false.obs;
  RxBool isLoading = false.obs;

  clearCreateDataData() {
    firstNameController.text = "";
    lastNameController.text = "";
    emailController.text = "";
    phoneController.text="";
    passwordController.text="";
  }



  userSignUpApi() async {
    if (isLoading.value) return;
    isLoading.value = true;

    Map<String, dynamic> data = {
      "firstName": firstNameController.text.trim(),
      "lastName": lastNameController.text.trim(),
      "email": emailController.text.trim(),
      "password": passwordController.text.trim(),
      "mobileNumber": phoneController.text.trim(),
    };

    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().userSignUpApi, data: data,sendHeaders: false)
        .then((dynamic value) {
      isLoading.value = false;

      if (value?.statusCode == 200) {
        try {
          BaseSuccessResponse response = BaseSuccessResponse.fromJson(value?.data);
          if (response.success ?? false) {
            showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            Get.off(() => VerifyOtpScreen(
              flowType: AuthFlowType.signup,
              email: emailController.text.trim(),
            ));
            // clearCreateDataData();
          } else {
            showSnackBar(subtitle: response.message ?? "");
          }
        } catch (e) {
          showSnackBar(subtitle: parsingError);
        }
      } else {
        showSnackBar(subtitle: "Something went wrong, please try again");
      }
    }).catchError((error) {
      isLoading.value = false;
      showSnackBar(subtitle: "Network error, please try again");
    });
  }


}
