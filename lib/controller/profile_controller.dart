import 'dart:io';

import 'package:cray/backend/api_end_points.dart';
import 'package:cray/backend/base_api_service.dart';
import 'package:cray/model/edit_profile_response.dart';
import 'package:cray/model/get_profile_response.dart';
import 'package:cray/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

class ProfileController extends GetxController {
  @override
  onInit() {
    super.onInit();
    getProfileDetail();
  }


  Rx<File?> selectedImage = Rx<File?>(null);
  RxString imageError = "".obs;
  RxString imageNet = "".obs;
  final TextEditingController firstNameController = TextEditingController(),
      lastNameController = TextEditingController(),
      numberController = TextEditingController(),
      linkdinController = TextEditingController(),
      facebookController = TextEditingController();
      RxString userProfileImg = "".obs;
      Rxn<ProfileData> profileData = Rxn<ProfileData>();

  void setData() {
    firstNameController.text = profileData.value?.firstName ?? "";
    lastNameController.text = profileData.value?.lastName ?? "";
    numberController.text = profileData.value?.mobileNumber ?? "";
    linkdinController.text = profileData.value?.linkedinProfile ?? "";
    facebookController.text = profileData.value?.facebookProfile ?? "";
    userProfileImg.value = profileData.value?.profilePicture ?? "";
  }

  // profile Api
  getProfileDetail() async {
    await BaseApiService()
        .get(apiEndPoint: ApiEndPoints().getUserProfileApi)
        .then((dynamic value) {
      if (value?.statusCode == 200) {
        GetProfileResponse response = GetProfileResponse.fromJson(value?.data);
        if (response.success ?? false) {
          profileData.value = response.data ?? profileData();
          setData();
        } else {
          showSnackBar(subtitle: response.message ?? "");
        }
      } else {
        showSnackBar(subtitle: "Something went wrong, please try again");
      }
      update();
    });
  }

//edit profile details

  editProfileDetail() async {
    dio.FormData formData = dio.FormData.fromMap({
      "firstName": firstNameController.text.trim(),
      "lastName": lastNameController.text.trim(),
      "mobileNumber": numberController.text.trim(),
      "linkedinProfile": linkdinController.text.trim(),
      "facebookProfile": facebookController.text.trim(),
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
        .post(apiEndPoint: ApiEndPoints().userEditProfileApi, data: formData)
        .then((dynamic value) {
      if (value?.statusCode == 200) {
        EditProfileResponse response =
            EditProfileResponse.fromJson(value?.data);
        if (response.success ?? false) {
           getProfileDetail();
           Get.back();
          // Get.to(() =>  AddPartnerSocialMedia(partnerSocialId: response.data?.id,));
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
