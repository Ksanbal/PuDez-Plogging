import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:pudez_plogging/src/common/font.family.dart';
import 'package:pudez_plogging/src/controllers/home/home.controller.dart';
import 'package:pudez_plogging/src/controllers/onboarding/onboarding.controller.dart';
import 'package:pudez_plogging/src/views/home/home.view.dart';
import 'package:pudez_plogging/src/views/onboarding/onboarding.view.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());

  Future.delayed(const Duration(seconds: 2)).then((value) {
    FlutterNativeSplash.remove();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/onboarding',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: FontFamily.pretendard,
        primaryColor: Colors.white,
      ),
      getPages: [
        GetPage(
          name: '/onboarding',
          page: () => const OnboardingView(),
          binding: BindingsBuilder(() {
            Get.put(OnboardingController());
          }),
        ),
        GetPage(
          name: '/home',
          page: () => const HomeView(),
          binding: BindingsBuilder(() {
            Get.put(HomeController());
          }),
        ),
      ],
    );
  }
}

/// Global variables

/// 선택한 캐릭터
///
/// 0: 초록, 1: 회색, 2: 빨강, 3: 랜덤
int character = 3;
