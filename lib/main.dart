import 'package:cray/utils/base_colors.dart';
import 'package:cray/utils/base_localization.dart';
import 'package:cray/utils/base_main_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:scaled_app/scaled_app.dart';

import 'UI/splash_screen/splash_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

void main() {
  ScaledWidgetsFlutterBinding.ensureInitialized(
    scaleFactor: (deviceSize) {
      const double widthOfDesign = 375;
      return deviceSize.width / widthOfDesign;
    },
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) {
    runApp(const MyApp());
  });
}
class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    initDotEnv();
    super.initState();
  }

  initDotEnv() async {
    await dotenv.load(fileName: ".env");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if ((FocusManager.instance.primaryFocus?.hasFocus ?? false)) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: GetMaterialApp(
        title: 'Cray',
        debugShowCheckedModeBanner: false,
        translations: BaseLocalization(),
        locale: const Locale('en', 'US'),
        fallbackLocale: const Locale('en', 'US'),
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: const TextScaler.linear(1.0)),
              child: BaseMainBuilder(
                context: context,
                child: child,
              ));
        },
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: BaseColors.white),
          bottomSheetTheme: const BottomSheetThemeData(
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
          ),
          primaryColorLight: BaseColors.white,
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.transparent,
          fontFamily:'poppins',
          pageTransitionsTheme: const PageTransitionsTheme(builders: {
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder()
          }),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
