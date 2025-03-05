import 'package:cray/UI/dashboard_screen/dashboard_screen.dart';
import 'package:cray/backend/api_end_points.dart';
import 'package:cray/backend/base_api_service.dart';
import 'package:cray/model/login_response.dart';
import 'package:cray/utils/base_functions.dart';
import 'package:cray/utils/get_storage.dart';
import 'package:cray/utils/storage_keys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{

  @override
  void onInit() {
    super.onInit();

    String? savedEmail = BaseStorage.read(StorageKeys.isEmail);
    String? savedPassword = BaseStorage.read(StorageKeys.isPassword);

    if (savedEmail != null && savedPassword != null) {
      emailController.text = savedEmail;
      passwordController.text = savedPassword;
      isRememberMe.value = true;
    }
  }

  final TextEditingController emailController = TextEditingController(),
      passwordController = TextEditingController();

  RxBool isRememberMe = false.obs;

  userLoginApi() async {
      Map<String, dynamic> data = {
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
      };

      BaseApiService()
          .post(apiEndPoint: ApiEndPoints().userLoginApi, data: data)
          .then((value) {
        if (value?.statusCode == 200) {
          try {
            LoginResponse response = LoginResponse.fromJson(value?.data);
            if (response.success ?? false) {
              BaseStorage.write(StorageKeys.apiToken, response.token?.toString() ?? "");
              BaseStorage.write(StorageKeys.user, response.user?.toString() ?? "");
              BaseStorage.write(StorageKeys.userId, response.user?.id?.toString() ?? "");
              BaseStorage.write(StorageKeys.isLogin, true);
              if (isRememberMe.value) {
                BaseStorage.write(StorageKeys.isEmail, emailController.text.trim());
                BaseStorage.write(StorageKeys.isPassword, passwordController.text.trim());
              } else {
                BaseStorage.remove(StorageKeys.isEmail);
                BaseStorage.remove(StorageKeys.isPassword);
              }

              Get.to(() => const DashboardScreen());
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