import 'package:cray/UI/auth_screen/login_screen.dart';
import 'package:cray/backend/api_end_points.dart';
import 'package:cray/backend/base_api_service.dart';
import 'package:cray/model/user_social_media_response.dart';
import 'package:cray/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddSocialMediaController extends GetxController{

  final TextEditingController facebookAccountCtrl = TextEditingController(),
      linkdinAccountCtrl = TextEditingController();

  addUserSocialMediaApi({String? userId}) async {
    Map<String, dynamic> data = {
      "userId": userId,
      "linkedinProfile": linkdinAccountCtrl.text.trim(),
      "facebookProfile": facebookAccountCtrl.text.trim(),
    };
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().userAddAccountApi, data: data)
        .then((dynamic value) {
      if (value?.statusCode == 200) {
        try {
          UserSocialMediaResponse response = UserSocialMediaResponse.fromJson(value?.data);
          if (response.success ?? false) {
            Get.off(const LoginScreen());
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
}