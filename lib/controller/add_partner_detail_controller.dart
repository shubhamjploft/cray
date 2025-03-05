import 'dart:io';
import 'package:cray/UI/screens/add_partner_social_media.dart';
import 'package:cray/backend/api_end_points.dart';
import 'package:cray/backend/base_api_service.dart';
import 'package:cray/model/partener_social_media_response.dart';
import 'package:cray/utils/base_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

class AddPartnerDetailController extends GetxController {
  Rx<File?> selectedImage = Rx<File?>(null);
  RxString imageError = "".obs;
  RxString imageNet = "".obs;

  final TextEditingController firstNameCtrl = TextEditingController(),
      lastNameCtrl = TextEditingController(),
      emailAddressCtrl = TextEditingController(),
      phoneCtrl = TextEditingController(),
      ageCtrl = TextEditingController(),
      ethnicityCtrl = TextEditingController(),
      uploadPictureCtrl = TextEditingController();

  addPartnerDetail() async {
    dio.FormData formData = dio.FormData.fromMap({
      "firstName": firstNameCtrl.text.trim(),
      "lastName": lastNameCtrl.text.trim(),
      "email": emailAddressCtrl.text.trim(),
      "age": ageCtrl.text.trim(),
      "mobileNumber": phoneCtrl.text.trim(),
      "ethnicity": ethnicityCtrl.text.trim(),
      "profilePicture": uploadPictureCtrl.text.trim(),
    });

    if (selectedImage.value != null) {
      formData.files.add(MapEntry(
        "profilePicture",
        await dio.MultipartFile.fromFile(
          selectedImage.value!.path,
          filename: selectedImage.value!.path.split('/').last,
        ),
      ));
    }
    await BaseApiService()
        .post(apiEndPoint: ApiEndPoints().partnerDetailApi, data: formData)
        .then((value) {
      if (value?.statusCode == 200) {
        PartnerSocialMediaResponse response =
            PartnerSocialMediaResponse.fromJson(value?.data);
        if (response.success ?? false) {
          // Get.back(result: true);
          Get.to(() => AddPartnerSocialMedia(
                partnerSocialId: response.data?.id,
              ));
          showSnackBar(subtitle: response.message ?? "", isSuccess: true);
        } else {
          showSnackBar(subtitle: response.message ?? "");
        }
      } else {
        showSnackBar(subtitle: "Something went wrong, please try again");
      }
      update();
    });
  }
}
