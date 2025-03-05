import 'package:cray/backend/api_end_points.dart';
import 'package:cray/backend/base_api_service.dart';
import 'package:cray/model/partener_social_media_response.dart';
import 'package:cray/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../UI/screens/start_assessment_successfully.dart';

class AddPartnerSocialMediaController extends GetxController{

  final TextEditingController facebookAccountCtrl = TextEditingController(),
      linkdinAccountCtrl = TextEditingController();

  addPartnerSocialMediaApi({String? partnerId}) async {
    Map<String, dynamic> data = {
      "partnerId": partnerId,
      "linkedinProfile": linkdinAccountCtrl.text.trim(),
      "facebookProfile": facebookAccountCtrl.text.trim(),
    };
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().partnerSocialAccountApi, data: data)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          PartnerSocialMediaResponse response = PartnerSocialMediaResponse.fromJson(value?.data);
          if (response.success ?? false) {
            Get.to(() =>  StartAssessmentSuccessfully(partnerId: partnerId,));
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