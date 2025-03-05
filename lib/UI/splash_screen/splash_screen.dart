import 'package:cray/UI/auth_screen/login_screen.dart';
import 'package:cray/UI/dashboard_screen/dashboard_screen.dart';
import 'package:cray/utils/get_storage.dart';
import 'package:cray/utils/storage_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../utils/base_assets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timestamp) async {
      await initGetStorage();
      if (mounted) {
        FocusManager.instance.primaryFocus?.unfocus();
      }

      if (mounted) {
        FocusManager.instance.primaryFocus?.unfocus();
      }

      Future.delayed(const Duration(seconds: 3), () async {
        if ((BaseStorage.read(StorageKeys.isLogin) ?? false)) {
          Get.offAll(() => const DashboardScreen());
        } else {
          Get.offAll(() => const LoginScreen());
        }
      });
    });
  }

  initGetStorage() async {
    await GetStorage.init('MyStorage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body:  Stack(
          alignment: Alignment.center,
          children: [
            SvgPicture.asset(BaseAssets.backgroundIc, fit: BoxFit.cover),
            SvgPicture.asset(BaseAssets.logoIc),
          ],
        )

    );
  }
}
